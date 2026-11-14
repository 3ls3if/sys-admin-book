---
icon: ubuntu
---

# Implementing HAProxy Load Balancer with Two IIS Web Servers on Ubuntu Server

## Implementing HAProxy Load Balancer with Two IIS Web Servers on Ubuntu Server

### 1. Introduction

HAProxy (High Availability Proxy) is an open-source, high-performance load balancer and reverse proxy widely used to distribute incoming application traffic across multiple backend servers.

In this lab, we will implement HAProxy on Ubuntu Server and configure it to distribute HTTP requests between two Windows Server machines running Internet Information Services (IIS).

The primary objectives are:

* Configure Ubuntu Server as a dedicated HAProxy load balancer.
* Configure two Windows IIS servers as backend web servers.
* Distribute incoming HTTP requests using the Round Robin algorithm.
* Configure automatic HTTP health checks.
* Detect backend server failures and automatically stop forwarding traffic to unavailable servers.
* Restore backend availability automatically when a failed server recovers.

This implementation provides a practical introduction to Layer 7 load balancing, reverse proxy configuration, backend health monitoring, and automatic failover.

### 2. Lab Architecture

The architecture consists of four virtual machines connected through a common VirtualBox Internal Network.

#### Architecture Diagram

<figure><img src="../.gitbook/assets/mermaid-diagram (2).png" alt=""><figcaption></figcaption></figure>

#### Network Addressing Plan

| Component     | Hostname       | IP Address    | Service               |
| ------------- | -------------- | ------------- | --------------------- |
| Client        | Windows10      | 192.168.1.100 | Browser / HTTP Client |
| Load Balancer | Ubuntu-HAProxy | 192.168.1.10  | HAProxy               |
| Backend 1     | IIS01          | 192.168.1.11  | IIS                   |
| Backend 2     | IIS02          | 192.168.1.12  | IIS                   |

**Network:** 192.168.1.0/24\
**Subnet Mask:** 255.255.255.0\
**Frontend Port:** TCP 80\
**Backend Port:** TCP 80\
**Load Balancing Algorithm:** Round Robin

{% hint style="info" %}
Note: These are example addresses. Use an isolated subnet that does not conflict with your existing network. In this lab, 10.20.20.0/24 can be used instead if your existing OPNsense LAN already uses 192.168.1.0/24.
{% endhint %}

### 3. Lab Prerequisites

Before starting, ensure that the following virtual machines are available.

| Virtual Machine | Operating System        | CPU      | RAM      | Storage  |
| --------------- | ----------------------- | -------- | -------- | -------- |
| HAProxy         | Ubuntu Server 24.04 LTS | 2 vCPU   | 2 GB     | 20 GB    |
| IIS01           | Windows Server          | Existing | Existing | Existing |
| IIS02           | Windows Server          | Existing | Existing | Existing |
| Client          | Windows 10              | Existing | Existing | Existing |

#### Network Requirements

All four virtual machines must be connected to the same VirtualBox network.

Recommended configuration:

1. Open VirtualBox.
2. Select the Ubuntu HAProxy VM.
3. Open Settings → Network.
4. Select Adapter 1.
5. Enable Network Adapter.
6. Select Internal Network.
7. Set the network name to `CDN-LAB`.
8. Repeat the same configuration on both IIS servers and the Windows 10 client.

An additional NAT adapter can temporarily be enabled on Ubuntu if internet access is required to install packages. Do not use the NAT adapter as the backend communication network.

### 4. Configure Static IP Address on Ubuntu Server

Start the Ubuntu Server VM and log in using an account with sudo privileges.

#### Step 1: Update Ubuntu packages

```
sudo apt update
sudo apt upgrade -y
```

#### Step 2: Identify the network interface

```
ip -br addr
```

Example output:

```
lo       UNKNOWN  127.0.0.1/8
enp0s3   UP       192.168.1.10/24
```

Identify the actual network interface name. In this example, it is `enp0s3`.

#### Step 3: Identify the Netplan configuration

```
ls -l /etc/netplan/
```

Open the relevant YAML configuration file:

```
sudo nano /etc/netplan/50-cloud-init.yaml
```

Use the existing filename if it is different.

#### Step 4: Configure the static IP address

Example Netplan configuration:

```
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: false
      addresses:
        - 192.168.1.10/24
```

Replace `enp0s3` with your actual interface name.

For an isolated network, no default gateway or DNS configuration is required for this initial lab.

