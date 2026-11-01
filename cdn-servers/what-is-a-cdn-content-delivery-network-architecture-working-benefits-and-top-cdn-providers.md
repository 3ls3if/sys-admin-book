---
icon: interrobang
---

# What Is a CDN (Content Delivery Network)? Architecture, Working, Benefits, and Top CDN Providers

## What Is a CDN (Content Delivery Network)? Architecture, Working, Benefits, and Top CDN Providers

<figure><img src="../.gitbook/assets/Screenshot 2026-11-01 at 10.21.04 PM.png" alt=""><figcaption></figcaption></figure>

### Introduction

Website performance, application availability, and security are essential components of modern IT infrastructure. As businesses expand their online presence and serve customers across different geographical locations, delivering content quickly and reliably becomes increasingly challenging.

A website hosted on a single origin server may perform well for users located near the data centre. However, users accessing the same website from distant geographical locations may experience higher latency, slower page loading, and inconsistent performance.

This is where a **Content Delivery Network (CDN)** becomes important.

A CDN is a globally distributed network of servers designed to deliver website content, application resources, images, videos, scripts, and other digital assets from locations closer to end users.

CDN technology improves website performance, reduces origin server workload, helps protect applications against certain cyberattacks, and provides a scalable content delivery infrastructure.

In this article, we will explore CDN architecture, how it works, its major components, integration with load balancers and WAFs, and some of the leading CDN providers available in the market.

### 1. What Is a CDN?

A Content Delivery Network (CDN) is a geographically distributed infrastructure consisting of interconnected edge servers that deliver cached content to users from locations closer to their geographical position.

Instead of sending every user request directly to the origin server, a CDN intercepts requests and determines whether the requested content is already available in its cache.

If the content is cached, the CDN delivers it directly from an edge location. If the content is not cached, the CDN retrieves it from the origin server and may store a copy for subsequent requests, depending on caching policies.

For example:

Consider a website hosted on a Windows Server with IIS in a Mumbai data centre.

A user accessing the website from London may experience additional network latency because requests must travel across multiple networks to reach the origin server.

By implementing a CDN, the website's static resources can be cached at an edge location closer to the user.

When another user requests the same resources, the CDN can deliver them from its nearby edge infrastructure without repeatedly contacting the origin server.

### 2. How Does a CDN Work?

<figure><img src="../.gitbook/assets/Screenshot 2026-11-01 at 10.22.04 PM.png" alt=""><figcaption></figcaption></figure>

A CDN generally works as a reverse proxy positioned between end users and the origin infrastructure.

The request flow typically follows these steps:

1. A user enters a website URL in a browser.
2. DNS resolution directs the request towards the CDN infrastructure.
3. The request reaches an appropriate CDN edge location.
4. The CDN evaluates security policies, including applicable WAF and DDoS protection rules.
5. The CDN checks whether the requested content is available in its cache.
6. If the content is available, the CDN returns it directly to the user.
7. If the content is unavailable, the CDN forwards the request to the origin server.
8. The origin server processes the request and returns the response.
9. The CDN may cache the response according to its caching policies.
10. The response is delivered to the end user.<br>

```
              INTERNET USERS
                    |
                    v
               DNS SERVICE
                    |
                    v
             CDN EDGE NETWORK
                    |
             +------+------+
             |             |
            WAF        DDoS Protection
             |             |
             +------+------+
                    |
               Cache Check
                    |
             +------+------+
             |             |
          CACHE HIT     CACHE MISS
             |             |
             v             v
          CLIENT       ORIGIN SHIELD
                           |
                           v
                     LOAD BALANCER
                           |
                   +-------+-------+
                   |               |
                IIS WEB-01      IIS WEB-02
                   |               |
                   +-------+-------+
                           |
                     DATABASE SERVER
```

#### CDN Cache Hit

A cache hit occurs when the requested resource is already available in the CDN cache.

For example, when a user requests:

`https://example.com/images/logo.png`

If the image is already cached at the CDN edge location, the CDN delivers it directly without requesting the resource from the origin server.

This reduces response time and origin server workload.

#### CDN Cache Miss

A cache miss occurs when the requested resource is not available in the CDN cache or cannot be served from the existing cached copy.

In this situation:

* The CDN forwards the request to the origin.
* The origin server processes the request.
* The response is returned through the CDN.
* The CDN may store the response for future requests.

Not every response is cacheable. Dynamic content, authenticated requests, and resources with restrictive cache directives may require special handling.

### 3. CDN Architecture and Its Major Components

A CDN consists of several components that work together to provide reliable and efficient content delivery.

#### A. Points of Presence (PoPs)

Points of Presence (PoPs) are geographically distributed locations containing CDN infrastructure.

These locations host edge servers that receive and process user requests.

