---
icon: clone
---

# Cloudflare Tunnel: Replicas and High Availability

### 1. Introduction

High availability (HA) is an important requirement in modern infrastructure environments. Applications must remain accessible even when individual servers, network connections, or infrastructure components experience failures.

Cloudflare Tunnel provides a secure way to connect private infrastructure to Cloudflare's global network without exposing origin servers through publicly accessible inbound ports.

However, running only one `cloudflared` instance can introduce a single point of failure at the connector-host level.

To address this, Cloudflare supports **Tunnel Replicas**, which allow multiple instances of `cloudflared` to connect to the same Cloudflare Tunnel.

This article explains how Cloudflare Tunnel replicas work, how they improve availability, how Cloudflare handles requests across replicas, and what to consider when implementing this architecture in production.

### 2. Understanding Cloudflare Tunnel

Cloudflare Tunnel establishes a secure, outbound-only connection between your infrastructure and Cloudflare's global network.

It uses a lightweight connector called `cloudflared`, which runs on a server or another machine inside your private network.

Traditionally, publishing an application hosted on an internal Windows Server might require:

* A public IP address.
* Firewall rules allowing inbound HTTP/HTTPS traffic.
* NAT or port forwarding.
* DNS configuration pointing to the public IP address.

With Cloudflare Tunnel, the connector initiates outbound connections to Cloudflare instead.

This allows Cloudflare to route incoming application requests through the established tunnel to the configured origin service.

#### Basic architecture

```
             Internet User
                   |
                   |
             Cloudflare Edge
                   |
                   |
           Cloudflare Tunnel
                   |
                   |
              cloudflared
                   |
                   |
           Private Application
              IIS / API
```

The important distinction is that the origin server does not need to accept direct inbound connections from the public internet.

The firewall can follow an outbound-only security model for tunnel connectivity.

### 3. What Are Cloudflare Tunnel Replicas?

A replica is an additional instance of `cloudflared` that connects to an existing Cloudflare Tunnel.

Instead of deploying a single connector on one server, you can deploy multiple connector instances on different hosts.

All replicas share the same tunnel identity.

For example, consider the following infrastructure:

| Host   | Connector   | Tunnel    |
| ------ | ----------- | --------- |
| Host A | cloudflared | tunnel-01 |
| Host B | cloudflared | tunnel-01 |

In this architecture:

* Host A runs the first `cloudflared` instance.
* Host B runs another `cloudflared` instance.
* Both connectors use the same tunnel credentials or tunnel identity.
* Both establish connections to Cloudflare.
* Both provide additional connectivity to the same tunnel's configured services.

This architecture is called **one tunnel with multiple replicas**.

It is important to understand that two replicas do not represent two independent tunnels.

#### Replica architecture

```
                Cloudflare Network
                        |
             -----------------------
             |                     |
          Replica 1             Replica 2
             |                     |
        Host A                 Host B
       cloudflared            cloudflared
             |                     |
             -----------+-----------
                        |
                   tunnel-01
                        |
                   Application
```

Replicas provide additional connector instances so that the tunnel does not depend on a single connector host.

### 4. How Does Cloudflare Establish Connections?

One of the most important technical details of Cloudflare Tunnel is its connection architecture.

When a `cloudflared` instance starts a tunnel, it establishes **four outbound-only connections** to Cloudflare's global network.

These connections reach different Cloudflare servers across at least two distinct Cloudflare data centers.

This provides redundancy against individual connection, server, or data center failures.

#### Connections per replica

Each additional replica establishes four additional connections.

| Number of replicas | Number of outbound connections |
| ------------------ | ------------------------------ |
| 1                  | 4                              |
| 2                  | 8                              |
| 3                  | 12                             |
| 4                  | 16                             |
| 5                  | 20                             |
| 25                 | 100                            |

Cloudflare supports up to 25 replicas, or 100 connections, per tunnel.

#### Example: Two replicas

```
                Cloudflare Network
                        |
             -----------------------
             |                     |
          Host A                 Host B
        cloudflared            cloudflared
             |                     |
        4 connections          4 connections
             |                     |
             -----------+---------
                        |
                   tunnel-01
```

With two replicas, the tunnel has eight outbound connections in total.

This increases the number of available connection paths and provides redundancy at the connector-host level.

### 5. How Does Cloudflare Select a Replica?

Cloudflare does not use replicas as a traditional load-balancing mechanism.