#### Step 5: Apply the configuration

```
sudo netplan generate
sudo netplan try
```

Confirm the configuration when prompted, then run:

```
sudo netplan apply
```

Verify the assigned IP:

```
ip addr show
```

Ubuntu should now have the IP address `192.168.1.10/24`.

### 5. Install HAProxy on Ubuntu Server

Once the network configuration is complete, install HAProxy.

#### Step 1: Update package repositories

```
sudo apt update
```

#### Step 2: Install HAProxy

```
sudo apt install haproxy -y
```

#### Step 3: Verify installation

```
haproxy -v
```

#### Step 4: Enable the HAProxy service

```
sudo systemctl enable haproxy
```

Check the service status:

```
sudo systemctl status haproxy
```

HAProxy should be installed successfully.

### 6. Configure the IIS Backend Servers

We need two IIS servers hosting different web pages to identify which backend is responding to incoming requests.

#### Step 1: Verify IIS installation

Run PowerShell as Administrator on both Windows servers.

```
Get-Service W3SVC
```

If the service is stopped:

```
Start-Service W3SVC
```

#### Step 2: Configure IIS01 web content

Run the following command on IIS01:

```
Set-Content -Path "C:\inetpub\wwwroot\default.htm" -Value @"
<html>
<head><title>IIS01</title></head>
<body style='font-family:Arial;text-align:center'>
<h1>Welcome to IIS Web Server 1</h1>
<h2>Backend Server: IIS01</h2>
<p>HAProxy Load Balancing Lab</p>
</body>
</html>
"@
```

#### Step 3: Configure IIS02 web content

Run the following command on IIS02:

```
Set-Content -Path "C:\inetpub\wwwroot\default.htm" -Value @"
<html>
<head><title>IIS02</title></head>
<body style='font-family:Arial;text-align:center'>
<h1>Welcome to IIS Web Server 2</h1>
<h2>Backend Server: IIS02</h2>
<p>HAProxy Load Balancing Lab</p>
</body>
</html>
"@
```

#### Step 4: Allow inbound HTTP traffic

Execute this command on both IIS servers:

```
New-NetFirewallRule `
    -DisplayName "Allow HTTP for HAProxy Lab" `
    -Direction Inbound `
    -Protocol TCP `
    -LocalPort 80 `
    -Action Allow
```

#### Step 5: Test IIS independently

From Windows 10:

```
curl.exe http://192.168.1.11/default.htm
```

```
curl.exe http://192.168.1.12/default.htm
```

Both servers should return their respective HTML pages.

Also verify that the root URL `/` returns HTTP 200, because the HAProxy health check in this lab will use that URL.

### 7. Back Up the HAProxy Configuration

Before modifying the HAProxy configuration, create a backup.

```
sudo cp /etc/haproxy/haproxy.cfg \
/etc/haproxy/haproxy.cfg.backup
```

Open the configuration file:

```
sudo nano /etc/haproxy/haproxy.cfg
```

### 8. Configure HAProxy Frontend and Backend

Replace the existing configuration with the following:

```
global
    log /dev/log local0
    log /dev/log local1 notice
    daemon
    maxconn 2000

defaults
    log global
    mode http
    option httplog
    option dontlognull

    timeout connect 5s
    timeout client 30s
    timeout server 30s
    timeout http-request 10s

frontend web_frontend
    bind *:80
    mode http
    default_backend iis_web_servers

backend iis_web_servers
    mode http

    balance roundrobin

    option httpchk GET /
    http-check expect status 200

    default-server inter 3s fall 3 rise 2

    server IIS01 192.168.1.11:80 check
    server IIS02 192.168.1.12:80 check
```

Save the file.

#### Understanding HAProxy Configuration

**Global Section**

The global section defines HAProxy-wide parameters.

| Directive             | Description                                  |
| --------------------- | -------------------------------------------- |
| `log /dev/log local0` | Sends logs to the local syslog facility      |
| `daemon`              | Runs HAProxy as a background process         |
| `maxconn 2000`        | Sets the maximum concurrent connection limit |

**Defaults Section**

The defaults section contains settings inherited by frontend and backend sections unless overridden.

| Directive            | Description                                   |
| -------------------- | --------------------------------------------- |
| `mode http`          | Enables HTTP application-layer proxy mode     |
| `option httplog`     | Enables detailed HTTP request logging         |
| `timeout connect 5s` | Maximum backend connection establishment time |
| `timeout client 30s` | Client-side inactivity timeout                |
| `timeout server 30s` | Server-side inactivity timeout                |

**Frontend Section**

The frontend defines how HAProxy accepts incoming traffic.

```
frontend web_frontend
    bind *:80
    mode http
    default_backend iis_web_servers
