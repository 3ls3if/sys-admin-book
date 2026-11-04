---
icon: network-wired
---

# CDN Networking Fundamentals: DNS, Anycast, BGP, TCP, TLS and HTTP/3 Explained

### Introduction

A Content Delivery Network (CDN) is more than a collection of geographically distributed servers. Its performance, availability, and security depend on several fundamental networking technologies working together.

When a user accesses a website protected by a CDN, multiple networking processes take place:

* DNS resolves the website hostname to an appropriate CDN endpoint.
* Anycast and BGP help route the user toward an available CDN Point of Presence (PoP).
* TCP or QUIC establishes the transport connection.
* TLS encrypts communication between the client and the CDN.
* HTTP carries the actual website request and response.
* The CDN edge communicates with the origin server when content is not available in its cache.

Understanding these technologies is essential for infrastructure engineers, network administrators, security engineers, and CDN administrators.

This article explains each technology from an enterprise networking perspective.

***

### 1. DNS: How a CDN Directs Users to Its Edge Network

DNS (Domain Name System) translates human-readable domain names into IP addresses.

For example:

```
www.example.com
        |
        v
DNS Resolver
        |
        v
CDN DNS Infrastructure
        |
        v
CDN Edge Endpoint
        |
        v
Website Content
```

Without DNS, users would need to access websites using IP addresses instead of domain names.

#### 1.1 Traditional DNS Resolution

Consider a website hosted on a Windows IIS server:

```
Website: www.example.com
Origin IP: 203.0.113.10
```

A simplified DNS resolution process is:

1. The user enters `www.example.com` in a browser.
2. The operating system checks its local DNS cache.
3. If no cached record exists, the configured DNS resolver is queried.
4. The resolver obtains the relevant DNS answer.
5. The browser uses the returned IP address to connect to the server.

Example DNS record:

```
Type: A
Name: www
Value: 203.0.113.10
TTL: 300
```

#### 1.2 DNS When a CDN Is Enabled

When a CDN is configured, the DNS response may point the visitor toward the CDN instead of directly exposing the origin server.

Example:

```
User
 |
 v
www.example.com
 |
 v
CDN DNS
 |
 v
CDN Edge IP
 |
 v
CDN PoP
 |
 v
Origin Server (if required)
```

The origin IP can remain hidden from ordinary public DNS resolution, provided it is not exposed through other DNS records, applications, historical records, or direct references.

#### 1.3 DNS-Based Traffic Steering

CDN providers can use DNS-based traffic steering to influence which endpoint a client receives.

Depending on the provider and configuration, decisions may consider:

* Geographic location
* Network latency
* Endpoint health
* Regional availability
* Routing policies
* Traffic load

DNS-based steering has an important limitation: DNS resolvers cache answers according to TTL, and the resolver's location may differ from the end user's location.

Therefore, DNS does not always identify the geographically closest CDN server.

#### Practical DNS Commands

On Windows:

```
Resolve-DnsName www.example.com
```

Using nslookup:

```
nslookup www.example.com
```

To query a specific DNS resolver:

```
nslookup www.example.com 8.8.8.8
```

To inspect DNS records:

```
Resolve-DnsName example.com -Type A
Resolve-DnsName example.com -Type AAAA
Resolve-DnsName example.com -Type CNAME
Resolve-DnsName example.com -Type NS
Resolve-DnsName example.com -Type TXT
```

***

### 2. Anycast: How CDN Traffic Reaches an Edge Location

Anycast is a networking technique in which multiple geographically distributed locations advertise the same IP address.

Instead of assigning a unique public IP address to every CDN location, a provider can announce the same IP prefix from multiple PoPs.

Example:

```
                    CDN Anycast IP
                    198.51.100.10
                          |
           +--------------+--------------+
           |              |              |
           v              v              v
        PoP India       PoP Europe     PoP USA
        Mumbai          Frankfurt      New York
```

A user connecting to the Anycast IP is routed toward one of the available network destinations advertising that address.

#### 2.1 How Anycast Works

