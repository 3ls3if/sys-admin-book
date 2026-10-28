---
icon: network-wired
---

# Configure Windows Server Network Load Balancing (NLB)

## 1. Objective

This guide explains how to build, configure, test, and manage a two-node Windows Network Load Balancing (NLB) cluster for an IIS website. It follows a lab design with NLB01 and NLB02 and includes prerequisites, network design, DNS, port rules, affinity, failover, day-to-day operations, HTTPS, troubleshooting, and rolling-upgrade planning.

NLB presents a single virtual IP address (VIP) to clients and distributes eligible network traffic across multiple Windows hosts. It is suitable for services such as stateless IIS websites. NLB does not replicate website files, application data, or user sessions; those must be handled separately.

## 2. Lab topology and addressing

Use these example names and addresses consistently throughout the lab. Replace them with addresses appropriate to your environment.

| Component            | Purpose                           | Example address                |
| -------------------- | --------------------------------- | ------------------------------ |
| DC01                 | Active Directory and DNS          | Existing lab address           |
| NLB01 cluster NIC    | Client-facing NLB traffic         | 192.168.10.91/24               |
| NLB02 cluster NIC    | Client-facing NLB traffic         | 192.168.10.92/24               |
| NLB01 management NIC | Management and node communication | 192.168.50.91/24               |
| NLB02 management NIC | Management and node communication | 192.168.50.92/24               |
| NLB cluster VIP      | Client-facing virtual IP          | 192.168.10.90/24               |
| Cluster DNS name     | Website name                      | web.tastybiryani.local         |
| CLIENT01             | Client test machine               | Same client-accessible network |

Example Active Directory domain: `tastybiryani.local`.

### Important network notes

* The VIP must be unused and must not conflict with DHCP reservations or another host.
* Configure the default gateway on the appropriate client-facing NIC only. Do not configure a second default gateway on the management NIC.
* Both cluster NICs must be connected to the same appropriate Layer 2 network/VLAN for this example.
* If using Unicast mode, Microsoft NLB assigns a shared virtual MAC address to the cluster-facing adapters. This has network-switch and virtualization implications.
* In a VMware environment, review the relevant port-group security settings for the cluster-facing NICs, including MAC address changes and forged transmits. On Hyper-V or other platforms, verify the equivalent supported configuration. Do not enable broad network exceptions without understanding the security implications.
* In production, select Unicast, Multicast, or IGMP Multicast only after checking Microsoft guidance and the actual switch, router, hypervisor, and network design. IGMP Multicast is not universally the best option; it requires network equipment and configuration that support it.

## 3. Prerequisites

Before configuring NLB, confirm the following:

1. DC01 is operational and provides the intended Active Directory and DNS services.
2. NLB01 and NLB02 run a supported Windows Server version and are joined to the domain if domain membership is required for the lab.
3. Each node has its cluster-facing NIC and management NIC configured as planned.
4. Each node can communicate with the necessary domain, DNS, management, and peer services.
5. The VIP and dedicated IP addresses are unique.
6. The intended website works locally on each node before NLB is configured.
7. The required ports are allowed by Windows Firewall and any network firewall.
8. The virtualization or physical network supports the chosen NLB mode.
9. An administrative account is available to install Windows features and manage NLB.
10. A maintenance plan exists before testing failover or performing disruptive changes.

Record the current IP configuration before making changes:

```powershell
Get-NetIPConfiguration
ipconfig /all
```

Test that each node resolves the domain and can reach required infrastructure before proceeding.

## 4. Choose the NLB operation mode

Windows NLB offers Unicast, Multicast, and IGMP Multicast modes. The choice affects network behavior, not the basic client experience of connecting to a VIP.

### Unicast

* NLB uses a shared virtual MAC address on the cluster-facing NICs.
* In common configurations, traffic may need to be flooded to the cluster nodes by the switching infrastructure.
* A second NIC is commonly used to separate management and inter-node communication from cluster traffic.
* Virtualization and switch settings must support the resulting MAC behavior.

### Multicast

* NLB associates a multicast MAC address with the cluster.
* The network may require specific ARP, routing, or switch configuration.
* Multicast does not automatically eliminate all unwanted traffic flooding.

### IGMP Multicast

* NLB uses IGMP to help supported switches manage multicast membership and limit traffic to interested ports.
* Network switches and other network devices must support and be correctly configured for IGMP snooping and multicast forwarding.

For this lab, the steps below use **Unicast**, as in the tutorial. Do not copy the mode into production without validating your network design.