The primary purpose of PoPs is to reduce the distance between users and the infrastructure delivering their content.

For example, a CDN provider may have edge locations across India, Europe, North America, and Asia-Pacific.

Users are generally directed towards an appropriate available edge location based on the provider's traffic-routing mechanisms.

#### B. Edge Servers

Edge servers are responsible for handling requests from end users.

They perform functions such as:

* Processing incoming HTTP and HTTPS requests.
* Delivering cached content.
* Applying configured security policies.
* Forwarding cache misses to origin infrastructure.
* Managing connections and response delivery.

Edge servers are one of the most important components of CDN architecture.

#### C. Cache

Caching is the fundamental technology behind CDN content delivery.

A CDN stores copies of eligible resources so that subsequent requests can be served without repeatedly accessing the origin server.

Commonly cached resources include:

* Images and logos.
* CSS stylesheets.
* JavaScript files.
* Fonts.
* Videos.
* Downloadable files.
* Other static website resources.

Caching behaviour depends on cache rules, cache keys, response headers, and provider-specific configurations.

#### D. Origin Server

The origin server is the actual infrastructure hosting the website or application.

It may consist of:

* Windows Server with IIS.
* Linux Server with Apache or Nginx.
* Application servers.
* Cloud-hosted virtual machines.
* Object storage services.

The CDN communicates with the origin server whenever it needs to retrieve content that cannot be served from its cache.

#### E. Origin Shield

Origin Shield is an additional caching layer provided by some CDN platforms.

Instead of multiple edge locations independently sending repeated requests to the origin, requests can pass through a centralized or designated intermediate caching layer.

This helps reduce origin traffic and improve cache efficiency.

#### F. DNS Integration

DNS plays an important role in CDN implementation.

When a domain is configured behind a CDN, its DNS records are configured to direct eligible traffic through the CDN provider.

Depending on the platform, this can involve CNAME records, proxy-enabled DNS records, or other provider-specific routing mechanisms.

#### G. TLS/SSL

CDN providers support HTTPS connections between users and edge infrastructure.

Many platforms also support secure connections between the CDN and origin server.

For production deployments, it is important to configure appropriate TLS certificates and validate the origin certificate.

### 4. CDN Architecture with a Load Balancer, WAF, and Firewall

A CDN does not necessarily replace existing infrastructure components such as load balancers, WAFs, or network firewalls.

Instead, these technologies can work together to create a comprehensive application delivery and security architecture.

A typical architecture looks like this:

**Internet Users → DNS → CDN Edge → WAF → Load Balancer → Origin Web Servers → Database**

Each component performs a different responsibility.

| Component        | Responsibility                                     |
| ---------------- | -------------------------------------------------- |
| DNS              | Resolves domain names and directs traffic          |
| CDN              | Delivers cached content from distributed locations |
| WAF              | Inspects and filters malicious HTTP requests       |
| DDoS Protection  | Helps mitigate denial-of-service attacks           |
| Load Balancer    | Distributes requests across backend servers        |
| Network Firewall | Controls network-level traffic                     |
| Origin Server    | Hosts the actual website or application            |
| Database Server  | Stores application data                            |

For example, consider an organization hosting an application on two Windows IIS servers.

The architecture could be:

1. Cloudflare or another CDN provider receives external website traffic.
2. CDN security policies inspect incoming requests.
3. Eligible static resources are delivered from edge cache.
4. Requests requiring origin processing are forwarded to the organization's infrastructure.
5. A load balancer distributes requests between IIS Web Server 01 and IIS Web Server 02.
6. The application communicates with the database server when required.

This architecture combines global content delivery, application security, and backend traffic distribution.

It is important to configure trusted origin connections and restrict direct access to origin servers where appropriate. Otherwise, attackers may bypass the CDN and target the origin directly.

### 5. Types of CDN Content Delivery

CDN caching strategies depend on the nature of the content being delivered.

#### A. Static Content Delivery

Static content generally remains unchanged until the website administrator updates it.

Examples include:

* Images.
* CSS files.
* JavaScript files.
* Fonts.
* Videos and downloadable documents.

These resources are suitable for CDN caching because they can often be served repeatedly without generating a new response from the application.

#### B. Dynamic Content Delivery

Dynamic content is generated or modified based on user requests, application logic, sessions, or database information.

Examples include:

* Login pages.
* User dashboards.
* Shopping cart information.
* Account information.
* Real-time application data.

Dynamic content generally requires communication with the origin application.

However, some dynamic responses can also be cached safely when appropriate application and CDN rules are implemented.

#### C. Video and Media Delivery

CDNs are widely used for video streaming and media distribution.

They help distribute large media files across geographically distributed infrastructure, reducing the need for repeated downloads from a single origin server.

### 6. Important CDN Caching Concepts