Anycast relies heavily on BGP (Border Gateway Protocol).

Each participating CDN location advertises a route for the same IP prefix.

Internet routers exchange routing information and select paths according to routing policies and BGP path-selection rules.

The user's network traffic follows the route selected by the network.

For example:

* A user in India may reach an Indian CDN PoP.
* A user in Germany may reach a European CDN PoP.
* A user in the United States may reach a US CDN PoP.

However, Anycast does not guarantee that traffic always reaches the geographically nearest PoP. Internet routing policies, peering arrangements, congestion, and network topology can influence the selected route.

#### 2.2 Anycast Benefits

**Improved availability:** If a PoP becomes unavailable, routing can converge toward another location advertising the prefix.

**Reduced latency:** Users can often reach a nearby or well-connected edge location.

**Traffic distribution:** Requests are distributed across multiple network locations.

**DDoS resilience:** Distributed network capacity helps absorb and mitigate large-scale attacks.

#### 2.3 Anycast vs Unicast

| Feature       | Unicast                            | Anycast                                     |
| ------------- | ---------------------------------- | ------------------------------------------- |
| IP addressing | One destination endpoint           | Shared address across multiple endpoints    |
| Routing       | Toward a specific endpoint         | Toward a selected advertising endpoint      |
| Availability  | Depends on endpoint and redundancy | Can benefit from distributed advertisements |
| Common use    | Standard server addressing         | CDN and DNS infrastructure                  |

**Infrastructure example:** A CDN provider can advertise the same public IP prefix from several global data centers. The routing system determines which location receives a user's traffic.

***

### 3. BGP: The Routing Protocol Behind Global CDN Connectivity

BGP stands for Border Gateway Protocol.

It is the routing protocol used to exchange reachability information between Autonomous Systems (ASes) across the internet.

An Autonomous System is a network or group of networks operated under a common routing policy and identified by an Autonomous System Number (ASN).

Examples include:

* Internet Service Providers
* Cloud providers
* Large enterprises
* CDN providers
* Telecommunications companies

#### 3.1 How BGP Works

Consider this simplified architecture:

```
User Network
     |
     v
ISP Network
     |
     v
Internet BGP Routing
     |
     v
CDN Network
     |
     v
CDN Edge PoP
```

BGP routers exchange information about reachable IP prefixes.

A CDN can advertise its IP prefixes to upstream providers and internet peers.

Routers use BGP attributes and local policies to select routes.

Important BGP attributes include:

| Attribute   | Purpose                                           |
| ----------- | ------------------------------------------------- |
| AS\_PATH    | Lists the autonomous systems traversed by a route |
| NEXT\_HOP   | Identifies the next-hop router                    |
| LOCAL\_PREF | Influences route selection within an AS           |
| MED         | Can influence preferred entry into an AS          |
| COMMUNITY   | Tags routes for policy handling                   |
| ORIGIN      | Indicates how the route was introduced into BGP   |

#### 3.2 BGP and CDN Failover

Suppose a CDN has two locations:

```
PoP Mumbai
   |
   | Advertises CDN Prefix
   |
   v
BGP Network

PoP Singapore
   |
   | Advertises CDN Prefix
   |
   v
BGP Network
```

If the Mumbai location becomes unavailable and its route is withdrawn, traffic may move toward Singapore or another available location.

This depends on route availability, convergence, provider design, and routing policy.

#### 3.3 BGP Is Not the Same as Load Balancing

This distinction is important.

**BGP:** Determines network-level paths toward advertised IP prefixes.

**Load balancer:** Distributes application requests or connections across backend servers.

For example:

```
BGP Routing
    |
    v
CDN PoP
    |
    v
Application Load Balancer
    |
    +------ IIS Server 1
    |
    +------ IIS Server 2
```

BGP selects the network path toward the CDN infrastructure. The load balancer distributes traffic among application servers.

***

### 4. TCP: Establishing Reliable Network Connections

TCP stands for Transmission Control Protocol.

