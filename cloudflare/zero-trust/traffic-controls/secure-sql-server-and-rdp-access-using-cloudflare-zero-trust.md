---
icon: windows
---

# Secure SQL Server and RDP Access Using Cloudflare Zero Trust

## Secure SQL Server and RDP Access Using Cloudflare Zero Trust

### Private Network Access, IP Whitelisting and Remote Database Connectivity on Windows Server 2022

**Project:** Cloudflare Zero Trust – Secure Database and Remote Administration\
**Operating System:** Windows Server 2022\
**Database:** Microsoft SQL Server Express Edition\
**Connectivity:** Windows and Linux external application servers\
**Security Platform:** Cloudflare Zero Trust\
**Tunnel Technology:** Cloudflare Tunnel (`cloudflared`)\
**Client Technology:** Cloudflare One Client (WARP)

***

## 1. Project Overview

### 1.1 Background

The client has deployed Microsoft SQL Server Express Edition on a Windows Server 2022 machine.

The client requires secure remote database connectivity for authorized external application servers. They also require Remote Desktop Protocol (RDP) access to be restricted to specific whitelisted public IP addresses.

The original requirement was to configure firewall rules and SQL Server network settings to allow remote connectivity only from approved IP addresses.

However, the client does not want to purchase an additional firewall subscription.

To address this requirement, we propose implementing Cloudflare Zero Trust as a secure private network access solution.

Cloudflare Zero Trust will provide an additional security layer between external application servers, administrators and the database server.

Instead of exposing SQL Server and RDP directly to the internet, we will use Cloudflare Tunnel and Cloudflare One Client to establish private connectivity.

### 1.2 Project Objectives

The primary objectives are:

1. Restrict SQL Server access to authorized external application servers.
2. Allow both Windows and Linux servers to connect to the database securely.
3. Restrict RDP access to authorized administrator IP addresses and identities.
4. Eliminate direct public exposure of SQL Server TCP 1433.
5. Eliminate direct public exposure of RDP TCP 3389.
6. Implement IP-based and identity-based access policies.
7. Use Cloudflare Tunnel for secure connectivity without inbound port forwarding.
8. Retain Windows Defender Firewall as an additional security layer.
9. Avoid purchasing an additional traditional firewall subscription, subject to Cloudflare plan eligibility.

### 1.3 Proposed Solution

The proposed solution consists of:

| Component                                  | Purpose                                                  |
| ------------------------------------------ | -------------------------------------------------------- |
| Windows Server 2022                        | Hosts SQL Server Express and RDP                         |
| SQL Server Express                         | Database service                                         |
| Cloudflare Tunnel                          | Connects the private server network to Cloudflare        |
| Cloudflare One Client (WARP)               | Establishes secure connectivity from external servers    |
| Cloudflare Gateway                         | Enforces network access policies                         |
| Cloudflare Access                          | Provides identity-based access controls where applicable |
| Windows Defender Firewall                  | Provides host-level firewall protection                  |
| Microsoft SQL Server Configuration Manager | Configures SQL Server network protocols                  |

***

## 2. Understanding the Existing and Proposed Architecture

### 2.1 Existing Architecture

In the conventional architecture, external application servers connect directly to the database server using its public IP address.

**Existing connectivity:**

```
       External Windows Server
                 |
                 |
       External Linux Server
                 |
                 |
          Public Internet
                 |
                 |
        Public IP Address
                 |
                 |
       Windows Server 2022
                 |
          ---------------
          |             |
      SQL Server       RDP
       TCP 1433      TCP 3389
```

#### Security concerns

* SQL Server may become directly accessible over the internet.
* RDP may be exposed to brute-force attacks.
* Public IP allowlisting must be maintained through firewall rules.
* Additional firewall functionality may require a paid subscription.
* There is no centralized identity-based access management unless separately implemented.

### 2.2 Proposed Cloudflare Zero Trust Architecture

We will replace direct public connectivity with private network routing through Cloudflare.

