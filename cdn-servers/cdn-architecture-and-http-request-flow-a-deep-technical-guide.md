---
icon: cloudflare
---

# CDN Architecture and HTTP Request Flow: A Deep Technical Guide

### Introduction

Content Delivery Networks (CDNs) have become an essential part of modern internet infrastructure. Organizations use CDNs to improve website performance, reduce origin server workload, deliver content globally, and strengthen application security.

However, understanding CDN technology requires more than knowing how to enable a CDN service or configure DNS records.

To understand how a CDN operates in a production environment, infrastructure engineers need to understand its underlying architecture, including DNS resolution, Anycast routing, Points of Presence (PoPs), reverse proxies, edge servers, caching mechanisms, TLS termination, and origin communication.

A CDN typically operates between end users and the organization's origin infrastructure. It receives incoming requests, evaluates applicable security and caching policies, and determines whether the requested content can be delivered from its edge cache or needs to be retrieved from the origin server.

This article explains CDN architecture and the complete HTTP request lifecycle, from the moment a user enters a website URL until the requested content is delivered to the browser.

### 1. Understanding CDN Architecture

A Content Delivery Network is a geographically distributed infrastructure consisting of interconnected servers designed to deliver content from locations closer to end users.

Instead of every user request travelling directly to a central origin server, a CDN distributes content across multiple edge locations.

Consider an organization hosting its website on Windows Server 2022 with IIS in a Mumbai data centre.

A user accessing the website from London may experience additional network latency because the request must travel across multiple networks to reach the origin infrastructure.

By implementing a CDN, eligible website resources can be cached at edge locations closer to the user.

When subsequent users request those resources, the CDN can deliver them directly without repeatedly contacting the origin server.

The primary objective of CDN architecture is to improve content delivery efficiency while reducing unnecessary communication with origin infrastructure.

### 2. Major Components of CDN Architecture

A CDN consists of multiple components that work together to deliver website content efficiently.

#### 2.1 Points of Presence (PoPs)

Points of Presence (PoPs) are geographically distributed locations where CDN providers deploy networking and content delivery infrastructure.

These locations contain edge servers and supporting infrastructure that receive and process requests from end users.

For example, a CDN provider may operate PoPs across:

* Mumbai
* Delhi
* Singapore
* London
* Frankfurt
* New York
* Tokyo

When a user accesses a website, the CDN's traffic-routing infrastructure directs the request towards an appropriate available edge location.

The purpose of PoPs is to reduce network distance, improve response times, and distribute traffic across the provider's infrastructure.

#### 2.2 Edge Servers

Edge servers are responsible for receiving and processing incoming HTTP and HTTPS requests.

They perform several important functions:

* Delivering cached website content.
* Processing incoming HTTP requests.
* Applying configured security policies.
* Forwarding cache misses to origin servers.
* Managing connections and response delivery.
* Applying caching and routing rules.

Edge servers are fundamental to CDN architecture because they bring content delivery closer to end users.

#### 2.3 CDN Cache

Caching is one of the most important technologies behind a CDN.

A CDN stores copies of eligible resources so that subsequent requests can be served without repeatedly contacting the origin server.

Commonly cached resources include:

* Images and logos.
* CSS stylesheets.
* JavaScript files.
* Fonts.
* Videos.
* Downloadable files.
* Other static website resources.

Caching policies determine how long content remains available and under which conditions it can be served.

#### 2.4 Origin Server

The origin server is the actual infrastructure hosting the website or application.

It may consist of:

* Windows Server with IIS.
* Linux Server with Apache or Nginx.
* Application servers.
* Cloud-hosted virtual machines.
* Object storage infrastructure.

When the CDN cannot serve a requested resource from its cache, it communicates with the origin infrastructure to retrieve the required content.

#### 2.5 Origin Shield

Origin Shield is an additional caching layer offered by some CDN providers.

It sits between distributed edge locations and origin infrastructure.