When a request arrives at Cloudflare, it forwards the request to the geographically closest replica.

If the selected connection fails, Cloudflare can retry using other available replicas. However, there is no guarantee about which replica will receive a particular request.

Consider an example:

* Host A is located in Noida, India.
* Host B is located in Jaipur, India.
* A user sends a request from Delhi.

Cloudflare determines which available replica is geographically closest based on its network routing.

The selected replica receives the request and forwards it to the configured application service.

#### Important distinction

Tunnel replicas do not provide:

* Round-robin traffic distribution.
* Weighted traffic distribution.
* Hash-based traffic steering.
* Configurable geographic traffic policies.

If you require intelligent traffic distribution, health-based origin selection, or advanced failover policies, Cloudflare Load Balancing is the appropriate solution.

### 6. How Do Replicas Provide High Availability?

Consider a production application hosted inside a private network.

Initially, you deploy `cloudflared` on Host A.

The tunnel establishes four outbound connections to Cloudflare.

Everything works correctly, but Host A becomes a potential single point of failure at the connector-host level.

Suppose the following happens:

* Host A experiences an operating system failure.
* The server shuts down unexpectedly.
* The `cloudflared` service stops.
* Network connectivity to Host A is lost.

Without another connector, the application loses its tunnel connectivity.

Now consider deploying a second replica on Host B.

Both hosts connect to the same tunnel.

If Host A becomes unavailable, Host B can continue providing connectivity through its own established connections.

#### Failure scenario

**Before failure:**

```
              Cloudflare Network
                      |
              -----------------
              |               |
            Host A          Host B
              |               |
         cloudflared      cloudflared
              |               |
              -------+--------
                     |
                 Application
```

**After Host A fails:**

```
              Cloudflare Network
                      |
              -----------------
              |               |
           Host A           Host B
           FAILED           ACTIVE
              X                |
                               |
                          cloudflared
                               |
                               |
                          Application
```

Cloudflare can continue routing requests through Host B.

This is the primary benefit of deploying multiple replicas.

**Important:** The application must still be reachable through Host B. If both connectors depend on a failed application server, the application remains unavailable.

### 7. What Happens If an Application Server Fails?

This is an important limitation to understand.

Cloudflare Tunnel replicas provide connector redundancy. They do not automatically provide application-server redundancy.

For example:

```
              Cloudflare Network
                      |
              -----------------
              |               |
            Host A          Host B
              |               |
         cloudflared      cloudflared
              |               |
              -------+--------
                     |
                IIS Server
               192.168.1.20
```

Suppose the IIS server at `192.168.1.20` stops working.

Both connectors might still have healthy connections to Cloudflare, but the application is unavailable.

The tunnel itself can remain active while the origin application is down.

To achieve application-level high availability, you need additional infrastructure components, such as:

* Multiple IIS application servers.
* An internal load balancer.
* Application health checks.
* Database replication or clustering.
* Shared or replicated application data.
* Appropriate session management.

Therefore, tunnel availability and application availability are two different things.

### 8. Deploying Cloudflare Tunnel Replicas

Cloudflare supports remotely managed and locally managed tunnel configurations.

#### Method 1: Remotely Managed Tunnel

A remotely managed tunnel is configured through the Cloudflare Dashboard.

To deploy another replica:

1. Log in to the Cloudflare Dashboard.
2. Navigate to **Networking → Tunnels**.
3. Select your existing tunnel.
4. Open the tunnel configuration.
5. Select **Add a replica**.
6. Choose the operating system of the additional host.
7. Copy the installation command provided by Cloudflare.
8. Execute the command on the additional host.
9. Verify that the new replica appears in the tunnel overview.

The additional connector will use the existing tunnel identity.

#### Method 2: Locally Managed Tunnel

For locally managed tunnels, configuration is maintained through the command line and YAML configuration files.

You can run the same tunnel on another host using the same tunnel credentials.

Example:

```
cloudflared tunnel run production-web
```

The additional host must have the required tunnel credentials and compatible configuration.

**Important:** Only one `cloudflared` service instance is allowed per host when running replicas as services.

### 9. Firewall Requirements

Cloudflare Tunnel uses outbound connections to communicate with Cloudflare.

The required destination port is TCP/UDP 7844.

| Direction | Port                                 | Protocol | Purpose                                |
| --------- | ------------------------------------ | -------- | -------------------------------------- |
| Outbound  | 7844                                 | TCP      | HTTP/2 tunnel transport                |
| Outbound  | 7844                                 | UDP      | QUIC tunnel transport                  |
| Inbound   | Not required for tunnel connectivity | —        | No public inbound tunnel port required |

