---
icon: network-wired
---

# Configuring Hyper-V Internal Network with NAT and Port Forwarding

## Configuring Hyper-V Internal Network with NAT and Port Forwarding

Hyper-V provides several virtual networking options for connecting virtual machines to a network. One useful configuration is an **Internal Virtual Switch combined with NAT (Network Address Translation)**.

This setup is particularly useful when you have multiple virtual machines but only one public IP address available on the Hyper-V host.

In this blog, we will configure an Internal Hyper-V network, provide Internet access to the virtual machines using NAT, and configure port forwarding to access services such as RDP from outside the network.

***

### 1. Understanding the Architecture

In this configuration, the Hyper-V host has a public IP address, while the virtual machines use private IP addresses.

For example:

```
Public Internet
      |
      |
13.10.10.10 (public IP)
      |
+----------------------+
|   Hyper-V Host       |
|                      |
|  Internal-NAT        |
|  192.168.100.1       |
+----------+-----------+
           |
           |
   Private Network
  192.168.100.0/24
           |
     +-----+-----+
     |           |
    VM1         VM2
192.168.100.10  192.168.100.11
```

The Hyper-V host acts as the gateway for the VMs and performs NAT for Internet-bound traffic.

***

## 2. Why Use an Internal Network with NAT?

An Internal Hyper-V switch allows communication between the Hyper-V host and virtual machines.

However, an Internal switch alone does not provide Internet access.

By adding NAT, the virtual machines can access the Internet through the Hyper-V host.

#### Main benefits

* Multiple VMs can share a single public IP.
* VMs can use private IP addresses.
* Internet access can be provided without assigning public IPs to every VM.
* Network configuration is isolated from the physical LAN.
* Port forwarding can be used to selectively expose services.
* The configuration is useful for development, testing, labs, and small server environments.

***

## 3. Create an Internal Hyper-V Switch

Open **Hyper-V Manager** and select:

**Virtual Switch Manager → New virtual network switch → Internal**

Give the switch a name such as:

```
Internal-NAT
```

Alternatively, it can be created using PowerShell.

Run PowerShell as Administrator:

```powershell
New-VMSwitch -Name "Internal-NAT" -SwitchType Internal
```

Verify the switch:

```powershell
Get-VMSwitch
```

You should see:

```
Name          SwitchType
----          ----------
Internal-NAT  Internal
```

***

## 4. Configure the Host's Internal Adapter

When the Internal switch is created, Windows creates a virtual network adapter on the Hyper-V host:

```
vEthernet (Internal-NAT)
```

Assign a private IP address to this adapter.

For example:

```
IP Address: 192.168.100.1
Subnet Mask: 255.255.255.0
```

Using PowerShell:

```powershell
New-NetIPAddress `
    -IPAddress 192.168.100.1 `
    -PrefixLength 24 `
    -InterfaceAlias "vEthernet (Internal-NAT)"
```

The Hyper-V host will now act as the gateway for the private VM network.

***

## 5. Create the NAT Network

Next, create a Windows NAT configuration for the private subnet.

Run:

```powershell
New-NetNat `
    -Name "HyperV-NAT" `
    -InternalIPInterfaceAddressPrefix 192.168.100.0/24
```

Verify the NAT:

```powershell
Get-NetNat
```

You should see:

```
Name        : HyperV-NAT
Active      : True
InternalIPInterfaceAddressPrefix : 192.168.100.0/24
```

At this point, Windows knows that traffic from the `192.168.100.0/24` network should be translated through the host.

***

## 6. Configure the Virtual Machine

Open:

**Hyper-V Manager → VM → Settings → Network Adapter**

Select:

```
Internal-NAT
```

The VM is now connected to the private Hyper-V network.

You can configure the VM with a static IP.

For example:

```
IP Address:       192.168.100.10
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.100.1
DNS Server:       8.8.8.8
```

The second VM could use:

```
IP Address:       192.168.100.11
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.100.1
DNS Server:       8.8.8.8
```

Each VM should have a unique private IP address.

***

## 7. Test the Internal Network

From the VM, first test communication with the Hyper-V host:

```cmd
ping 192.168.100.1
```

If this works, test Internet connectivity:

```cmd
ping 8.8.8.8
```

Then test DNS:

```cmd
nslookup google.com
```

You can also test from PowerShell:

```powershell
Test-NetConnection 8.8.8.8
```

If the VM can reach `192.168.100.1` but cannot reach the Internet, investigate the host's NAT and physical Internet connection.

***

## 8. Configure RDP Port Forwarding

NAT provides outbound Internet connectivity, but it does not automatically make services inside the VM accessible from the Internet.

For example, suppose RDP is running on:

```
VM IP: 192.168.100.10
RDP: 3389
```

We can expose it through another port on the Hyper-V host.

For example:

```
Public IP: 13.10.10.10
External Port: 3390

VM:
192.168.100.10:3389
```

Create the NAT mapping:

```powershell
Add-NetNatStaticMapping `
    -NatName "HyperV-NAT" `
    -Protocol TCP `
    -ExternalIPAddress "0.0.0.0" `
    -ExternalPort 3390 `
    -InternalIPAddress "192.168.100.10" `
    -InternalPort 3389
```

Verify:

```powershell
Get-NetNatStaticMapping -NatName "HyperV-NAT"
```

The traffic flow will now be:

```
Internet
    |
    | 13.10.10.10:3390
    |