Without an intermediate caching layer, multiple edge locations may independently send requests to the origin for the same uncached resource.

An origin shield can consolidate these requests and reduce repeated origin communication.

This helps improve cache efficiency and reduce origin server workload.

#### 2.6 DNS Infrastructure

DNS is responsible for resolving domain names into IP addresses.

When a domain is configured behind a CDN, DNS records are configured to direct eligible traffic through the CDN infrastructure.

Depending on the provider, this may involve CNAME records, proxy-enabled DNS records, or other traffic-steering mechanisms.

#### 2.7 TLS/SSL Infrastructure

CDN providers support encrypted HTTPS communication between users and edge infrastructure.

They can also establish separate encrypted connections between edge servers and origin servers.

This allows organizations to maintain secure communication across both connections.

### 3. Understanding Anycast and CDN Edge Routing

Anycast is an important networking concept used by many CDN providers.

In traditional unicast communication, an IP address generally identifies one network destination.

In Anycast routing, the same IP address is announced from multiple geographical network locations.

For example:

```
                 CDN Anycast IP
                 198.51.100.20
                        |
           +------------+------------+
           |            |            |
           v            v            v
         Mumbai       London      Singapore
          PoP           PoP          PoP
```

All three locations advertise the same IP address.

When a user attempts to reach that address, internet routing determines the network path towards an available announcement.

Border Gateway Protocol (BGP) is used to exchange routing information between autonomous systems.

It is important to understand that Anycast does not always select the geographically closest server.

Routing policies, network topology, peering relationships, congestion, and route availability influence which location receives the request.

Therefore, CDN performance depends not only on geographical proximity but also on the provider's global network connectivity.

#### Important Networking Terms

| Technology  | Purpose                                                |
| ----------- | ------------------------------------------------------ |
| Anycast     | Advertises the same IP address from multiple locations |
| BGP         | Exchanges routing information between networks         |
| PoP         | CDN network presence at a location                     |
| Edge Server | Processes requests near end users                      |
| Peering     | Direct traffic exchange between networks               |

### 4. DNS Resolution: How Users Reach a CDN

Before a browser can communicate with a CDN, it must resolve the requested domain name.

Consider the following website:

`www.example.com`

When a user enters this URL, the browser needs to determine the IP address associated with the hostname.

The DNS resolution process generally involves:

1. The browser checks its DNS cache.
2. The operating system checks its DNS cache.
3. If no suitable cached answer exists, the configured recursive DNS resolver receives the query.
4. The resolver obtains the required answer through the DNS hierarchy or its own cache.
5. The resolver returns the IP address to the client.
6. The browser establishes a connection to the returned address.

#### DNS Before and After CDN Implementation

Without CDN proxying:

```
www.example.com
        |
        v
203.0.113.10
        |
        v
Origin Web Server
```

With CDN proxying:

```
www.example.com
        |
        v
CDN-facing IP address
        |
        v
CDN Edge Infrastructure
        |
        v
Origin Server (when required)
```

The IP addresses above are illustrative documentation addresses.

When CDN proxying is enabled, the DNS response generally exposes CDN-facing addresses rather than the origin IP address.

#### DNS and Anycast Are Different

These concepts are often confused.

DNS resolves hostnames into IP addresses.

Anycast allows the same IP address to be advertised from multiple network locations.

BGP determines how traffic is routed towards those IP addresses.

DNS does not necessarily identify the exact physical edge server that handles a request.

### 5. CDN as a Reverse Proxy

One of the most important concepts in CDN architecture is reverse proxying.

A CDN commonly operates as a reverse proxy positioned between end users and origin infrastructure.

To understand this, consider the difference between forward proxies and reverse proxies.

#### Forward Proxy

A forward proxy acts on behalf of clients.

```
Client
  |
  v
Forward Proxy
  |
  v
Internet
  |
  v
Destination Server
```

Organizations commonly use forward proxies to control outbound internet access, filter traffic, and apply access policies.