Understanding caching is essential for CDN administration and troubleshooting.

#### Cache-Control

Cache-Control is an HTTP response header that defines caching behaviour.

Example:

`Cache-Control: public, max-age=3600`

This indicates that the response may be stored by shared and private caches for up to 3600 seconds, subject to applicable caching rules.

Another example:

`Cache-Control: no-store`

This instructs compliant caches not to store the response.

#### Time to Live (TTL)

TTL defines how long cached content remains fresh before it expires or requires revalidation.

For example:

A static image may have a TTL of 24 hours, whereas frequently updated content may require a shorter caching period.

#### Cache Key

A cache key determines how the CDN identifies and separates cached resources.

It can include elements such as:

* Request URL.
* Query strings.
* Selected HTTP headers.
* Cookies, depending on configuration.

Incorrect cache-key configuration can result in inefficient caching or, in serious cases, the accidental delivery of one user's personalized content to another user.

#### Cache Purging

Cache purging removes stored content from CDN infrastructure.

It is useful when:

* Website images are updated.
* CSS or JavaScript files are modified.
* Content is published or removed.
* An incorrect cached response needs to be cleared.

CDN providers commonly support full-cache purging and selective purging of individual resources.

### 7. Popular CDN Providers in the Market

Several providers offer CDN services with different infrastructure models, security features, and pricing structures.

#### 1. Cloudflare

Cloudflare is one of the widely used providers offering CDN, DNS, reverse proxy, DDoS protection, and Web Application Firewall services.

Important features include:

* Global CDN.
* DNS management.
* WAF.
* DDoS protection.
* SSL/TLS management.
* Cache Rules.
* Workers for edge computing.
* Origin protection features.