## 5. Install IIS and NLB on both nodes

Repeat these steps on NLB01 and NLB02.

### Step 1: Open Add Roles and Features

1. Sign in to the server with an account that has local administrative rights.
2. Open **Server Manager**.
3. Select **Manage → Add Roles and Features**.
4. Click **Next** on the Before You Begin page.

### Step 2: Select the installation type and destination

1. Select **Role-based or feature-based installation**.
2. Click **Next**.
3. Select **Select a server from the server pool**.
4. Choose NLB01 for the first installation, then click **Next**.

### Step 3: Install the IIS role

1. On the Server Roles page, select **Web Server (IIS)**.
2. If prompted, select **Add Features** to include required management tools.
3. Click **Next**.

### Step 4: Install the NLB feature

1. On the Features page, select **Network Load Balancing**.
2. If prompted, click **Add Features**.
3. Click **Next**.
4. Review the IIS role and role services selections. The default IIS role services are sufficient for the simple static-page demonstration.
5. Click **Next**, review the selections, and click **Install**.
6. Wait for installation to finish and click **Close**.

Repeat Steps 1–4 on NLB02, making sure NLB02 is selected as the destination server.

Verify installation on each node in PowerShell:

```powershell
Get-WindowsFeature NLB, Web-Server
```

Confirm the relevant features show as installed. A restart is not normally required for these feature selections, but follow any prompt or maintenance guidance shown by your Windows Server build.

## 6. Configure and test IIS on each node

### Step 5: Verify the default IIS site

On each node:

1. Open Microsoft Edge.
2. Browse to `http://localhost`.
3. Confirm the IIS page appears.

If the page does not load, resolve the IIS issue before proceeding. Check that the World Wide Web Publishing Service is running, the Default Web Site is started, and local firewall rules permit the intended traffic.

### Step 6: Customize the page to identify the node

The tutorial uses a simple HTML page that displays the responding server's hostname. This makes testing easier.

1. Open **Server Manager → Tools → Internet Information Services (IIS) Manager**.
2. Expand the server node and then **Sites**.
3. Right-click **Default Web Site** and select **Explore**.
4. Locate `iisstart.htm` or the default page file actually used by your IIS installation.
5. Back up the original file.
6. Edit the page with an appropriate text editor and use a simple test page such as the following, replacing the node name for each server.

Example for NLB01:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>IIS Web Server</title>
</head>
<body>
  <h1>Welcome to this IIS web server</h1>
  <p>This page is hosted on NLB01.</p>
</body>
</html>
```

For NLB02, change the paragraph to `This page is hosted on NLB02.`

7. Save the file.
8. Restart the Default Web Site from IIS Manager if necessary.
9. Browse to `http://localhost` on each server and confirm that the correct hostname is displayed.

If your default document or physical path differs, ensure the edited file is actually the document returned by the website. Do not replace a production site's content with this lab page.

## 7. Create the cluster DNS record

### Step 7: Create the cluster A record

On the DNS server:

1. Open **Server Manager → Tools → DNS**.
2. Expand the forward lookup zone for `tastybiryani.local`.
3. Right-click the zone and select **New Host (A or AAAA)**.
4. Enter `web` as the name.
5. Enter `192.168.10.90` as the IP address.
6. Create the record.

The fully qualified name will be `web.tastybiryani.local`.

### Step 8: Configure reverse DNS if required

If the reverse lookup zone for the relevant subnet exists and your environment requires reverse DNS:

1. Open the reverse lookup zone for the subnet.
2. Create or verify a PTR record for `192.168.10.90`.
3. Ensure it points to `web.tastybiryani.local`.

A PTR record is not required for ordinary browser access to the website, but it may be useful for troubleshooting and applications that rely on reverse lookups.

Verify DNS from CLIENT01:

```powershell
Resolve-DnsName web.tastybiryani.local
```

The A record should return `192.168.10.90`.

## 8. Create the NLB cluster

### Step 9: Open NLB Manager

1. Sign in to NLB01 with administrative rights.
2. Open **Server Manager → Tools → Network Load Balancing Manager**.
3. In NLB Manager, select **Cluster → New**.

### Step 10: Connect to NLB01

1. Enter `NLB01` in the Host field.
2. Click **Connect**.
3. Wait for the available network interfaces to appear.
4. Select the interface assigned to cluster traffic, expected to use `192.168.10.91`.
5. Click **Next**.

Do not select the management NIC for the client-facing cluster interface.