#### Reverse Proxy

A reverse proxy acts on behalf of backend servers.

```
Internet Users
      |
      v
Reverse Proxy
      |
      v
Backend Servers
```

A CDN uses reverse proxy functionality to receive user requests and communicate with origin infrastructure when necessary.

#### How CDN Reverse Proxying Works

Suppose the origin server has the public IP address:

`203.0.113.10`

When CDN proxying is enabled, users communicate with the CDN edge rather than directly connecting to the origin.

The CDN maintains two separate communication paths:

1. Client to CDN edge.
2. CDN edge to origin server.

This separation is extremely important for troubleshooting.

For example, the IIS origin may be accessible directly, but the website may still fail through the CDN because of an origin firewall restriction, TLS certificate issue, or CDN configuration problem.

### 6. Understanding the Complete HTTP Request Lifecycle

Let's examine what happens when a user accesses:

`https://www.example.com/products`

The process involves DNS resolution, network connectivity, TLS negotiation, HTTP processing, caching, and potentially origin communication.

#### Step 1: DNS Resolution

The browser obtains the CDN-facing IP address associated with the requested hostname.

#### Step 2: TCP Connection Establishment

For HTTP/1.1 and HTTP/2 over TCP, the browser establishes a TCP connection with the CDN edge.

The standard HTTPS destination port is 443.

The TCP three-way handshake consists of:

* SYN
* SYN-ACK
* ACK

This establishes the TCP connection.

#### Step 3: TLS Handshake

The browser and CDN negotiate encryption.

The CDN presents its TLS certificate, and the browser validates the certificate against the hostname and its trust requirements.

Once the handshake completes, encrypted communication is established.

#### Step 4: HTTP Request

The browser sends an HTTP request.

A simplified example:

```
GET /products HTTP/1.1
Host: www.example.com
User-Agent: Mozilla/5.0
Accept: text/html
Accept-Encoding: gzip, br
Connection: keep-alive
```

The request contains information such as the requested resource, hostname, user agent, and supported content encoding.

#### Step 5: CDN Edge Processing

The CDN receives the request and evaluates applicable policies.

Depending on the provider and configuration, these can include:

* Request validation.
* WAF inspection.
* DDoS mitigation.
* Rate limiting.
* Routing policies.
* Cache eligibility checks.

#### Step 6: Cache Lookup

The CDN checks whether the requested resource is available in its cache.

If an eligible cached response exists, it may return the response directly.

If the response is unavailable or cannot be served from cache, the CDN forwards the request towards the origin.

#### Step 7: Origin Communication

The CDN establishes or reuses an appropriate connection to the origin server.

The origin may be accessed directly or through an intermediate origin shield.

#### Step 8: Load Balancing

If the organization has multiple backend servers, a load balancer distributes incoming requests across available servers.

For example:

* IIS Web Server 01
* IIS Web Server 02

The load balancer selects an appropriate backend based on its configured distribution and health-check policies.

#### Step 9: Application Processing

The IIS server processes the application request.

If database access is required, the application communicates with the database server.

#### Step 10: Response Delivery

The origin returns the response through the CDN.

The CDN may cache the response if it is eligible under the configured caching policies.

The final response is delivered to the user's browser.

### 7. TCP, TLS, and HTTP/3 in CDN Architecture

Understanding network protocols is essential for CDN engineers.

#### TCP

Transmission Control Protocol provides reliable, ordered communication.

HTTP/1.1 and HTTP/2 commonly operate over TCP.

The TCP three-way handshake establishes a connection before application data is exchanged.

#### TLS

Transport Layer Security encrypts communication between clients and servers.

CDN platforms commonly terminate TLS at edge locations.

They can then establish a separate TLS connection to origin infrastructure.

#### HTTP/3 and QUIC

HTTP/3 operates over QUIC, which uses UDP as its underlying transport.