Official documentation: [https://developers.cloudflare.com/](https://developers.cloudflare.com/)

#### 2. Akamai

Akamai is an established enterprise CDN and cybersecurity provider.

Its services are used for large-scale content delivery, application acceleration, and web security.

Important areas include:

* Enterprise content delivery.
* Application and API security.
* Edge DNS.
* DDoS protection.
* Origin management.
* Advanced traffic and delivery optimization.

Official documentation: [https://techdocs.akamai.com/](https://techdocs.akamai.com/)

#### 3. Amazon CloudFront

Amazon CloudFront is AWS's content delivery network service.

It integrates with other AWS services and supports global content distribution.

Important features include:

* CloudFront distributions.
* Cache behaviours.
* Origin Access Control.
* AWS WAF integration.
* Lambda@Edge.
* CloudFront Functions.
* Integration with Amazon S3 and other origin services.

Official documentation: [https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)

#### 4. Fastly

Fastly provides edge cloud and content delivery services, with capabilities for advanced caching and application delivery.

Important features include:

* Advanced caching.
* Cache invalidation.
* VCL configuration.
* Edge computing.
* Web application security.
* Real-time observability.

Official documentation: [https://www.fastly.com/documentation/](https://www.fastly.com/documentation/)

#### 5. Google Cloud CDN

Google Cloud CDN is a content delivery service integrated with Google Cloud infrastructure.

Important features include:

* Global edge infrastructure.
* Integration with Google Cloud Load Balancing.
* Cache configuration.
* Origin and backend configuration.
* HTTPS delivery.
* Cloud-based application acceleration.

Official documentation: [https://docs.cloud.google.com/cdn/docs/overview](https://docs.cloud.google.com/cdn/docs/overview)

#### 6. Microsoft Azure Front Door

Azure Front Door is Microsoft's global application delivery service combining global HTTP/HTTPS load balancing, CDN capabilities, and application security.

Important features include:

* Global traffic routing.
* CDN caching.
* Origin groups.
* Health probes.
* Web Application Firewall integration.
* TLS management.
* Application acceleration.

Official documentation: [https://learn.microsoft.com/en-us/azure/frontdoor/](https://learn.microsoft.com/en-us/azure/frontdoor/)

#### 7. Bunny.net

Bunny.net offers CDN and edge delivery services with a focus on accessible configuration and content distribution.

Important features include:

* Pull zones.
* CDN caching.
* Cache purging.
* Storage zones.
* Image optimization.
* Video delivery options.

Official documentation: [https://docs.bunny.net/](https://docs.bunny.net/)

### 8. Benefits of Implementing a CDN

Implementing a CDN can provide several benefits to organizations.

**Improved Website Performance**

Delivering cached resources from nearby edge locations reduces network latency and improves content delivery speed.

**Reduced Origin Server Load**

Cached resources do not need to be retrieved from the origin for every request. This reduces bandwidth consumption and backend processing requirements.

**Better Scalability**

A distributed delivery infrastructure can handle large volumes of content requests more efficiently than relying entirely on a single origin server.

**Improved Availability**

Many CDN platforms provide distributed infrastructure and origin failover capabilities that can help maintain content delivery during infrastructure disruptions.

**Enhanced Security**

CDN providers often integrate WAF, DDoS protection, bot management, TLS, and other security features.

**Reduced Bandwidth Consumption**

Serving eligible cached resources from edge locations reduces repeated data transfers from the origin infrastructure.

### 9. CDN Security Considerations

A CDN can improve application security, but correct configuration is essential.

Important security practices include:

1. Enable HTTPS for all website traffic.
2. Use strict TLS validation between the CDN and origin.
3. Restrict direct public access to origin servers where possible.
4. Configure WAF rules based on application requirements.
5. Enable suitable DDoS protection.
6. Review cache rules carefully, especially for authenticated and personalized content.
7. Avoid caching sensitive application responses.
8. Monitor CDN logs and security events.
9. Review access controls and API tokens.
10. Test origin access and CDN bypass scenarios.

One particularly important consideration is protecting the origin server.

If the origin server remains directly accessible from the public internet, attackers may discover its IP address and attempt to bypass CDN security controls.

Organizations should consider restricting origin traffic to trusted CDN infrastructure, while maintaining secure administrative access and appropriate monitoring.

### 10. Practical CDN Implementation Example

Consider a company hosting its website on Windows Server 2022 with IIS.

The infrastructure consists of:

* One domain name.
* Two IIS web servers.
* One load balancer.
* One database server.
* A public internet connection.

The organization wants to improve website performance for international users.

A CDN can be introduced without completely redesigning the existing infrastructure.

A typical implementation process is:

**Step 1: Prepare the Origin Infrastructure**

Verify that the website is accessible through the existing load balancer and that the origin application is functioning correctly.

**Step 2: Configure the CDN Provider**

Add the domain to the selected CDN platform and configure the required DNS records.

**Step 3: Configure SSL/TLS**

Install or configure the required certificates and establish secure communication between the CDN and origin.

**Step 4: Enable CDN Proxying**

Route eligible website traffic through the CDN infrastructure.

**Step 5: Configure Cache Rules**

Define caching policies for images, CSS, JavaScript, fonts, and other eligible resources.

**Step 6: Configure Security Policies**

Enable WAF rules, DDoS protection, and appropriate origin access restrictions.

**Step 7: Validate CDN Behaviour**

Use HTTP response headers to verify whether requests are served from cache.

For example, with Cloudflare:

`curl.exe -I https://example.com`

Check the response for headers such as:

* `CF-Cache-Status`
* `CF-Ray`
* `Cache-Control`
* `Age`

Depending on the response and configuration, cache status values may include HIT, MISS, BYPASS, DYNAMIC, or EXPIRED.

**Step 8: Monitor Performance**

Compare response times, origin traffic, cache-hit ratios, bandwidth usage, and application availability before and after implementation.

### 11. CDN vs Load Balancer vs WAF vs Network Firewall

Although these technologies can work together, they perform different functions.

| Technology       | Primary Function                                      |
| ---------------- | ----------------------------------------------------- |
| CDN              | Distributed content delivery and caching              |
| Load Balancer    | Distributes requests across backend servers           |
| WAF              | Protects web applications from malicious HTTP traffic |
| Network Firewall | Controls network traffic based on security policies   |
| DNS              | Resolves domain names and directs traffic             |

A CDN focuses on content delivery and edge processing, whereas a load balancer focuses on distributing traffic across backend resources.

A WAF inspects application-layer requests, while a network firewall enforces network-level access policies.

Understanding these differences is important when designing secure and scalable enterprise infrastructure.

### 12. Conclusion

Content Delivery Networks have become an important component of modern internet infrastructure.

They help organizations improve application performance, reduce origin server workload, distribute content globally, and strengthen application security.

For infrastructure and network engineers, understanding CDN architecture is valuable because modern application delivery increasingly combines CDN, DNS, WAF, DDoS protection, load balancing, and origin infrastructure.

Learning platforms such as Cloudflare, Akamai, AWS CloudFront, Fastly, Google Cloud CDN, and Azure Front Door provides a practical understanding of how different vendors implement content delivery technologies.

Rather than focusing only on vendor-specific dashboards, engineers should understand the underlying concepts of caching, reverse proxying, DNS routing, HTTP protocols, TLS, edge computing, and origin protection.

These fundamentals provide the foundation for designing, implementing, and troubleshooting production-grade CDN architectures.

***

**Author's Note**

If you are working in Windows infrastructure, networking, cloud administration, or application security, consider building a practical CDN lab by placing a CDN in front of an IIS-hosted website. Experiment with cache HIT/MISS behaviour, SSL/TLS configuration, WAF policies, origin protection, and cache purging.

Hands-on implementation is one of the best ways to understand how CDN technology operates in real-world environments.