It is a connection-oriented transport protocol that provides reliable, ordered delivery of data.

Traditional HTTPS over HTTP/1.1 and HTTP/2 commonly uses TCP.

#### 4.1 TCP Three-Way Handshake

Before exchanging application data, TCP establishes a connection through a three-way handshake.

The process involves three packets:

1. SYN
2. SYN-ACK
3. ACK

Example:

```
Client                         Server
  |                               |
  |---------- SYN --------------->|
  |                               |
  |<--------- SYN-ACK ------------|
  |                               |
  |---------- ACK --------------->|
  |                               |
  |       TCP Connection          |
```

After the handshake, the connection can carry application data.

#### 4.2 Why TCP Matters for CDN Performance

TCP performance can be affected by:

* Round-trip time (RTT)
* Packet loss
* Congestion
* Retransmissions
* Network latency
* Connection establishment time

A CDN can improve user experience by terminating client connections at an edge location closer to the visitor.

However, the CDN may establish a separate connection to the origin server.

```
Client
  |
  | TCP Connection 1
  v
CDN Edge
  |
  | TCP Connection 2
  v
Origin Server
```

This separation allows the CDN to manage client-side and origin-side connections independently.

#### 4.3 TCP vs UDP

| Feature          | TCP                            | UDP                                 |
| ---------------- | ------------------------------ | ----------------------------------- |
| Connection setup | Connection-oriented            | Connectionless                      |
| Reliability      | Built-in reliable delivery     | No built-in delivery guarantee      |
| Ordering         | Ordered byte stream            | No ordering guarantee               |
| Retransmission   | Built-in                       | Handled by applications if required |
| Common uses      | HTTPS with HTTP/1.1 and HTTP/2 | DNS, streaming, QUIC transport      |

***

### 5. TLS: Securing Communication Between Client and CDN

TLS stands for Transport Layer Security.

It encrypts communication and provides authentication and integrity protection.

HTTPS uses HTTP over TLS.

When a CDN is deployed, TLS can be established between the visitor and the CDN edge. A separate TLS connection may also be established between the CDN and the origin.

```
Client
  |
  | HTTPS / TLS
  v
CDN Edge
  |
  | HTTPS / TLS
  v
Origin Server
```

These are separate TLS sessions.

#### 5.1 TLS Handshake Overview

A simplified TLS 1.3 handshake works as follows:

1. Client sends a ClientHello message.
2. Server responds with ServerHello and handshake information.
3. Both sides derive session keys.
4. The server proves its identity using its certificate.
5. The client validates the certificate and hostname.
6. Encrypted application communication begins.

TLS 1.3 can complete its handshake with fewer round trips than older TLS versions.

#### 5.2 TLS Termination at the CDN

TLS termination means the CDN edge decrypts incoming HTTPS traffic so it can process the HTTP request.

The CDN can then apply:

* WAF inspection
* Bot management
* Rate limiting
* Cache policies
* HTTP routing
* Security rules

The CDN may re-encrypt the connection when forwarding traffic to the origin.

#### 5.3 Cloudflare SSL/TLS Modes

Cloudflare provides several SSL/TLS modes.

| Mode          | Visitor to Cloudflare | Cloudflare to Origin                        |
| ------------- | --------------------- | ------------------------------------------- |
| Off           | No HTTPS              | HTTP                                        |
| Flexible      | HTTP                  | HTTPS                                       |
| Full          | HTTPS                 | HTTPS, certificate validation is not strict |
| Full (strict) | HTTPS                 | HTTPS with certificate validation           |

For production deployments, Full (strict) is generally the preferred option when the origin has a valid certificate and its hostname matches the configured origin hostname.

Flexible mode should generally be avoided for production applications requiring end-to-end encrypted transport because the CDN-to-origin connection uses HTTP.

***

### 6. HTTP/1.1, HTTP/2 and HTTP/3

HTTP (Hypertext Transfer Protocol) is the application-layer protocol used for communication between browsers, CDNs, and web servers.

Different HTTP versions use different transport mechanisms and provide different performance capabilities.