Unlike traditional HTTP/1.1 and HTTP/2 over TCP, HTTP/3 uses QUIC to provide encrypted, multiplexed communication with improved connection establishment and transport behaviour.

A CDN can support HTTP/3 between a browser and its edge infrastructure while using a different HTTP version for origin communication.

For example:

| Connection            | Possible protocol                         |
| --------------------- | ----------------------------------------- |
| Browser to CDN        | HTTP/3                                    |
| CDN to origin         | HTTP/2                                    |
| Origin to application | HTTP/1.1 or application-specific protocol |

This allows CDN infrastructure to optimize communication independently on each side of the reverse proxy.

### 8. CDN Cache HIT and Cache MISS

Caching determines whether a CDN can deliver a resource directly or needs to contact the origin.

#### Cache HIT

A cache hit occurs when the requested resource is already available as a fresh, eligible cached object.

Example:

A user requests:

`https://www.example.com/images/logo.png`

The CDN checks its cache and finds the requested image.

The cached response is returned without contacting the origin.

Benefits include:

* Reduced origin server traffic.
* Lower bandwidth consumption at the origin.
* Faster delivery of cached resources.
* Improved scalability.

#### Cache MISS

A cache miss occurs when the requested resource is not available in the CDN cache.

The request is forwarded towards the origin.

The origin retrieves or generates the requested response, which the CDN may subsequently cache if eligible.

Example:

```
User
  |
  v
CDN Edge
  |
  v
Cache Lookup
  |
  v
Object Not Found
  |
  v
Origin Shield (if configured)
  |
  v
Load Balancer
  |
  v
IIS Server
  |
  v
Response
  |
  v
CDN Cache (if eligible)
  |
  v
User
```

Not every response is cacheable. Dynamic applications and personalized content require appropriate caching controls.

### 9. Understanding Origin Shield

Origin Shield is an intermediate caching layer used by some CDN platforms.

Imagine users from Mumbai, London, and Singapore requesting the same uncached image.

Without an origin shield, multiple edge locations may independently request that resource from the origin.

With Origin Shield, requests can pass through a designated intermediate cache.

If the content is already available at that layer, it can be returned without another origin request.

This reduces repeated communication with the origin and can improve cache efficiency.

However, origin shielding does not guarantee that every cache miss will result in only one origin request. The outcome depends on cache keys, concurrent requests, expiration, and provider implementation.

### 10. Important CDN HTTP Response Headers

CDN administrators regularly use HTTP response headers to investigate caching behaviour and delivery issues.

Some important headers include:

| Header          | Purpose                                                 |
| --------------- | ------------------------------------------------------- |
| Cache-Control   | Defines caching directives                              |
| Age             | Indicates time a response has resided in a shared cache |
| ETag            | Identifies a resource version                           |
| Last-Modified   | Indicates when a resource was last modified             |
| Vary            | Defines request headers affecting response selection    |
| CF-Cache-Status | Cloudflare-specific cache status                        |
| CF-Ray          | Cloudflare request identifier                           |

For example:

```
Cache-Control: public, max-age=3600
```

This indicates that the response can be cached by shared and private caches for up to 3600 seconds, subject to other caching rules.

Another example:

```
Cache-Control: no-store
```

This instructs compliant caches not to store the response.

#### Common Cloudflare Cache Status Values

| Status  | Meaning                    |
| ------- | -------------------------- |
| HIT     | Served from cache          |
| MISS    | Cache object not found     |
| BYPASS  | Cache bypassed             |
| DYNAMIC | Treated as dynamic content |
| EXPIRED | Cached content expired     |

These headers are useful when troubleshooting why a resource is repeatedly contacting the origin or why updated content is not appearing.

### 11. TLS Termination and CDN-to-Origin Communication

TLS termination is another important concept in CDN architecture.

When a user accesses an HTTPS website through a CDN, two separate encrypted connections may be established.

#### Connection 1: Client to CDN

* Browser establishes HTTPS communication.
* CDN presents its edge certificate.
* Browser validates the certificate.
* Encrypted communication is established.