### Step 11: Configure NLB01 host parameters

Set the following:

* **Priority (Unique host identifier):** 1
* **Dedicated IP address:** `192.168.10.91`
* **Initial host state:** Started

The dedicated IP belongs to the individual node. It is different from the shared cluster VIP. Each node must have a unique priority and dedicated IP.

Click **Next**.

### Step 12: Add the cluster VIP

1. On the Cluster IP Addresses page, click **Add**.
2. Select IPv4.
3. Enter `192.168.10.90`.
4. Enter subnet mask `255.255.255.0`.
5. Click **OK**, then **Next**.

The VIP is the address clients use to reach the cluster. Confirm it is unused before adding it. Do not assign it manually as a normal static address to an individual Windows NIC; configure it through NLB.

### Step 13: Set the cluster DNS name and operation mode

1. Enter the full cluster name `web.tastybiryani.local`.
2. Select **Unicast** for this lab.
3. Click **Next**.

The cluster DNS name must resolve to the VIP. The DNS record created earlier provides that mapping.

### Step 14: Configure the HTTP port rule

On the Port Rules page, select the default rule and click **Edit**.

Configure the rule as follows:

| Setting            | Value         |
| ------------------ | ------------- |
| Cluster IP address | 192.168.10.90 |
| Start port         | 80            |
| End port           | 80            |
| Protocol           | TCP           |
| Filtering mode     | Multiple host |
| Affinity           | None          |

If the Cluster IP field has **All** selected, clear it and select only `192.168.10.90` for this rule.

Only configure ports required by the application. The tutorial uses HTTP on TCP 80. For HTTPS, create a separate TCP 443 rule after configuring and testing HTTPS on both IIS nodes.

### Step 15: Understand filtering modes

* **Multiple host:** Multiple cluster nodes can handle traffic matching the rule. This is the normal choice for active-active load balancing.
* **Single host:** Only one node handles traffic for that rule according to host priority. This is not active-active distribution for that port rule.
* **Disabled:** Traffic matching that port rule is discarded.

### Step 16: Choose client affinity

* **None:** NLB does not attempt to direct connections from the same client to the same node. Suitable for stateless services or applications that share session state.
* **Single:** Connections from the same source IP address are directed to the same node. This can help applications with local session state but can lead to uneven distribution when many users share a NAT address.
* **Network:** Client affinity is based on the client's subnet. This can group many clients onto one node and should be chosen only when the application and traffic pattern justify it.

For this static IIS demonstration, select **None**. Affinity is not a replacement for shared or replicated application session storage.

Click **OK**, review the rule, and click **Finish** to create the cluster with NLB01.

### Step 17: Wait for the initial cluster to converge

Wait for NLB Manager to show NLB01 as started and operational. A green status is useful, but still verify that the VIP and website are reachable from a client.

## 9. Add NLB02 to the cluster

### Step 18: Start Add Host to Cluster

1. In NLB Manager, right-click `web.tastybiryani.local`.
2. Select **Add Host to Cluster**.
3. Enter \`NLB02).
4. Click **Connect**.
5. Select NLB02's cluster-facing interface, expected to use `192.168.10.92`.
6. Click **Next**.

### Step 19: Configure NLB02 host parameters

Set:

* **Priority (Unique host identifier):** 2
* **Dedicated IP address:** `192.168.10.92`
* **Initial host state:** Started

The priority must be unique within the cluster. Click **Next**.

### Step 20: Confirm the port rules and finish

1. Confirm that NLB02 receives the same TCP port 80 rule as NLB01.
2. Click **Finish**.
3. Wait for NLB02 to join and for cluster convergence to complete.
4. Confirm both nodes are started and operational in NLB Manager.

If a node remains pending or fails to converge, check its selected NIC, IP configuration, priority, port rules, firewall, network mode, and virtualization/switch settings.

## 10. Test the cluster

### Step 21: Test the VIP on TCP 80

From CLIENT01, run:

```powershell
Test-NetConnection 192.168.10.90 -Port 80
```

Confirm that `TcpTestSucceeded` is `True`. Then browse to:

```
http://192.168.10.90
```

If the VIP fails, test each dedicated node IP:

```powershell
Test-NetConnection 192.168.10.91 -Port 80
Test-NetConnection 192.168.10.92 -Port 80
```

This helps distinguish an individual IIS or firewall problem from an NLB VIP problem.

### Step 22: Test DNS access

From CLIENT01:

```powershell
Resolve-DnsName web.tastybiryani.local
Test-NetConnection web.tastybiryani.local -Port 80
```

Confirm the name resolves to `192.168.10.90`, then browse to `http://web.tastybiryani.local`.