```

Explanation:

* `frontend web_frontend`: Creates the frontend listener.
* `bind *:80`: Listens on TCP port 80 on all available interfaces.
* `default_backend iis_web_servers`: Sends incoming requests to the IIS backend pool.

**Backend Section**

The backend defines the actual web servers receiving traffic.

```
backend iis_web_servers
    balance roundrobin
    option httpchk GET /
    http-check expect status 200
    default-server inter 3s fall 3 rise 2

    server IIS01 192.168.1.11:80 check
    server IIS02 192.168.1.12:80 check
```

Explanation:

| Directive                      | Description                                                       |
| ------------------------------ | ----------------------------------------------------------------- |
| `balance roundrobin`           | Distributes new requests in rotation                              |
| `option httpchk GET /`         | Sends HTTP GET requests for health checking                       |
| `http-check expect status 200` | Considers HTTP 200 a successful health check                      |
| `inter 3s`                     | Checks backend health every 3 seconds                             |
| `fall 3`                       | Marks the backend down after three consecutive failures           |
| `rise 2`                       | Marks the backend healthy after two consecutive successful checks |
| `check`                        | Enables health checking for the backend server                    |

### 9. Validate and Restart HAProxy

Before restarting the service, validate the configuration.

```
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
```

Expected output:

```
Configuration file is valid
```

If the configuration is valid, restart HAProxy:

```
sudo systemctl restart haproxy
```

Check the service:

```
sudo systemctl status haproxy
```

Check whether HAProxy is listening on port 80:

```
sudo ss -tulpn | grep :80
```

HAProxy should now be listening for incoming HTTP connections.

### 10. Verify Backend Connectivity from Ubuntu

Before testing load balancing, verify that Ubuntu can communicate with both IIS servers.

Test IIS01:

```
curl -I http://192.168.1.11/
```

Test IIS02:

```
curl -I http://192.168.1.12/
```

Expected response:

```
HTTP/1.1 200 OK
```

If either server fails to respond, investigate:

* IIS service status.
* Windows Firewall rules.
* Backend IP addressing.
* VirtualBox network connectivity.
* IIS website bindings and default document configuration.

### 11. Test HTTP Load Balancing

Once HAProxy and both IIS servers are working, test the frontend.

From Ubuntu:

```
curl http://127.0.0.1/
```

From Windows 10:

```
curl.exe http://192.168.1.10/
```

The response should display the content from one of the IIS servers.

#### Test Multiple Requests

Run the following PowerShell command on Windows 10:

```
1..10 | ForEach-Object {
    curl.exe -s http://192.168.1.10/
    Start-Sleep -Milliseconds 500
}
```

Expected behavior:

* Request 1 may reach IIS01.
* Request 2 may reach IIS02.
* Request 3 may reach IIS01.
* Request 4 may reach IIS02.

This demonstrates Round Robin load distribution.

Note: Round Robin distributes new eligible connections. HTTP connection reuse, browser behavior, and persistent connections can affect the observed sequence.

### 12. Test Automatic Backend Failover

This is the most important practical exercise in the lab.

We will simulate an IIS server failure and observe how HAProxy handles it.

#### Scenario 1: Stop IIS01

On IIS01, execute:

```
Stop-Service W3SVC
```

This stops the IIS World Wide Web Publishing Service.

Wait for HAProxy to detect the backend failure through its configured health checks.

#### Scenario 2: Test HAProxy Frontend

From Windows 10:

```
1..10 | ForEach-Object {
    curl.exe -s http://192.168.1.10/
}
```

Expected result:

All successful requests should now be served by IIS02.

HAProxy should stop forwarding new requests to IIS01 once it marks the backend as DOWN.

#### Scenario 3: Recover IIS01

On IIS01, execute:

```
Start-Service W3SVC
```

HAProxy will continue checking the backend.

After two successful health checks, IIS01 should automatically return to the available backend pool.

Test again:

```
1..10 | ForEach-Object {
    curl.exe -s http://192.168.1.10/
}
```

Both IIS servers should now receive requests again.

### 13. Monitor HAProxy Service and Logs

HAProxy provides useful service and logging commands for troubleshooting.

#### Check HAProxy status

```
sudo systemctl status haproxy
```

#### View service logs

```
sudo journalctl -u haproxy -f
```

#### Check listening ports

```
sudo ss -tulpn
```

#### Validate configuration

```
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
```

#### Check backend connectivity

```
curl -I http://192.168.1.11/
curl -I http://192.168.1.12/
```

Note: HAProxy's health-check state-change logs require appropriate logging configuration. If backend transition messages are not visible, configure and verify local syslog logging for HAProxy.

### 14. Troubleshooting Common Issues

| Issue                                 | Possible Cause                        | Resolution                                     |
| ------------------------------------- | ------------------------------------- | ---------------------------------------------- |
| HAProxy service fails to start        | Invalid configuration syntax          | Run HAProxy configuration validation           |
| Port 80 is unavailable                | Another service is using port 80      | Check using `ss -tulpn`                        |
| Backend connection refused            | IIS is stopped                        | Start the W3SVC service                        |
| Backend returns HTTP 503              | IIS application or website issue      | Check IIS site bindings and application health |
| Backend marked DOWN                   | Health check fails                    | Test HTTP GET `/` directly                     |
| Only one IIS server receives requests | Other backend is unhealthy            | Check backend health and connectivity          |
| Client cannot reach HAProxy           | Incorrect IP or network adapter       | Verify VirtualBox networking                   |
| Configuration changes do not apply    | Service was not restarted or reloaded | Restart HAProxy after validation               |

### 15. Important HAProxy Administration Commands

| Operation              | Command                                       |
| ---------------------- | --------------------------------------------- |
| Install HAProxy        | `sudo apt install haproxy -y`                 |
| Start HAProxy          | `sudo systemctl start haproxy`                |
| Stop HAProxy           | `sudo systemctl stop haproxy`                 |
| Restart HAProxy        | `sudo systemctl restart haproxy`              |
| Enable at boot         | `sudo systemctl enable haproxy`               |
| Check status           | `sudo systemctl status haproxy`               |
| Check version          | `haproxy -v`                                  |
| Validate configuration | `sudo haproxy -c -f /etc/haproxy/haproxy.cfg` |
| View logs              | `sudo journalctl -u haproxy -f`               |
| Check port 80          | `sudo ss -tulpn \| grep :80`                  |

### 16. Lab Validation Checklist

After completing the implementation, verify the following:

* Ubuntu Server configured with a static IP address.
* HAProxy successfully installed.
* HAProxy service enabled and running.
* HAProxy frontend listening on TCP port 80.
* IIS01 website configured and accessible.
* IIS02 website configured and accessible.
* Ubuntu can communicate with both backend servers.
* Windows 10 can access the HAProxy frontend.
* HTTP requests distributed between both IIS servers.
* HAProxy detects IIS01 failure.
* Traffic continues through IIS02 during IIS01 downtime.
* IIS01 automatically returns to the backend pool after recovery.

### 17. Conclusion

In this lab, we successfully designed and implemented a standalone HAProxy load-balancing environment using Ubuntu Server and two Windows IIS backend servers.

The implementation demonstrates how HAProxy can act as a Layer 7 reverse proxy, distribute HTTP requests using Round Robin scheduling, and monitor backend server availability through active HTTP health checks.

The failover exercise demonstrates how an unavailable backend can be removed from the active server pool while the remaining healthy server continues serving requests.

This lab establishes the foundation for more advanced infrastructure topics, including:

1. HAProxy Statistics Dashboard.
2. HTTPS termination and SSL certificate management.
3. Session persistence and sticky sessions.
4. ACL-based URL routing.
5. Multiple backend pools.
6. HAProxy high availability using Keepalived and Virtual IPs.
7. Integration with Cloudflare CDN and WAF.

**Practical Learning Outcome:** Understanding reverse proxy architecture, Layer 7 load balancing, backend health monitoring, traffic distribution, and automatic failover using HAProxy and Windows IIS.



***

## REFERENCES

* [https://www.haproxy.com/blog/how-to-install-haproxy-on-ubuntu](https://www.haproxy.com/blog/how-to-install-haproxy-on-ubuntu)
* [https://hoop.dev/blog/how-to-configure-haproxy-iis-for-secure-repeatable-access](https://hoop.dev/blog/how-to-configure-haproxy-iis-for-secure-repeatable-access)