#### Connection 2: CDN to Origin

* CDN connects to the origin server.
* Origin presents its certificate.
* CDN validates the origin certificate when strict validation is enabled.
* A separate encrypted connection is established.

For example, Cloudflare provides several SSL/TLS modes:

| Mode          | Client to CDN | CDN to origin                               |
| ------------- | ------------- | ------------------------------------------- |
| Off           | HTTP          | HTTP                                        |
| Flexible      | HTTPS         | HTTP                                        |
| Full          | HTTPS         | HTTPS without strict certificate validation |
| Full (strict) | HTTPS         | HTTPS with origin certificate validation    |

For production infrastructure, Full (strict) is generally recommended when the origin supports valid TLS and certificate validation.

This protects communication between both sides of the CDN reverse proxy.

### 12. Integrating CDN with WAF, Load Balancers, and Network Firewalls

CDNs are frequently deployed alongside other infrastructure and security technologies.

Consider an enterprise application with the following components:

* Cloudflare CDN.
* Cloudflare WAF.
* FortiGate network firewall.
* F5 load balancer.
* Two Windows IIS servers.
* Microsoft SQL Server.

A typical request flow could be:

```
              INTERNET USERS
                     |
                     v
                 DNS SERVICE
                     |
                     v
                 CDN EDGE
                     |
             +-------+-------+
             |               |
            WAF          DDoS Protection
             |               |
             +-------+-------+
                     |
                     v
               NETWORK FIREWALL
                     |
                     v
                F5 LOAD BALANCER
                     |
             +-------+-------+
             |               |
          IIS WEB-01      IIS WEB-02
             |               |
             +-------+-------+
                     |
                     v
                SQL SERVER
```

Each technology has a different responsibility.

**CDN:** Handles distributed content delivery, caching, and reverse proxying.

**WAF:** Inspects HTTP requests and blocks malicious application-layer traffic according to configured policies.

**Network Firewall:** Controls permitted network connections.

**Load Balancer:** Distributes requests across backend servers.

**IIS:** Processes application requests.

**SQL Server:** Stores and retrieves application data.

The actual placement and order of these components depend on the organization's architecture.

One important security requirement is restricting direct access to origin infrastructure where possible. Otherwise, attackers may bypass CDN security controls and target the origin directly.

### 13. What Happens When the Origin Server Goes Down?

A CDN does not automatically make an application highly available.

Consider an infrastructure where:

* The CDN is operational.
* DNS is operational.
* The origin IIS server is unavailable.

If a requested image is already available as a fresh cached object, the CDN may continue serving it.

However, a request for uncached content may fail because the CDN cannot retrieve it from the origin.

Some CDN platforms also support stale-content delivery during origin failures, depending on their caching features and configuration.

| Situation                                 | Possible result                              |
| ----------------------------------------- | -------------------------------------------- |
| Origin unavailable, fresh cached image    | CDN can serve cached image                   |
| Origin unavailable, uncached resource     | Request may fail                             |
| Origin unavailable, dynamic login page    | Usually fails                                |
| Origin unavailable, stale cached resource | May be served if configured                  |
| One IIS server unavailable                | Load balancer can use another healthy server |

A resilient CDN architecture should consider origin health monitoring, multiple backend servers, origin failover, stale cache policies, and application monitoring.

### 14. Practical CDN Troubleshooting

CDN engineers need to understand how to investigate problems across the client-to-edge and edge-to-origin communication paths.

Here are some commonly encountered Cloudflare HTTP status codes:

| Error | Typical area to investigate   |
| ----- | ----------------------------- |
| 522   | Connection from CDN to origin |
| 524   | Origin response timeout       |
| 525   | Origin TLS handshake          |
| 526   | Origin certificate validation |

These errors provide useful diagnostic indicators, but the underlying cause must be confirmed using logs, connectivity tests, and provider documentation.

Other common problems include:

**Website works directly but not through CDN**

Investigate DNS, edge TLS, WAF policies, origin connectivity, and CDN configuration.

**Static files are not updating**

Investigate cache TTL, cache keys, origin response headers, and cache purging.

**Website is slow for international users**

Investigate edge routing, network paths, origin response times, cache-hit ratio, and CDN connectivity.

**Login pages display unexpected content**

Review cache rules, cookies, authentication behaviour, and cache-key configuration.

**Origin IP is publicly accessible**

Review DNS exposure, historical DNS records, firewall allowlists, and direct origin access controls.

### 15. Practical Lab: Investigating CDN Request Flow

A hands-on lab is one of the best ways to understand CDN architecture.

For this exercise, you need:

* A Windows 10/11 or Windows Server machine.
* PowerShell.
* A domain you control.
* A website configured behind a CDN.

#### Lab 1: Inspect DNS Resolution

Execute:

```
Resolve-DnsName yourdomain.com

nslookup yourdomain.com
```

Observe the returned IP addresses and determine whether the domain resolves to CDN-facing infrastructure.

#### Lab 2: Inspect HTTP Headers

Execute:

```
curl.exe -I https://yourdomain.com
```

Look for:

```
HTTP/2 200
Server: cloudflare
CF-Cache-Status: HIT
CF-Ray: ...
Cache-Control: public, max-age=3600
```

The output will depend on the CDN provider and website configuration.

#### Lab 3: Investigate Static Resource Caching

Select a publicly accessible image:

```
curl.exe -I https://yourdomain.com/images/logo.png
```

Repeat the request and compare:

* CF-Cache-Status.
* Age.
* Cache-Control.
* HTTP response code.

You may observe a MISS followed by a HIT if the resource is cacheable and the cache is populated.

#### Lab 4: Test Connectivity

Execute:

```
Test-NetConnection yourdomain.com -Port 443
```

This checks whether a TCP connection to the resolved destination on port 443 can be established.

#### Lab 5: Investigate Network Routing

Execute:

```
tracert yourdomain.com
```

This helps investigate the network path towards the CDN-facing IP.

Remember that traceroute may not reveal the exact CDN edge location or internal routing path.

#### Lab 6: Measure Response Time

Execute:

```
curl.exe -o NUL -s -w `
"DNS: %{time_namelookup}s`nConnect: %{time_connect}s`nTLS: %{time_appconnect}s`nTTFB: %{time_starttransfer}s`nTotal: %{time_total}s`n" `
https://yourdomain.com
```

This provides useful timing measurements for DNS resolution, connection establishment, TLS negotiation, time to first byte, and total response duration.

### 16. Conclusion

CDN architecture involves much more than distributing website images and static files.

It combines networking, DNS, Anycast routing, reverse proxying, HTTP protocols, TLS termination, caching, security inspection, and origin infrastructure.

Understanding the complete request lifecycle helps infrastructure engineers identify where problems occur and how different technologies interact.

For organizations running production websites, combining CDN, WAF, load balancing, and network firewall technologies can provide a scalable application delivery architecture.

For engineers working in Windows infrastructure, networking, cloud administration, and application security, CDN knowledge is an increasingly valuable technical skill.

The best way to develop this expertise is to understand the underlying architecture first and then implement it using real CDN platforms such as Cloudflare, Akamai, AWS CloudFront, Fastly, and Azure Front Door.

**The key takeaway:** A CDN is not just a caching solution. It is a distributed reverse-proxy and application delivery layer that connects users to origin infrastructure through globally distributed networking and security capabilities.

***

**Author's Practical Recommendation**

Build a test environment using a Windows Server with IIS, place a CDN in front of it, and observe the complete request flow.

Experiment with DNS resolution, cache HIT/MISS behaviour, TLS configuration, origin connectivity, and WAF policies.

Understanding these interactions will help you move beyond basic CDN configuration towards production-level CDN architecture and troubleshooting.
