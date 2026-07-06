---
icon: cloud
---

# How to Find the IP Address Used to Access Your Windows Server via Remote Desktop (RDP)

## How to Find the IP Address Used to Access Your Windows Server via Remote Desktop (RDP)

Remote Desktop Protocol (RDP) is one of the most commonly used methods for remotely managing Windows servers. From a security and auditing perspective, it is important to know **who accessed your server and from which IP address**. Windows records this information in the Event Viewer, making it possible to identify the source of successful RDP logins.

This article explains several methods to determine the client IP address used for an RDP connection.

***

## Method 1: Check the Windows Security Log (Recommended)

The Windows Security log records every successful and failed logon attempt. For RDP sessions, the most important event is **Event ID 4624** with **Logon Type 10**, which represents a successful Remote Desktop login.

### Step 1: Open Event Viewer

1. Press **Windows + R**.
2. Type:

```
eventvwr.msc
```

3. Click **OK**.

***

### Step 2: Navigate to the Security Log

In Event Viewer, browse to:

```
Windows Logs   └── Security
```

***

### Step 3: Filter the Log

1. Select **Filter Current Log...**
2. Enter the following Event ID:

```
4624
```

3. Click **OK**.

***

### Step 4: Identify an RDP Login

Open a **4624** event and locate the following field:

```
Logon Type: 10
```

**Logon Type 10** indicates a successful Remote Desktop (RemoteInteractive) login.

***

### Step 5: Find the Source IP Address

Within the same event, scroll down to locate:

```
Source Network AddressSource Port
```

Example:

```
Account Name: AdministratorLogon Type: 10Source Network Address: 192.168.1.100Source Port: 51342
```

The **Source Network Address** is the client IP address from which the RDP session originated.

***

## Understanding Logon Types

| Logon Type | Description                       |
| ---------- | --------------------------------- |
| 2          | Interactive (Local console login) |
| 3          | Network access                    |
| 5          | Service                           |
| 7          | Unlock workstation                |
| **10**     | **Remote Desktop (RDP)**          |
| 11         | Cached Interactive                |

For RDP auditing, always look for **Logon Type 10**.

***

## Method 2: Use PowerShell

PowerShell provides a quick way to retrieve successful RDP logins along with the source IP addresses.

Run the following command in an elevated PowerShell window:

```
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624} |Where-Object { $_.Properties[8].Value -eq 10 } |ForEach-Object {    [PSCustomObject]@{        Time = $_.TimeCreated        User = $_.Properties[5].Value        IP   = $_.Properties[18].Value    }}
```

#### Sample Output

| Time             | User          | IP            |
| ---------------- | ------------- | ------------- |
| 2026-07-07 10:15 | Administrator | 192.168.1.100 |
| 2026-07-07 14:42 | Admin         | 203.0.113.25  |

This method is particularly useful when reviewing multiple login events.

***

## Method 3: Check the Terminal Services Log

Windows also maintains logs specifically for Remote Desktop Services.

Navigate to:

```
Event Viewer└── Applications and Services Logs    └── Microsoft        └── Windows            └── TerminalServices-RemoteConnectionManager                └── Operational
```

Look for:

```
Event ID: 1149
```

Event ID **1149** indicates successful RDP authentication and often includes the client's IP address.

***

## What If the Source Network Address Is Blank?

In some situations, the **Source Network Address** field may display:

```
-
```

or

```
::1
```

This may occur for several reasons:

* The RDP session originated from the local machine (localhost).
* The connection passed through a Remote Desktop Gateway (RD Gateway).
* The session was reconnected instead of establishing a new login.
* The event is not actually an RDP login (verify that the **Logon Type** is **10**).

***

## Other Useful RDP Event IDs

| Event ID | Description                   |
| -------- | ----------------------------- |
| **4624** | Successful logon              |
| **4625** | Failed logon attempt          |
| **4634** | User logged off               |
| **4647** | User initiated logoff         |
| **4778** | RDP session reconnected       |
| **4779** | RDP session disconnected      |
| **1149** | Successful RDP authentication |

Monitoring these events provides a comprehensive audit trail of Remote Desktop activity.

***

## Best Practices for RDP Auditing

* Regularly review **Event ID 4624** for successful RDP logins.
* Monitor **Event ID 4625** to identify failed login attempts or potential brute-force attacks.
* Enable Security log auditing to ensure login events are recorded.
* Restrict RDP access using firewalls, VPNs, or RD Gateway where possible.
* Review login activity periodically to identify unauthorized access attempts.

***

## Conclusion

The most reliable way to determine **which IP address was used to access a Windows server via Remote Desktop** is by reviewing **Event ID 4624** in the **Windows Security log** and confirming that the **Logon Type** is **10**. The **Source Network Address** field within the event identifies the client IP address that initiated the RDP session.

For administrators managing multiple servers, PowerShell offers an efficient way to retrieve and analyze RDP login events, while the Terminal Services logs provide additional authentication details for troubleshooting and auditing purposes.
