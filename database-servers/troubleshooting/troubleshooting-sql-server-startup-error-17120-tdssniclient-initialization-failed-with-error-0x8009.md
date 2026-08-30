---
icon: windows
---

# Troubleshooting SQL Server Startup Error 17120: TDSSNIClient Initialization Failed with Error 0x8009

While working on a Windows Server environment running Microsoft SQL Server, I recently encountered an interesting SQL Server startup issue where the SQL Server service failed to initialize its network library.

The initial error appeared as:

```
SQL Server could not spawn FRunCommunicationsManager thread.
```

At first, this can look like a networking or port conflict issue. However, further investigation of the SQL Server `ERRORLOG` revealed that the actual problem was related to the **SQL Server TLS/SSL certificate configuration**.

This blog explains the symptoms, troubleshooting process, root cause, and the resolution.

***

### The Problem

The SQL Server service was failing during startup, and the Windows Event Viewer reported:

```
Event ID: 17120Source: MSSQLSERVERSQL Server could not spawn FRunCommunicationsManager thread.Check the SQL Server error log and the operating system error logfor information about possible related problems.
```

At the same time, the SQL Server `ERRORLOG` contained:

```
Error: 17182, Severity: 16, State: 1.TDSSNIClient initialization failed with error 0x80092004,status code 0x1.Reason: Initialization failed with an infrastructure error.Cannot find object or property.
```

This was followed by:

```
Error: 17826, Severity: 18, State: 3.Could not start the network library because of an internalerror in the network library.
```

And finally:

```
Error: 17120, Severity: 16, State: 1.SQL Server could not spawn FRunCommunicationsManager thread.
```

***

## Understanding the Error Chain

The important thing here is **not to troubleshoot Event ID 17120 in isolation**.

The errors occurred in this sequence:

```
TDSSNIClient initialization failed          ↓SQL Server network library failed          ↓FRunCommunicationsManager thread failed          ↓SQL Server startup failed
```

The most useful error was:

```
0x80092004Cannot find object or property
```

This pointed us toward the SQL Server **TLS/SSL certificate configuration**.

***

## Initial Assumption: Port Conflict

Because SQL Server was failing to initialize its network library, one of the first things worth checking is whether another application is already using the configured SQL Server port.

For example, if SQL Server is configured to use port **1443**, we can check it using:

```
netstat -ano | findstr :1443
```

Or using PowerShell:

```
Get-NetTCPConnection -LocalPort 1443 -ErrorAction SilentlyContinue |Select-Object LocalAddress,LocalPort,State,OwningProcess
```

If a process is listening on the port, its PID can be identified with:

```
tasklist /FI "PID eq <PID>"
```

However, in this case, **the port itself was not the root cause**.

The SQL Server network stack was failing before it could successfully initialize.

***

## Checking the SQL Server Error Log

The SQL Server startup parameters showed that the ERRORLOG was located at:

```
C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Log\ERRORLOG
```

Reviewing the log around the startup failure revealed:

```
TDSSNIClient initialization failed with error 0x80092004
```

This was the key finding.

Instead of immediately changing firewall rules, ports, or SQL Server network protocols, the next step was to investigate the SQL Server certificate configuration.

***

## Checking SQL Server Certificate Configuration

Open:

**SQL Server Configuration Manager**

Navigate to:

```
SQL Server Network Configuration        ↓Protocols for MSSQLSERVER        ↓Properties
```

Then open the:

**Certificate** tab.

Here, SQL Server can have a specific TLS certificate assigned to the instance.

If a certificate is configured incorrectly, expired, inaccessible, or otherwise unsuitable for SQL Server, the SQL Server network layer may fail during startup.

***

## The Resolution

In my case, the issue was resolved by removing the problematic certificate assignment from SQL Server.

#### Step 1 — Open SQL Server Configuration Manager

Open:

```
SQL Server Configuration Manager
```

#### Step 2 — Navigate to the SQL Server Protocols

Go to:

```
SQL Server Network Configuration→ Protocols for MSSQLSERVER
```

Right-click:

```
Protocols for MSSQLSERVER→ Properties
```

#### Step 3 — Open the Certificate Tab

Go to:

```
Certificate
```

The configured certificate was identified as part of the troubleshooting process.

Rather than deleting the certificate from Windows, the certificate assignment was removed from the SQL Server configuration.

**Important:** Removing the certificate assignment from SQL Server is different from deleting the certificate from the Windows certificate store.

***

## Checking Force Encryption

The next step was to check the:

```
Flags
```

tab.

For troubleshooting, where encryption was not specifically required, **Force Encryption** was set to:

```
No
```

The objective was to allow SQL Server to start without forcing the problematic certificate configuration.

***

## Restarting SQL Server

After applying the configuration changes, the SQL Server service was restarted.

Using PowerShell:

```
Restart-Service MSSQLSERVER
```

Or from:

```
SQL Server Configuration Manager→ SQL Server Services→ SQL Server (MSSQLSERVER)→ Restart
```

After the restart, SQL Server successfully initialized.

***

## Verifying SQL Server

After SQL Server started successfully, I verified that the service was running:

```
Get-Service MSSQLSERVER
```

The expected result was:

```
Status    Name------    ----Running   MSSQLSERVER
```

I then checked whether SQL Server was listening on the configured TCP port.

For example, if using port 1443:

```
netstat -ano | findstr :1443
```

The expected result would be similar to:

```
TCP    0.0.0.0:1443    0.0.0.0:0    LISTENING    <PID>
```

The PID can then be verified:

```
tasklist /FI "PID eq <PID>"
```

***

## Why This Error Can Be Misleading

One of the most important lessons from this issue is that:

```
SQL Server could not spawn FRunCommunicationsManager thread
```

does **not necessarily mean there is a problem with the server's CPU, RAM, or firewall**.

The FRunCommunicationsManager thread is associated with SQL Server's communication/network initialization.

Therefore, errors earlier in the SQL Server ERRORLOG are much more valuable.

In this case:

```
0x80092004Cannot find object or property
```

was the clue that led to the certificate/TLS configuration.

***

## Troubleshooting Checklist

If you encounter the same issue, I recommend following this order.

#### 1. Check the SQL Server service

```
Get-Service MSSQLSERVER
```

#### 2. Check Windows Event Viewer

Look under:

```
Windows Logs→ Application
```

Search for:

```
MSSQLSERVER
```

and:

```
Event ID 17120
```

#### 3. Check SQL Server ERRORLOG

Look for errors immediately **before** Event ID 17120.

Pay particular attention to:

```
1718217826171202601417190
```

#### 4. Check TDSSNIClient errors

If you see:

```
TDSSNIClient initialization failed
```

investigate SQL Server's network and TLS configuration.

#### 5. Check SQL Server certificate configuration

Navigate to:

```
SQL Server Configuration Manager→ SQL Server Network Configuration→ Protocols for MSSQLSERVER→ Properties→ Certificate
```

#### 6. Check Force Encryption

Review:

```
Flags→ Force Encryption
```

#### 7. Check the SQL Server port

For port 1443:

```
netstat -ano | findstr :1443
```

For the default SQL Server port:

```
netstat -ano | findstr :1433
```

***

## Important Security Consideration

Although setting:

```
Force Encryption = No
```

helped resolve the startup problem in this troubleshooting scenario, it should **not automatically be considered the final production configuration**.

If your environment requires encrypted SQL Server connections, the proper long-term solution is to configure a **valid SQL Server TLS certificate** and correctly configure SQL Server encryption.

The goal should be:

```
Valid Certificate        ↓Correct SQL Server Certificate Assignment        ↓Correct TLS Configuration        ↓Force Encryption = Yes (when required)
```

rather than permanently disabling encryption just to make SQL Server start.

***

## Final Takeaway

The key lesson from this incident was:

> **Don't troubleshoot SQL Server Event ID 17120 alone. Always inspect the SQL Server ERRORLOG entries immediately before it.**

In this case, the apparent problem was:

```
FRunCommunicationsManager thread failed
```

but the actual underlying issue was:

```
TDSSNIClient initialization failed0x80092004Cannot find object or property
```

The SQL Server network layer could not initialize correctly because of the certificate/TLS configuration.

After removing the problematic certificate assignment and disabling forced encryption for troubleshooting, the SQL Server service started successfully.

#### Troubleshooting flow

```
SQL Server fails to start          ↓Event ID 17120          ↓Check SQL Server ERRORLOG          ↓TDSSNIClient initialization failed          ↓0x80092004          ↓Check SQL Server Certificate/TLS configuration          ↓Remove problematic certificate assignment          ↓Set Force Encryption appropriately          ↓Restart SQL Server          ↓Verify SQL Server service          ↓Verify TCP port          ↓Test SQL connectivity
```

**This was a good reminder that SQL Server startup errors can sometimes look like networking or resource issues when the real problem is buried in the TLS/certificate configuration.**