#### 6.1 HTTP/1.1

HTTP/1.1 generally uses TCP.

It supports persistent connections, allowing multiple requests to reuse a connection.

However, browsers historically opened multiple connections to improve parallel loading.

#### 6.2 HTTP/2

HTTP/2 also commonly uses TCP, but introduces important improvements:

* Multiplexing
* Header compression
* Stream prioritization mechanisms
* More efficient connection utilization

Multiplexing allows multiple request and response streams to share a single connection.

#### 6.3 HTTP/3

HTTP/3 uses QUIC, which operates over UDP.

QUIC provides features including:

* Integrated TLS 1.3 security
* Independent streams
* Reduced connection-establishment latency in suitable scenarios
* Improved handling of packet loss across separate streams
* Connection migration support

#### 6.4 HTTP Protocol Comparison

| Feature            | HTTP/1.1                   | HTTP/2                    | HTTP/3                   |
| ------------------ | -------------------------- | ------------------------- | ------------------------ |
| Transport          | TCP                        | TCP                       | QUIC over UDP            |
| Multiplexing       | Limited                    | Yes                       | Yes                      |
| Header compression | No HPACK/QPACK             | HPACK                     | QPACK                    |
| TLS                | Optional at protocol level | Commonly used in browsers | Integrated into QUIC     |
| Stream handling    | Request/connection based   | Multiple streams          | Independent QUIC streams |

#### 6.5 Why HTTP/3 Matters for CDN

Consider a mobile user accessing a website over an unstable network.

With traditional TCP-based connections, packet loss can delay delivery of data across the connection.

QUIC uses independently managed streams, reducing cross-stream blocking caused by lost packets.

This can improve performance on certain mobile and high-latency networks.

However, actual performance depends on network conditions, client support, server configuration, and CDN implementation.

***

### 7. Putting Everything Together: Complete CDN Networking Flow

Let's combine the technologies discussed in this article.

Assume the following infrastructure:

* Website: `www.example.com`
* CDN: Cloudflare
* Origin: Windows Server with IIS
* Firewall: FortiGate
* Load balancer: F5
* Backend: Two IIS web servers

#### Complete Request Flow

```
                 INTERNET USER
                       |
                       v
                 DNS Resolution
                       |
                       v
                CDN DNS Response
                       |
                       v
                Anycast CDN IP
                       |
                       v
              BGP Network Routing
                       |
                       v
                  CDN PoP
                       |
                       v
              TCP / QUIC + TLS
                       |
                       v
                CDN Edge Server
                       |
          +------------+------------+
          |                         |
          v                         v
      WAF Inspection            Cache Lookup
                                    |
                         +----------+----------+
                         |                     |
                         v                     v
                       HIT                   MISS
                         |                     |
                         v                     v
                    Return Data          Origin Connection
                                               |
                                               v
                                          FortiGate
                                               |
                                               v
                                             F5
                                               |
                                  +------------+------------+
                                  |                         |
                                  v                         v
                              IIS Server 1              IIS Server 2
                                  |                         |
                                  +------------+------------+
                                               |
                                               v
                                         Application
                                               |
                                               v
                                      Response to CDN
                                               |
                                               v
                                      CDN Cache (if allowed)
                                               |
                                               v
                                        User Browser
```

This architecture separates responsibilities:

* DNS provides hostname resolution.
* Anycast and BGP provide network-level traffic direction.
* TCP or QUIC provides transport.
* TLS protects communication.
* CDN edge servers process and cache requests.
* WAF evaluates application-layer traffic.
* FortiGate enforces network security policies.
* F5 distributes traffic across backend IIS servers.
* IIS processes the web application.

The exact placement and order of WAF, firewall, and load-balancing components depend on the deployment architecture.

***

### 8. Practical Lab: Investigating CDN Networking from Windows

You can use a Windows machine to inspect DNS, connectivity, TLS, and HTTP behaviour.

#### Step 1: Check DNS Resolution

```
Resolve-DnsName www.cloudflare.com
```