Hyper-V Host
    |
    | NAT
    |
192.168.100.10:3389
    |
Windows VM
```

From an external computer, the RDP connection can be made using:

```
103.181.108.232:3390
```

***

## 9. Port Forwarding for Multiple VMs

One of the biggest advantages of this configuration is that multiple VMs can share the same public IP.

For example:

| VM  | Private IP     | Service  | Public Port |
| --- | -------------- | -------- | ----------- |
| VM1 | 192.168.100.10 | RDP 3389 | 3390        |
| VM2 | 192.168.100.11 | RDP 3389 | 3391        |
| VM3 | 192.168.100.12 | RDP 3389 | 3392        |

The mappings would be:

```
13.10.10.10:3390 → 192.168.100.10:3389
13.10.10.10:3391 → 192.168.100.11:3389
13.10.10.10:3392 → 192.168.100.12:3389
```

The external port must be unique because all VMs are sharing the same public IP.

***

## 10. SQL Server Port Forwarding

The same concept can be used for SQL Server.

Suppose SQL Server is listening on:

```
192.168.100.10:1433
```

You could create:

```
13.10.10.10:14331
        ↓
192.168.100.10:1433
```

PowerShell:

```powershell
Add-NetNatStaticMapping `
    -NatName "HyperV-NAT" `
    -Protocol TCP `
    -ExternalIPAddress "0.0.0.0" `
    -ExternalPort 14331 `
    -InternalIPAddress "192.168.100.10" `
    -InternalPort 1433
```

However, SQL Server should not normally be exposed directly to the public Internet unless there is a specific requirement and appropriate security controls.

***

## 11. Verify RDP Connectivity

Before testing the public IP, always verify that RDP works from the host to the VM.

From the Hyper-V host:

```powershell
Test-NetConnection 192.168.100.10 -Port 3389
```

The expected result is:

```
TcpTestSucceeded : True
```

If this returns `False`, troubleshoot the VM first.

Check whether RDP is listening:

```powershell
Get-NetTCPConnection -LocalPort 3389 -State Listen
```

Check the Remote Desktop service:

```powershell
Get-Service TermService
```

And make sure Windows Firewall allows RDP:

```powershell
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
```

***

## 12. Troubleshooting 169.254.x.x Addresses

One common problem when configuring Hyper-V networking is seeing an address such as:

```
169.254.x.x
```

This is an **APIPA address**.

It generally indicates that the system did not receive an IP address through DHCP.

With the static NAT configuration described in this article, the VM can instead be manually configured with:

```
IP:      192.168.100.10
Mask:    255.255.255.0
Gateway: 192.168.100.1
DNS:     8.8.8.8
```

***

## 13. Security Considerations

Port forwarding makes internal services reachable from outside, so it should be implemented carefully.

Recommended practices include:

* Do not expose RDP unnecessarily.
* Restrict inbound access to trusted public IP addresses where possible.
* Enable Network Level Authentication (NLA).
* Use strong passwords and account lockout policies.
* Keep Windows Server patched.
* Avoid exposing SQL Server directly to the Internet unless required.
* Use VPN or another secure remote-access solution for administrative access where possible.
* Configure Windows Firewall alongside NAT rules.
* Monitor exposed services and authentication attempts.

Changing RDP from port `3389` to another external port can reduce automated scanning noise, but **it is not a security control by itself**.

***

## 14. Internal NAT vs External Hyper-V Switch

Both configurations have their use cases.

#### Internal + NAT

```
VM → Private Network → Hyper-V Host → NAT → Internet
```

Best when:

* You have one public IP.
* VMs don't need individual public IPs.
* You want a private VM network.
* You need controlled port forwarding.

#### External Switch

```
VM → External vSwitch → Physical NIC → Network
```

Best when:

* VMs need to appear directly on the physical LAN.
* VMs have their own routable/static IP addresses.
* You have multiple public IPs or a properly configured upstream network.
* You want the VMs to behave like physical machines on the network.

***

## 15. Final Configuration

A simple Hyper-V NAT environment can therefore look like:

```
                     INTERNET
                         |
                         |
                13.10.10.10
                         |
                +----------------+
                |  Hyper-V Host  |
                |                |
                |  NAT Gateway   |
                | 192.168.100.1  |
                +-------+--------+
                        |
                 Internal-NAT
                        |
          +-------------+-------------+
          |                           |
       VM1                         VM2
192.168.100.10               192.168.100.11
          |                           |
       RDP 3389                    RDP 3389
```

Port forwarding:

```
13.10.10.10:3390
        ↓
13.10.10.10:3389

13.10.10.10:3391
        ↓
192.168.100.11:3389
```

***

## Conclusion

Using an **Internal Hyper-V switch with Windows NAT** is a practical solution for providing Internet connectivity to multiple virtual machines while keeping those VMs on a private network.

The combination of **private IP addressing, NAT, and selective port forwarding** allows a single public IP to support multiple virtual machines and services.

For lab environments, development servers, testing environments, and smaller infrastructures, this approach provides a simple and flexible way to manage Hyper-V networking without requiring a separate public IP address for every VM.

For production environments, however, the network design should also consider firewall architecture, VPN access, routing, monitoring, redundancy, and the security implications of exposing services through port forwarding.