### Step 23: Identify the responding node

Refresh the page and check whether it displays NLB01 or NLB02. For a repeatable test, run:

```powershell
1..20 | ForEach-Object {
    try {
        $response = Invoke-WebRequest -Uri "http://web.tastybiryani.local/" -UseBasicParsing -TimeoutSec 5
        $node = if ($response.Content -match "NLB01") {
            "NLB01"
        } elseif ($response.Content -match "NLB02") {
            "NLB02"
        } else {
            "Unknown"
        }

        [PSCustomObject]@{
            Request = $_
            Status  = $response.StatusCode
            Node    = $node
        }
    }
    catch {
        [PSCustomObject]@{
            Request = $_
            Status  = "Failed"
            Node    = $_.Exception.Message
        }
    }

    Start-Sleep -Milliseconds 300
}
```

This sends 20 requests and reports the hostname in each response. The test may not necessarily hit both nodes because NLB distribution depends on connection characteristics, affinity, workload, and network configuration. Seeing one node during a short test does not by itself prove that NLB is broken.

### Step 24: Test failover

Perform this only in a lab or an approved maintenance window.

1. Open NLB Manager.
2. Right-click NLB01.
3. Select **Control Host → Stop**.
4. Wait for NLB01 to show stopped and for the cluster to reconverge.
5. From CLIENT01, refresh `http://web.tastybiryani.local`.
6. Confirm that NLB02 serves the page.
7. Start NLB01 again using **Control Host → Start**.
8. Wait for it to converge and verify the website again.

A successful test demonstrates that NLB can direct eligible traffic to the surviving node. It does not prove that application data or sessions are replicated.

## 11. Manage NLB nodes

In NLB Manager, right-click a node and use **Control Host** to access these operations.

### Start

Starts NLB participation for a stopped node. Use it when returning a node to service, then wait for convergence.

### Stop

Stops the node from participating in NLB. Existing connections may be interrupted. Use it for immediate removal or controlled lab tests.

### Suspend

Temporarily suspends the node's NLB participation. Use it for an operational pause, then verify the state and remaining service capacity.

### Resume

Resumes a suspended node. Wait for it to become operational and confirm the cluster state.

### Drainstop

Requests that existing connections be allowed to finish while the node stops accepting new connections through the applicable NLB port rules. Use it for planned maintenance where possible. It does not guarantee that every application-level session will complete successfully, especially for long-lived connections.

After any operation, verify the node status, cluster convergence, and application availability.

## 12. Configure HTTPS (optional)

The tutorial demonstrates HTTP. For a production website, HTTPS is normally recommended.

### Step 25: Configure HTTPS on both IIS nodes

1. Obtain a certificate valid for the website's real DNS name.
2. Install the certificate, including its private key, on both NLB01 and NLB02.
3. Open IIS Manager on each node.
4. Select the website and open **Bindings**.
5. Add an HTTPS binding on TCP port 443.
6. Select the correct certificate and host name if using SNI.
7. Test HTTPS directly against each node and verify the certificate.

### Step 26: Add the HTTPS NLB port rule

1. Open the cluster's port rules in NLB Manager.
2. Add a rule for cluster VIP `192.168.10.90`.
3. Set start and end ports to `443`.
4. Select TCP, Multiple host, and the affinity appropriate for the application.
5. Save the rule and confirm both nodes use the same configuration.
6. Test the actual DNS name using `https://your-real-domain.example`.

Replace the example domain with the real DNS name. NLB does not install certificates, configure IIS bindings, renew certificates, or replicate website content.

## 13. Troubleshooting

| Symptom                            | Checks                                                                                                                              |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| VIP does not respond               | Confirm the VIP is unique, nodes are started and converged, the port rule is correct, and switch/hypervisor forwarding is supported |
| DNS name fails                     | Verify the A record, client DNS settings, DNS reachability, and cached results                                                      |
| One node appears repeatedly        | Check affinity, request pattern, node health, and whether the test varies connection tuples sufficiently                            |
| NLB02 cannot join                  | Check selected NIC, unique priority, dedicated IP, feature installation, inter-node communication, and network mode                 |
| Dedicated IP works but VIP fails   | Investigate NLB mode, virtual MAC/ARP behavior, switch forwarding, virtualization security settings, VLANs, and firewall rules      |
| IIS page fails on one node         | Check the website state, binding, physical path, file permissions, application pool, and IIS logs                                   |
| HTTP works but HTTPS fails         | Check the TCP 443 rule, certificate, IIS binding, SNI/hostname, and firewall rules                                                  |
| Failover causes application errors | Check surviving-node capacity, application dependencies, shared data, session state, and convergence                                |