```
                 EXTERNAL NETWORK
                         |
           +-------------+-------------+
           |                           |
     Windows Server               Linux Server
       WARP Client                 WARP Client
           |                           |
           +-------------+-------------+
                         |
                         |
                CLOUDFLARE NETWORK
                         |
                 Cloudflare Gateway
                         |
                Network Access Policies
                         |
                  Cloudflare Tunnel
                         |
                  cloudflared Service
                         |
                  PRIVATE NETWORK
                         |
                Windows Server 2022
                         |
               ---------------------
               |                   |
          SQL Server Express       RDP
             TCP 1433           TCP 3389
```

#### How the architecture works

1. The database server establishes an outbound connection to Cloudflare using `cloudflared`.
2. Cloudflare registers the tunnel within the Zero Trust organization.
3. A private network route makes the database server's private IP reachable through the tunnel.
4. External Windows and Linux servers install the Cloudflare One Client.
5. Authorized devices authenticate and connect to Cloudflare.
6. Gateway network policies evaluate the requested destination, port, source IP and available identity/device information.
7. Authorized connections are forwarded through the tunnel to the private database server.
8. Unauthorized connections are blocked.

**Important:** Cloudflare Tunnel is outbound-only. It does not require inbound NAT or public port forwarding for the private services. For non-HTTP protocols, the origin sees the connector's local source IP rather than the original client IP. The original source IP must therefore be controlled and audited at the Cloudflare layer.

***

## 3. Project Requirements

Before implementation, collect the following information.

### 3.1 Hardware and Software Requirements

| Component                 | Requirement                                                 |
| ------------------------- | ----------------------------------------------------------- |
| Database server           | Windows Server 2022                                         |
| Database engine           | SQL Server Express                                          |
| Database network protocol | TCP/IP                                                      |
| SQL port                  | TCP 1433                                                    |
| RDP port                  | TCP 3389                                                    |
| Tunnel connector          | cloudflared                                                 |
| External Windows servers  | Cloudflare One Client                                       |
| External Linux servers    | Cloudflare One Client                                       |
| Cloudflare account        | Active Zero Trust organization                              |
| Domain                    | Cloudflare-managed domain (optional for private IP routing) |
| Server addressing         | Static private IP                                           |
| Internet access           | Required on tunnel connector and external clients           |

### 3.2 Network Requirements

The following example addressing scheme will be used throughout this article.

Replace these addresses with the actual production addresses.

| Device                     | Example IP        | Requirement          |
| -------------------------- | ----------------- | -------------------- |
| Database server            | 192.168.1.10      | Static private IP    |
| Cloudflare connector       | 192.168.1.20      | Optional separate VM |
| Windows application server | 203.0.113.10      | Authorized public IP |
| Linux application server   | 203.0.113.20      | Authorized public IP |
| Administrator workstation  | 203.0.113.30      | Authorized public IP |
| SQL Server                 | 192.168.1.10:1433 | Private access       |
| RDP                        | 192.168.1.10:3389 | Private access       |

The public IPs above are documentation examples, not actual client addresses.

### 3.3 Firewall and Connectivity Requirements

| Port     | Direction       | Purpose                                         |
| -------- | --------------- | ----------------------------------------------- |
| TCP 7844 | Outbound        | Cloudflare Tunnel connectivity                  |
| UDP 7844 | Outbound        | Cloudflare Tunnel connectivity                  |
| TCP 443  | Outbound        | Cloudflare services, authentication and updates |
| TCP 1433 | Private network | SQL Server connectivity                         |
| TCP 3389 | Private network | RDP connectivity                                |

The tunnel connector uses TCP or UDP 7844 depending on the selected tunnel transport. Allow the required outbound connectivity and avoid opening these ports inbound.

### 3.4 Cloudflare Account Requirements

* Active Cloudflare account.
* Cloudflare Zero Trust organization.
* Access to Cloudflare Tunnels.
* Access to private network routes.
* Cloudflare One Client enrollment permissions.
* Gateway network policies and TCP proxy functionality.
* Access to service credentials for headless Linux enrollment.

