# Custom Nameservers: What They Are, How They Work, and How to Configure Them on Windows Server

### Introduction

DNS (Domain Name System) is responsible for translating domain names such as `example.com` into IP addresses that computers can use to connect to servers.

By default, when you purchase a domain from a registrar such as GoDaddy, the domain is generally managed using the registrar's DNS nameservers. However, organizations that manage their own infrastructure may want to host DNS themselves.

For example, instead of using the registrar's nameservers, you may want to configure:

```
ns1.example.com
ns2.example.com
```

as your custom nameservers and manage DNS records from your own Windows Server.

This article explains how custom nameservers work and how to configure them.

***

## 1. What Is a Nameserver?

A nameserver is a DNS server responsible for answering DNS queries for a domain.

For example, when someone accesses:

```
www.example.com
```

the DNS resolution process eventually asks the authoritative nameserver:

```
What is the IP address of www.example.com?
```

The nameserver responds with something like:

```
www.example.com → 203.0.113.50
```

The browser can then connect to that IP address.

***

## 2. What Is a Custom Nameserver?

A custom nameserver is a DNS server using a hostname under your own domain.

For example:

```
ns1.example.com
ns2.example.com
```

Instead of:

```
dns1.registrar-provider.com
dns2.registrar-provider.com
```

your domain can use your own DNS infrastructure.

A typical architecture looks like:

```
                Internet
                    |
                    v
             example.com
                    |
          +---------+---------+
          |                   |
          v                   v
 ns1.example.com       ns2.example.com
 203.0.113.10           203.0.113.11
          |                   |
          v                   v
   Windows DNS #1       Windows DNS #2
```

***

## 3. Why Use Custom Nameservers?

There are several reasons an organization may choose to operate its own DNS.

#### Centralized DNS Management

You can manage DNS records directly from your own DNS infrastructure instead of logging into the domain registrar.

#### Infrastructure Control

You have greater control over:

* DNS zones
* A records
* MX records
* CNAME records
* TXT records
* SRV records
* NS records
* SOA parameters

#### Branding

Instead of using a third-party nameserver such as:

```
ns1.some-dns-provider.com
```

you can use:

```
ns1.example.com
ns2.example.com
```

#### Internal Infrastructure Integration

Organizations managing their own servers may prefer to maintain DNS alongside their Windows Server infrastructure.

***

## 4. Understanding A Records vs. Nameservers

One of the most important concepts is that an **A record is not the same thing as a nameserver registration**.

For example, you might create:

```
ns1.example.com → 203.0.113.10
ns2.example.com → 203.0.113.10
```

These are A records.

However, simply creating these records does **not always make `ns1.example.com` and `ns2.example.com` valid nameservers at the registrar**.

You also need to register them as **custom hostnames / child nameservers / glue records** with the domain registrar.

The process is generally:

```
Create A records
       ↓
Register custom hostnames
       ↓
Create DNS zone on DNS server
       ↓
Configure NS records
       ↓
Change domain nameservers
       ↓
DNS propagation
```

***

## 5. What Is a Glue Record?

A glue record is particularly important when your nameserver is located **inside the same domain**.

Suppose:

```
Domain: example.com
Nameserver:ns1.example.com
```

The problem is that to find `ns1.example.com`, DNS needs to know the IP address of `ns1.example.com`.

But the nameserver for `example.com` is itself `ns1.example.com`.

This creates a circular dependency.

The registry/registrar solves this using a **glue record**:

```
ns1.example.com → 203.0.113.10
```

The glue record tells the DNS system where the nameserver actually resides.

***

## 6. Example: Creating Custom Nameservers

Suppose you have:

```
Domain:gtsolutions.in
Windows DNS Server:103.171.45.249
```

You want:

```
ns1.gtsolutions.in
ns2.gtsolutions.in
```

Your intended configuration would be:

```
ns1.gtsolutions.in → 103.171.45.249
ns2.gtsolutions.in → 103.171.45.249
```

The DNS server should then host the:

```
gtsolutions.in
```

DNS zone.

***

## 7. Configure DNS on Windows Server

First, install the DNS Server role.

Using PowerShell:

```
Install-WindowsFeature -Name DNS -IncludeManagementTools
```

Verify the installation:

```
Get-WindowsFeature DNS
```

You can then open:

```
Server Manager
    ↓
Tools
    ↓
DNS
```

This opens DNS Manager.

***

## 8. Create the DNS Zone

In DNS Manager:

```
DNS
└── Server Name
    └── Forward Lookup Zones
```

Right-click **Forward Lookup Zones** and select:

```
New Zone
```

Create a primary zone:

```
gtsolutions.in
```

Your DNS structure should look like:

```
Forward Lookup Zones
└── gtsolutions.in
```

***

## 9. Create the Nameserver Records

Inside the `gtsolutions.in` zone, configure the required records.

For example:

```
ns1    A    103.171.45.249
ns2    A    103.171.45.249
```

This results in:

```
ns1.gtsolutions.in → 103.171.45.249
ns2.gtsolutions.in → 103.171.45.249
```

You can also create your normal DNS records.

For example:

```
www       A       103.171.45.249
mail      A       103.171.45.250
```

***

## 10. Configure NS Records

The DNS zone must identify the authoritative nameservers.

For example:

```
gtsolutions.in    NS    ns1.gtsolutions.in
gtsolutions.in    NS    ns2.gtsolutions.in
```

Conceptually, the configuration becomes:

```
gtsolutions.in
       |
       +--- NS → ns1.gtsolutions.in
       |
       +--- NS → ns2.gtsolutions.in

ns1.gtsolutions.in
       |
       +--- A → 103.171.45.249

ns2.gtsolutions.in
       |
       +--- A → 103.171.45.249
```

***

## 11. Register Custom Hostnames at the Registrar

This is a separate step from creating DNS A records.

At your registrar, look for an option such as:

* Hostnames
* Register Nameserver
* Child Nameservers
* Custom Nameservers
* Glue Records

For example, register:

```
Hostname: ns1
IP Address: 103.171.45.249
```

and:

```
Hostname: ns2
IP Address: 103.171.45.249
```

The registrar then registers these as usable nameservers.

***

## 12. Change the Domain's Nameservers

After the custom nameservers have been registered, change the domain's nameservers.

For:

```
gtsolutions.in
```

configure:

```
Nameserver 1:
ns1.gtsolutions.in

Nameserver 2:
ns2.gtsolutions.in
```

After this change, DNS queries for `gtsolutions.in` will be directed to your custom DNS infrastructure.

***

## 13. Configure the Firewall

A public DNS server must accept DNS traffic.

You need to allow:

```
UDP 53
TCP 53
```

On Windows Server, you can check the DNS firewall rules with:

```
Get-NetFirewallRule -DisplayGroup "DNS Server"
```

If required:

```
Enable-NetFirewallRule -DisplayGroup "DNS Server"
```

If the server is behind a firewall, NAT device, cloud security group, or FortiGate, TCP/UDP 53 must also be permitted there.

For example:

```
Internet
   |
   | TCP/UDP 53
   v
Firewall / NAT
   |
   v
Windows DNS Server
```

***

## 14. Test the DNS Server

Before changing the production nameservers, test your DNS server directly.

For example:

```
nslookup gtsolutions.in 103.171.45.249
```

You can also test the nameserver records:

```
nslookup -type=NS gtsolutions.in 103.171.45.249
```

You should receive responses from your Windows DNS server.

You can also verify that:

```
ns1.gtsolutions.in
```

resolves to:

```
103.171.45.249
```

***

## 15. DNS Propagation

After changing the domain's nameservers, DNS changes do not necessarily appear everywhere immediately.

DNS information is cached by:

* ISPs
* DNS resolvers
* routers
* operating systems
* browsers
* corporate DNS servers

Therefore, nameserver changes can take some time to propagate.

During this period, different users may temporarily receive different DNS responses depending on their resolver's cache.

***

## 16. The Importance of Two DNS Servers

Although you can technically configure:

```
ns1.example.com → 103.171.45.249
ns2.example.com → 103.171.45.249
```

this does **not provide real redundancy**.

Both nameservers are ultimately dependent on the same server/IP.

A better production architecture is:

```
ns1.example.com → 103.171.45.249
ns2.example.com → 203.0.113.20
```

where the second DNS server is ideally:

* On another physical/virtual server
* On a different network
* Preferably with a different provider/location

This protects DNS availability if the primary server fails.

***

## 17. Custom Nameserver vs. Registrar DNS

You don't always need to run your own DNS.

#### Registrar DNS

```
Domain
   ↓
Registrar DNS
   ↓
DNS records
```

Advantages:

* Easy to configure
* High availability
* No DNS server maintenance
* No need to expose your own server on port 53

#### Custom DNS

```
Domain
   ↓
ns1.example.com
   ↓
Your Windows DNS Server
   ↓
DNS records
```

Advantages:

* Full control
* Centralized infrastructure
* Custom DNS management
* Useful for organizations managing their own DNS infrastructure

However, it also means **you are responsible for DNS availability, security, backups, monitoring, and redundancy**.

***

## 18. Common Mistakes

#### Mistake 1: Creating only an A record

Creating:

```
ns1.example.com → IP
```

does not necessarily register it as a nameserver.

You also need the registrar-level custom hostname/glue registration.

#### Mistake 2: DNS port 53 is blocked

The server must be reachable on:

```
UDP 53TCP 53
```

#### Mistake 3: DNS zone doesn't exist

Your Windows DNS server must have:

```
example.com
```

as a DNS zone.

#### Mistake 4: NS records are incorrect

The zone must identify the correct authoritative nameservers.

#### Mistake 5: Both nameservers use the same server

This creates a single point of failure.

#### Mistake 6: Switching nameservers before testing

Always test your DNS server before changing the production delegation.

***

## Recommended Architecture

For a small lab or internal environment:

```
Domain Registrar
      |
      v
ns1.example.com
      |
      v
Windows DNS Server
```

For production:

```
                 Internet
                    |
             example.com
                    |
          +---------+---------+
          |                   |
          v                   v
 ns1.example.com       ns2.example.com
          |                   |
          v                   v
 DNS Server #1          DNS Server #2
 Different network     Different network
```

This provides much better DNS availability and resilience.

***

### Conclusion

Custom nameservers allow an organization to move authoritative DNS management from a registrar or third-party DNS provider to its own DNS infrastructure.

The key point is that configuring custom nameservers involves **three separate components**:

1. **Register the custom hostnames/glue records at the registrar**
2. **Configure the DNS zone and NS records on your DNS server**
3. **Delegate the domain to the new nameservers**

For example:

```
ns1.gtsolutions.in → 103.171.45.249
ns2.gtsolutions.in → 103.171.45.249

             ↓

gtsolutions.in
       ↓
Windows DNS Server
       ↓
A / MX / CNAME / TXT / SRV records
```

Once these components are correctly configured and TCP/UDP port 53 is publicly reachable, your Windows Server can act as the authoritative DNS server for the domain.