Observe the returned records and IP addresses.

#### Step 2: Check DNS Through Different Resolvers

```
nslookup www.cloudflare.com 8.8.8.8
nslookup www.cloudflare.com 1.1.1.1
```

Compare the responses. Different answers can result from DNS policies, caching, and resolver location.

#### Step 3: Check TCP Connectivity

```
Test-NetConnection www.cloudflare.com -Port 443
```

Look for:

```
TcpTestSucceeded : True
```

This confirms that a TCP connection to port 443 succeeded. It does not, by itself, prove that TLS or the website application is working correctly.

#### Step 4: Inspect HTTP Response Headers

```
curl.exe -I https://www.cloudflare.com
```

Review the HTTP status code and response headers.

For a CDN-protected website, provider-specific headers may expose information about caching, edge processing, or request identifiers.

#### Step 5: Inspect TLS and HTTP Negotiation

```
curl.exe -Iv https://www.cloudflare.com
```

This can show connection, certificate, TLS, and HTTP negotiation details.

#### Step 6: Measure Request Timing

```
curl.exe -o NUL -s -w "DNS: %{time_namelookup}s`nConnect: %{time_connect}s`nTLS: %{time_appconnect}s`nTTFB: %{time_starttransfer}s`nTotal: %{time_total}s`n" https://www.cloudflare.com
```

This provides useful timing indicators:

| Metric  | Meaning                                    |
| ------- | ------------------------------------------ |
| DNS     | Time required for DNS lookup               |
| Connect | Time required to establish the connection  |
| TLS     | Time until TLS negotiation completes       |
| TTFB    | Time until the first response byte arrives |
| Total   | Total request duration                     |

These timings are useful for troubleshooting, but they do not isolate every individual CDN processing stage.

***

### 9. Common CDN Networking Troubleshooting Scenarios

| Symptom                              | Possible area to investigate                                                  |
| ------------------------------------ | ----------------------------------------------------------------------------- |
| Website resolves to an unexpected IP | DNS records, resolver cache, traffic steering                                 |
| High connection time                 | Routing, packet loss, network latency                                         |
| TCP connection fails                 | Firewall, routing, port 443, server availability                              |
| TLS certificate error                | Certificate validity, hostname, certificate chain                             |
| HTTP 522                             | CDN cannot establish a connection to the origin                               |
| HTTP 524                             | Origin response timeout                                                       |
| HTTP 525                             | TLS handshake failure between CDN and origin                                  |
| HTTP 526                             | Origin certificate validation failure in applicable Cloudflare configurations |
| HTTP 502 or 503                      | Origin application, proxy, load balancer, or upstream availability            |

A CDN error should not immediately be treated as a CDN platform failure. Always identify which connection or processing stage is failing.

***

### 10. Key Takeaways

The core networking technologies behind a CDN serve different purposes:

1. **DNS** resolves domain names and can help direct users toward CDN infrastructure.
2. **Anycast** allows multiple locations to advertise the same IP address.
3. **BGP** exchanges routing information and helps determine network paths.
4. **TCP** provides reliable transport for traditional HTTP connections.
5. **TLS** encrypts communication and authenticates endpoints.
6. **HTTP/1.1, HTTP/2 and HTTP/3** define how application requests and responses are exchanged.
7. **QUIC** enables HTTP/3 over UDP with modern transport and security features.

For infrastructure engineers, understanding these technologies makes CDN deployment, performance optimization, security configuration, and troubleshooting much easier.

A CDN is not simply a caching server. It is a globally distributed networking and application-delivery platform built on top of DNS, routing, transport protocols, encryption, and intelligent traffic management.

***

### Suggested Next Article

**CDN Caching Deep Dive: Cache-Control, TTL, Cache HIT/MISS, Purging, Origin Shield and Cache Rules**

The next article will focus on one of the most important CDN functions: caching. It will cover browser caching, edge caching, cache keys, cache policies, dynamic content, cache invalidation, and practical Cloudflare configuration.