Before deployment, verify the current plan's feature availability, device limits, support requirements and pricing.

***

## 4. Phase One – Prepare Windows Server 2022

### Step 1: Identify the Server's Private IP Address

Log in to Windows Server 2022.

Open PowerShell as Administrator.

Execute:

```
ipconfig /all
```

Identify the active network adapter and its private IP address.

Example:

```
IPv4 Address:       192.168.1.10
Subnet Mask:        255.255.255.0
Default Gateway:    192.168.1.1
```

Make sure the server uses a static IP address or DHCP reservation.

### Step 2: Verify SQL Server Express Installation

Open SQL Server Configuration Manager.

Navigate to:

```
SQL Server Services
```

Verify that the SQL Server Express instance is running.

For example:

```
SQL Server (SQLEXPRESS)
Status: Running
```

Alternatively, execute:

```
Get-Service -Name 'MSSQL$SQLEXPRESS'
```

### Step 3: Enable TCP/IP

Open:

```
SQL Server Configuration Manager
```

Navigate to:

```
SQL Server Network Configuration
    |
    +-- Protocols for SQLEXPRESS
```

Right-click TCP/IP.

Select:

```
Enable
```

Open TCP/IP Properties.

Navigate to the IP Addresses tab.

Under IPAll, configure:

| Setting           | Value |
| ----------------- | ----- |
| TCP Dynamic Ports | Blank |
| TCP Port          | 1433  |

If Listen All is disabled, configure the active server IP entry instead.

Click Apply.

### Step 4: Restart SQL Server

Open SQL Server Services.

Right-click:

```
SQL Server (SQLEXPRESS)
```

Select Restart.

Alternatively:

```
Restart-Service -Name 'MSSQL$SQLEXPRESS'
```

### Step 5: Verify SQL Server Listening Port

Execute:

```
Get-NetTCPConnection -LocalPort 1433 -State Listen
```

Expected result:

```
LocalPort   State
---------   -----
1433        Listen
```

If there is no listening endpoint, investigate the SQL Server configuration and service logs before proceeding.

### Step 6: Configure SQL Server Authentication

Open SQL Server Management Studio.

Right-click the SQL Server instance.

Navigate to:

```
Properties
    |
    +-- Security
```

Select the appropriate authentication mode.

For applications requiring SQL authentication, configure:

```
SQL Server and Windows Authentication Mode
```

Restart SQL Server if the authentication mode is changed.

Create a dedicated SQL login for the application.

Grant only the database permissions required by that application.

Do not use the SQL Server `sa` account for application connectivity.

### Step 7: Configure SQL Encryption

Configure SQL Server TLS encryption using a certificate trusted by the external application servers.

Verify:

* Certificate subject matches the SQL server name used by clients.
* Certificate is within its validity period.
* Certificate private key is available to SQL Server.
* Client machines trust the issuing certificate authority.
* Encryption is enabled and successfully tested.

***

## 5. Phase Two – Create Cloudflare Zero Trust Tunnel

### Step 8: Open Cloudflare Zero Trust

Open:

[https://one.dash.cloudflare.com/](https://one.dash.cloudflare.com/)

Log in using the Cloudflare administrator account.

Navigate to:

```
Networks
    |
    +-- Tunnels
```

Depending on the dashboard version, the tunnel section may appear under Networking.

### Step 9: Create a Cloudflare Tunnel

Select:

```
Create Tunnel
```

Choose:

```
Cloudflared
```

Enter the tunnel name:

```
SQL-RDP-PRIVATE-TUNNEL
```

Save the tunnel.

Select Windows as the connector operating system.

Cloudflare will provide an installation command containing the tunnel token.

### Step 10: Install Cloudflared

Open PowerShell as Administrator on the connector machine.

Execute the installation command generated by Cloudflare.

Do not share the tunnel token with unauthorized personnel.

Verify the service:

```
Get-Service cloudflared
```

Check that the connector appears as Healthy in the Cloudflare dashboard.

#### Recommended connector placement

For a small deployment, `cloudflared` can run directly on the Windows database server.

For a more isolated production design, use a separate connector VM on the same private LAN.

Example:

```
Database Server: 192.168.1.10
Connector VM:    192.168.1.20
```

The separate connector approach makes it easier to restrict database and RDP inbound rules to the connector's private IP.

***

## 6. Phase Three – Configure Private Network Routing

### Step 11: Create a Private Network Route

Open Cloudflare Zero Trust.

Navigate to:

```
Networking
    |
    +-- Routes
```

Select:

```
Create Route
    |
    +-- Tunnel CIDR
```

Select:

```
SQL-RDP-PRIVATE-TUNNEL
```

Enter:

```
192.168.1.10/32
```

Save the route.

The `/32` CIDR exposes one private IP address rather than the complete subnet.

Example:

```
Cloudflare Network
        |
        |
        +---- Tunnel
                 |
                 |
          192.168.1.10/32
                 |
                 |
          Windows Server 2022
                 |
           --------------
           |            |
         SQL           RDP
        1433           3389
```

### Step 12: Configure WARP Split Tunneling

Cloudflare One Client excludes RFC 1918 private network addresses by default in its standard Exclude split-tunnel configuration.

We need to make sure the database server IP is included in the traffic routed through WARP.

Navigate to:

```
Settings
    |
    +-- WARP Client
            |
            +-- Device Settings
                    |
                    +-- Split Tunnels
```

Review the existing configuration.

If using Include mode, add:

```
192.168.1.10/32
```

If using Exclude mode, remove or narrow any exclusion that covers the database server IP.

Preserve other exclusions required by the client's existing network.

Save the configuration.

### Step 13: Enable Gateway TCP Proxy

Navigate to:

```
Traffic Controls
    |
    +-- Traffic Settings
```

Under Proxy and Inspection, enable:

```
Allow Secure Web Gateway to proxy traffic
```

Enable:

```
TCP
```

UDP and ICMP can remain disabled if not required by the project.

This is necessary for Gateway to inspect the private TCP connections.

***

## 7. Phase Four – Configure Windows External Servers

### Step 14: Install Cloudflare One Client

On each authorized Windows application server:

Download the client:

[https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/download/](https://developers.cloudflare.com/cloudflare-one/team-and-resources/devices/cloudflare-one-client/download/)

Install the application.

Open Cloudflare One Client.

Select the Zero Trust organization.

Enter the Cloudflare team name.

Authenticate using an authorized identity.

Verify that the status is:

```
Connected
```

Ensure that the device is visible in:

```
Zero Trust
    |
    +-- Team & Resources
            |
            +-- Devices
```

### Step 15: Verify Windows Application Server Connectivity

Open PowerShell on the authorized Windows server.

Execute:

```
Test-NetConnection 192.168.1.10 -Port 1433
```

Expected:

```
TcpTestSucceeded : True
```

If unsuccessful, verify:

* WARP status.
* Private route configuration.
* Split tunneling.
* Gateway TCP proxy.
* Network policy.
* Tunnel health.
* SQL Server listening status.

Do not proceed to production database migration until connectivity is verified.

***

## 8. Phase Five – Configure Linux External Servers

### Step 16: Create a Cloudflare Service Token

Headless Linux servers may not have a graphical browser available for interactive enrollment.

We can use Cloudflare service tokens for automated enrollment.

Navigate to:

```
Zero Trust
    |
    +-- Access Controls
            |
            +-- Service Credentials
                    |
                    +-- Service Tokens
```

Create a service token.

Example:

```
LINUX-APP-SERVER-01
```

Set an appropriate expiration period.

Save the generated:

* Client ID
* Client Secret

Store both securely.

For production, create separate tokens for individual servers where practical.

### Step 17: Configure Device Enrollment Permissions

Navigate to:

```
Team & Resources
    |
    +-- Devices
            |
            +-- Management
                    |
                    +-- Device Enrollment Permissions
```

Create an enrollment policy.

Configure:

```
Action: Service Auth
Selector: Service Token
Value: LINUX-APP-SERVER-01
```

Attach the policy to device enrollment permissions.

Save.

### Step 18: Install Cloudflare WARP on Ubuntu

The following example uses Ubuntu 24.04.

Install the Cloudflare package repository:

```
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg \
| sudo gpg --yes --dearmor \
--output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
```

Add the repository:

```
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
| sudo tee /etc/apt/sources.list.d/cloudflare-client.list
```

Update packages:

```
sudo apt-get update
```

Install WARP:

```
sudo apt-get install -y cloudflare-warp
```

### Step 19: Configure Linux Device Enrollment

Create the configuration directory and file:

```
sudo install -m 600 /dev/null /var/lib/cloudflare-warp/mdm.xml
```

Insert the following configuration:

```
<dict>
    <key>auth_client_id</key>
    <string>YOUR_CLIENT_ID</string>

    <key>auth_client_secret</key>
    <string>YOUR_CLIENT_SECRET</string>

    <key>auto_connect</key>
    <integer>1</integer>

    <key>onboarding</key>
    <false/>

    <key>organization</key>
    <string>YOUR_TEAM_NAME</string>

    <key>service_mode</key>
    <string>warp</string>
</dict>
```

Replace the placeholders with the actual credentials and Cloudflare team name.

Protect the file:

```
sudo chmod 600 /var/lib/cloudflare-warp/mdm.xml
```

Restart WARP:

```
sudo systemctl restart warp-svc
```

Verify enrollment:

```
sudo warp-cli --accept-tos registration show
```

Verify connection:

```
sudo warp-cli --accept-tos status
```

Expected:

```
Connected
```

The device should now appear in Cloudflare Zero Trust.

**Security note:** Service-token-enrolled Linux devices are non-identity devices. Identity-based user policies and logging are not available for these devices. Use dedicated service tokens, device management and suitable Gateway policies.

***

## 9. Phase Six – Configure Cloudflare Gateway Network Policies

This phase enforces the actual access restrictions.

We will create separate policies for SQL and RDP.

### Step 20: Collect the Client's Public IP Whitelist

Before creating the policies, obtain the authorized public IP addresses.

Example:

| Server               | Public IP    | Required permission |
| -------------------- | ------------ | ------------------- |
| Windows App Server 1 | 203.0.113.10 | SQL                 |
| Linux App Server 1   | 203.0.113.20 | SQL                 |
| Administrator 1      | 203.0.113.30 | RDP                 |
| Administrator 2      | 203.0.113.40 | RDP                 |

Confirm that these are static public egress IPs.

If the external servers use NAT, identify the public IP address of the NAT gateway.

### Step 21: Create the SQL Access Policy

Navigate to:

```
Traffic Controls
    |
    +-- Firewall Policies
            |
            +-- Network Policies
```

Select Create Policy.

Configure:

**Policy Name:**

```
ALLOW-AUTHORIZED-SQL
```

**Action:**

```
Allow
```

**Conditions:**

| Selector         | Operator | Value                                    |
| ---------------- | -------- | ---------------------------------------- |
| Source IP        | In       | Authorized application server public IPs |
| Destination IP   | Is       | 192.168.1.10                             |
| Destination Port | Is       | 1433                                     |
| Protocol         | Is       | TCP                                      |

Use AND conditions between the selectors.

This policy is intended to allow only authorized application servers to reach SQL Server.

### Step 22: Create the RDP Access Policy

Create another network policy.

**Policy Name:**

```
ALLOW-AUTHORIZED-RDP
```

**Action:**

```
Allow
```

**Conditions:**

| Selector         | Operator | Value                               |
| ---------------- | -------- | ----------------------------------- |
| Source IP        | In       | Authorized administrator public IPs |
| Destination IP   | Is       | 192.168.1.10                        |
| Destination Port | Is       | 3389                                |
| Protocol         | Is       | TCP                                 |

Where available, add authorized administrator identity and device posture conditions.

Do not grant application servers RDP access simply because they have SQL access.

### Step 23: Create Default-Deny Policies

Create a blocking policy for unauthorized SQL connections.

```
Policy: BLOCK-UNAUTHORIZED-SQL

Action: Block

Destination IP: 192.168.1.10
Destination Port: 1433
Protocol: TCP
```

Create another blocking policy:

```
Policy: BLOCK-UNAUTHORIZED-RDP

Action: Block

Destination IP: 192.168.1.10
Destination Port: 3389
Protocol: TCP
```

Place the applicable allow rules before the corresponding catch-all block rules.

For a more comprehensive configuration, use a catch-all private network block policy and explicitly permit only the required services.

#### Important IP-whitelisting consideration

Cloudflare Gateway evaluates the source attributes of traffic proxied through the Cloudflare One Client.

Do not assume that the source IP visible at the Windows SQL Server is the original public IP of the external server.

The tunnel connector's local IP is visible at the origin for non-HTTP traffic.

Before enforcing the production whitelist, perform test connections and inspect Gateway Network Logs to confirm which source IP attribute represents the external device's public egress IP.

For headless Linux service-token devices, use device-specific management and carefully validate the available policy attributes.

***

## 10. Phase Seven – Configure Windows Defender Firewall

Cloudflare Gateway provides centralized access control. Windows Defender Firewall provides additional host-level protection.

Both should remain enabled.

### Step 24: Review Existing Firewall Rules

Open:

```
Windows Defender Firewall with Advanced Security
```

Review existing inbound rules for:

```
TCP 1433
TCP 3389
```

Identify and disable unnecessary unrestricted public-facing rules.

Do not remove the only working administrative access path before testing the Cloudflare connection.

### Step 25: Restrict SQL Server to the Tunnel Connector

For the recommended separate connector VM:

Example:

```
Database Server: 192.168.1.10
Connector VM:    192.168.1.20
SQL Port:        1433
```

Create an inbound firewall rule:

```
New-NetFirewallRule `
-DisplayName "Allow SQL from Cloudflare Connector" `
-Direction Inbound `
-Protocol TCP `
-LocalPort 1433 `
-RemoteAddress 192.168.1.20 `
-Action Allow `
-Profile Any
```

Remove or disable conflicting broad inbound SQL allow rules after confirming the new rule works.

### Step 26: Restrict RDP to the Connector

For a separate connector VM, create:

```
New-NetFirewallRule `
-DisplayName "Allow RDP from Cloudflare Connector" `
-Direction Inbound `
-Protocol TCP `
-LocalPort 3389 `
-RemoteAddress 192.168.1.20 `
-Action Allow `
-Profile Any
```

Disable unrestricted inbound RDP allow rules after verifying the Cloudflare connection.

If the tunnel connector runs on the same Windows Server, do not blindly apply these remote-address restrictions. First establish the actual local source address observed by the server and test the rules.

Keep Windows Defender Firewall enabled.

***

## 11. Phase Eight – Test SQL Server Connectivity

After configuring the tunnel, private route, WARP and Gateway policies, conduct the following tests.

### Step 27: Test from Authorized Windows Server

Execute:

```
Test-NetConnection 192.168.1.10 -Port 1433
```

Expected:

```
TcpTestSucceeded : True
```

Open SQL Server Management Studio.

Enter:

```
Server Name: 192.168.1.10,1433
Authentication: SQL Server Authentication
```

Enter the dedicated application SQL credentials.

Verify that the database is accessible.

### Step 28: Test from Authorized Linux Server

Execute:

```
nc -vz 192.168.1.10 1433
```

Expected:

```
Connection succeeded
```

Then test the actual database login using the application's SQL Server driver.

A successful TCP connection alone does not establish that SQL authentication, encryption or application permissions are configured correctly.

### Step 29: Test Unauthorized SQL Access

Use a device with WARP connected but which does not satisfy the SQL allow policy.

Execute:

```
Test-NetConnection 192.168.1.10 -Port 1433
```

Expected:

```
TcpTestSucceeded : False
```

Verify that Gateway logs show the connection being blocked by the intended policy.

***

## 12. Phase Nine – Test RDP Connectivity

### Step 30: Test Authorized RDP

From an authorized administrator workstation:

1. Connect Cloudflare WARP.
2. Open Windows App or Remote Desktop.
3. Enter the database server's private IP.

```
192.168.1.10
```

4. Enter authorized Windows credentials.
5. Confirm that the RDP session opens.

### Step 31: Test Unauthorized RDP

From an unauthorized device or IP:

Execute:

```
Test-NetConnection 192.168.1.10 -Port 3389
```

Expected:

```
TcpTestSucceeded : False
```

Verify the corresponding Gateway block event.

Also test that the public IP of the database server does not accept direct inbound RDP connections.

***

## 13. Phase Ten – Final Security Validation

The implementation should not be considered complete until the following tests are successful.

| Test                              | Expected result |
| --------------------------------- | --------------- |
| Tunnel connectivity               | Healthy         |
| Private network route             | Operational     |
| Authorized Windows SQL connection | Successful      |
| Authorized Linux SQL connection   | Successful      |
| Unauthorized SQL connection       | Blocked         |
| Authorized administrator RDP      | Successful      |
| Unauthorized RDP connection       | Blocked         |
| Public TCP 1433 access            | Blocked         |
| Public TCP 3389 access            | Blocked         |
| SQL authentication                | Successful      |
| SQL TLS encryption                | Verified        |
| Windows Firewall                  | Enabled         |
| Gateway logging                   | Operational     |

### Final Network Architecture

```
                  INTERNET
                     |
          +----------+----------+
          |                     |
    Windows Server          Linux Server
      WARP Client            WARP Client
          |                     |
          +----------+----------+
                     |
                     |
             CLOUDFLARE ZERO TRUST
                     |
              Cloudflare Gateway
                     |
             Network Access Policies
                     |
              Cloudflare Network
                     |
              Cloudflare Tunnel
                     |
              Connector VM
              192.168.1.20
                     |
               PRIVATE LAN
                     |
              Windows Server 2022
                192.168.1.10
                     |
             +-------+-------+
             |               |
        SQL Server           RDP
          TCP 1433         TCP 3389
             |               |
        Application       Administrator
         Access              Access
```

***

## 14. Project Limitations and Important Considerations

### 14.1 SQL Server Express Limitations

SQL Server Express is a free edition of Microsoft SQL Server.

However, it has resource and database-size limitations.

Before implementing this architecture, verify that the client's application workload is suitable for SQL Server Express.

For current versions, the maximum relational database size is 10 GB per database, with additional compute and memory limitations.

SQL Server Express does not include SQL Server Agent.

### 14.2 Cloudflare Tunnel Limitations

Cloudflare Tunnel is designed for client-initiated connections to services behind the tunnel.

It does not automatically route application-initiated outbound traffic from the database server through Cloudflare.

The tunnel connector must remain online for private connectivity.

### 14.3 IP Address Changes

If an external application server changes its public egress IP, its existing IP-based policy may no longer permit access.

The client must notify the administrator whenever an authorized IP changes.

### 14.4 Private IP Conflicts

If an external server's local network uses the same private IP range as the database server network, routing conflicts can occur.

For example:

```
External Server LAN: 192.168.1.0/24
Database LAN:        192.168.1.0/24
```

Avoid overlapping private network ranges.

### 14.5 Cloudflare Plan and Subscription

The solution is intended to avoid purchasing a separate traditional firewall subscription.

However, the Cloudflare Zero Trust Free plan must be checked against the actual deployment requirements, including Gateway TCP filtering, enrollment, service tokens, device limits, policy features and support.

Cloudflare Tunnel does not replace all features of a traditional firewall, such as general network segmentation, IDS/IPS, NAT and perimeter packet inspection.

A separate firewall appliance or service may still be required if the client needs those capabilities.

***

## 15. Project Deliverables

The following deliverables should be provided after implementation.

| No. | Deliverable              | Description                              |
| --- | ------------------------ | ---------------------------------------- |
| 1   | Cloudflare Tunnel        | Created and verified                     |
| 2   | Private Network Route    | Database IP mapped to tunnel             |
| 3   | Windows WARP Enrollment  | Authorized Windows devices               |
| 4   | Linux WARP Enrollment    | Authorized Linux devices                 |
| 5   | SQL Gateway Policy       | Restricted SQL connectivity              |
| 6   | RDP Gateway Policy       | Restricted administrator connectivity    |
| 7   | Windows Firewall Rules   | Host-level restrictions                  |
| 8   | SQL Server Configuration | Static TCP port and remote connectivity  |
| 9   | Connectivity Testing     | Windows and Linux SQL tests              |
| 10  | Security Validation      | Authorized and unauthorized access tests |
| 11  | Documentation            | Configuration and handover details       |

***

## 16. Maintenance and Operational Recommendations

After deployment, the following maintenance activities should be performed.

**Daily or continuous monitoring**

* Verify Cloudflare Tunnel health.
* Monitor SQL Server service availability.
* Monitor RDP access events.
* Review unusual or blocked connection attempts.

**Periodic review**

* Review authorized public IP addresses.
* Review Cloudflare Gateway policies.
* Review service-token expiration.
* Review device enrollment.
* Verify SQL Server backup jobs.
* Test database restoration.
* Review Windows security updates.

**Change management**

* Obtain client approval before adding new IP addresses.
* Document all firewall rule changes.
* Document all Cloudflare policy modifications.
* Maintain a rollback procedure.
* Retain an independent emergency administrative access method during deployment.

***

## 17. Conclusion

By implementing Cloudflare Zero Trust, we can provide secure private connectivity between authorized external Windows and Linux application servers and the client's SQL Server Express installation.

The proposed architecture eliminates the requirement to expose SQL Server and RDP directly to the public internet.

Cloudflare Tunnel establishes the private connection, Cloudflare One Client provides secure device connectivity, Gateway policies enforce access restrictions, and Windows Defender Firewall provides additional protection at the operating system level.

The solution provides centralized access management while reducing dependence on a separately subscribed traditional firewall service.

**Final security objective:**

```
NO PUBLIC SQL ACCESS
NO PUBLIC RDP ACCESS
ONLY AUTHORIZED PRIVATE CONNECTIVITY
IDENTITY AND IP-BASED ACCESS CONTROL
CENTRALIZED ACCESS MONITORING
```

***

## 18. Official Documentation and References

1. [Cloudflare – Private Network Connectivity](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/private-net/)
2. [Cloudflare – Connect an IP/CIDR](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/private-net/cloudflared/connect-cidr/)
3. [Cloudflare – Network Policies](https://developers.cloudflare.com/cloudflare-one/traffic-controls/network-policies/)
4. [Cloudflare – Deploy WARP on Headless Linux Machines](https://developers.cloudflare.com/cloudflare-one/tutorials/deploy-client-headless-linux/)
5. [Cloudflare – Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/)
6. [Cloudflare – Account Limits](https://developers.cloudflare.com/cloudflare-one/account-limits/)
7. [Microsoft – Configure Windows Firewall for SQL Server](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-a-windows-firewall-for-database-engine-access)
8. [Microsoft – SQL Server Network Configuration](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol)
9. [Microsoft – SQL Server Express Edition](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)

**Document status:** Proposed implementation guide. Production deployment requires confirmation of actual IP addresses, Cloudflare plan eligibility, network topology, SQL instance details and client approval.