The firewall should allow the required outbound connectivity to Cloudflare's tunnel endpoints.

For a production deployment, follow the official Cloudflare firewall requirements rather than allowing unrestricted outbound traffic.

This approach helps implement a more restrictive firewall policy.

### 10. Production Considerations

When implementing Cloudflare Tunnel replicas in production, consider the following points:

#### 10.1 Deploy replicas on separate hosts

Running multiple connector instances on separate hosts helps protect against individual server failures.

However, deploying both hosts on the same physical infrastructure may leave a shared failure point.

For stronger resilience, consider separate virtualization hosts, power domains, network paths, or data centers where appropriate.

#### 10.2 Verify application reachability

Every replica must be able to reach the configured origin service.

For example, if the tunnel routes traffic to:

```
http://192.168.1.20:80
```

Both connector hosts must have network connectivity to that service.

#### 10.3 Monitor connector availability

Monitor:

* Tunnel connection status.
* Connector health.
* `cloudflared` service status.
* Network connectivity.
* Application availability.
* Connector logs.

A healthy tunnel does not necessarily indicate a healthy application.

#### 10.4 Protect tunnel credentials

Tunnel tokens and credentials provide access to the tunnel.

Store them securely and restrict access to authorized administrators and systems.

#### 10.5 Test failure scenarios

Do not assume high availability is working simply because multiple replicas appear in the dashboard.

Perform controlled tests:

* Stop the `cloudflared` service on one host.
* Verify that the other replica continues serving requests.
* Restore the failed connector.
* Test application availability independently.
* Check logs and connection status.

### 11. Tunnel Replicas vs Cloudflare Load Balancing

Although both technologies contribute to availability, they solve different problems.

| Feature                       | Tunnel Replicas                      | Cloudflare Load Balancing                            |
| ----------------------------- | ------------------------------------ | ---------------------------------------------------- |
| Primary purpose               | Connector redundancy                 | Traffic distribution and failover                    |
| Architecture                  | Multiple connectors using one tunnel | Multiple origins or tunnel endpoints                 |
| Traffic steering              | Not supported                        | Supported                                            |
| Geographic steering           | Closest replica selection            | Configurable steering policies                       |
| Health-based origin selection | Not provided as LB functionality     | Supported through health monitors                    |
| Round-robin                   | Not supported                        | Supported through appropriate steering configuration |
| Intelligent failover          | Connection retry across replicas     | Health-based origin failover                         |

#### When should you use replicas?

Use Cloudflare Tunnel replicas when:

* You want to keep a single tunnel available if one connector host fails.
* You need additional connector instances.
* You want to maintain tunnel connectivity during connector maintenance.
* You want additional points of ingress to your private infrastructure.

#### When should you use Cloudflare Load Balancing?

Use Cloudflare Load Balancing when:

* You operate multiple data centers.
* You need health-based origin selection.
* You want to distribute traffic between multiple tunnel endpoints.
* You need configurable traffic steering.
* You require origin health alerts and failover policies.

### 12. Conclusion

Cloudflare Tunnel replicas provide an effective way to improve the availability of private infrastructure without exposing origin servers through publicly accessible inbound ports.

By deploying multiple `cloudflared` instances connected to the same tunnel, organizations can reduce their dependency on a single connector host.

Each replica establishes four outbound connections to Cloudflare, and Cloudflare routes requests to the geographically closest available replica.

However, it is important to remember that connector redundancy does not automatically provide application or database redundancy.

For complete production high availability, organizations must consider the entire infrastructure stack, including connectors, network connectivity, application servers, databases, and monitoring.

Understanding Tunnel Replicas is an excellent foundation before moving on to Cloudflare Load Balancing, where we will explore origin pools, health monitors, traffic steering, and multi-data-center failover.

***

### Official References

1. [Cloudflare Tunnel – Configuration, Replicas and High Availability](https://developers.cloudflare.com/tunnel/configuration/)
2. [Cloudflare Tunnel – Availability and Failover](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/configure-tunnels/tunnel-availability/)
3. [Deploy cloudflared Replicas](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/configure-tunnels/tunnel-availability/deploy-replicas/)
4. [Cloudflare Load Balancing Reference Architecture](https://developers.cloudflare.com/reference-architecture/architectures/load-balancing/)