Useful checks:

```powershell
Get-NetIPConfiguration
Get-WindowsFeature NLB, Web-Server
Resolve-DnsName web.tastybiryani.local
Test-NetConnection 192.168.10.90 -Port 80
Invoke-WebRequest http://localhost -UseBasicParsing
```

Use NLB Manager alongside Windows event logs, IIS logs, Windows Firewall settings, and hypervisor or network-switch logs. Do not leave broad “allow all traffic” firewall rules in place as a permanent workaround.

## 14. Rolling-upgrade planning

A rolling upgrade upgrades one node at a time while the other node continues serving traffic. Availability is not guaranteed unless the remaining node and all application dependencies can handle the load.

### Step 27: Prepare

* Confirm the surviving node can handle the expected workload.
* Back up the operating system, application files, configuration, and required data.
* Verify application and OS compatibility.
* Document network settings, dedicated IPs, cluster VIP, host priorities, DNS, port rules, certificates, and recovery steps.
* Define a maintenance window and rollback plan.

### Step 28: Upgrade NLB01

1. Use Drainstop on NLB01 and wait for active connections to finish where possible.
2. Verify NLB02 is healthy and serving the application.
3. Stop NLB01 if required by the maintenance process.
4. Perform the supported Windows Server upgrade.
5. Reboot if required.
6. Verify network adapters, IP settings, domain connectivity, IIS, certificates, application dependencies, and NLB feature installation.
7. Rejoin or reconfigure the node in NLB Manager if needed.
8. Confirm its unique priority, dedicated IP, and port rules.
9. Start the node and wait for convergence.
10. Test the VIP and website before proceeding.

Do not assume all NLB settings will survive an operating system upgrade unchanged.

### Step 29: Upgrade NLB02

Only after NLB01 is verified healthy:

1. Drainstop NLB02.
2. Confirm NLB01 is healthy and serving traffic.
3. Upgrade NLB02 using the supported procedure.
4. Verify networking, IIS, certificates, application dependencies, and NLB installation.
5. Rejoin or reconfigure NLB02 if needed.
6. Restore its unique host priority and dedicated IP.
7. Confirm the port rules and wait for convergence.
8. Test the VIP and website with both nodes operational.

The rolling upgrade is complete only after both nodes are upgraded, healthy, and verified.

## 15. Production recommendations

* Choose the NLB network mode based on verified support from the network and virtualization infrastructure.
* Keep IIS content and application configuration consistent on both nodes.
* Use shared or replicated application data where required; NLB does not synchronize files or databases.
* Design session handling explicitly. Affinity alone is not session replication.
* Permit only required client-facing ports and restrict management access.
* Monitor the application and its dependencies; NLB node status is not a complete application health check.
* Use HTTPS, security updates, least-privilege administration, backups, and a documented recovery process.
* Consider an application delivery controller or other load-balancing solution if you require advanced health probes, application-aware routing, WAF integration, or more sophisticated session handling.

## 16. Completion checklist

* [ ] DC01 and DNS are operational.
* [ ] NLB01 and NLB02 are prepared and have the intended NICs and IP settings.
* [ ] NLB and IIS features are installed on both nodes.
* [ ] The test page identifies each node correctly.
* [ ] The cluster DNS A record points to `192.168.10.90`.
* [ ] The cluster is created in the intended NLB mode.
* [ ] The TCP 80 Multiple host rule is configured for the VIP.
* [ ] NLB02 is added with a unique host priority.
* [ ] Both nodes are started and converged.
* [ ] The VIP and DNS name are reachable from CLIENT01.
* [ ] Failover to NLB02 is tested and NLB01 is restored.
* [ ] HTTPS, if required, is configured and tested on both nodes.
* [ ] Maintenance, troubleshooting, backup, and rollback procedures are documented.

## Expected result

Clients access the IIS website through `http://web.tastybiryani.local`, which resolves to the NLB cluster VIP `192.168.10.90`. NLB01 and NLB02 are both members of the cluster and can handle eligible TCP port 80 traffic. When one node is stopped, the remaining healthy node should continue serving requests after the cluster and network have converged, provided the application and its dependencies remain available.
