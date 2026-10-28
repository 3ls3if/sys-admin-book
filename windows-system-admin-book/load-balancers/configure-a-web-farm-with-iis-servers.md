---
icon: globe-pointer
---

# Configure a Web Farm with IIS Servers

## Overview

This guide covers an IIS web farm using Internet Information Services (IIS), Application Request Routing (ARR), URL Rewrite, IIS Shared Configuration, SSL Central Certificate Store (CCS), and Web Deploy. ARR acts as a reverse proxy and distributes HTTP/HTTPS requests to backend web servers. This is an IIS application-layer web farm, not Windows Network Load Balancing (NLB).

## Reference architecture

| Server    | Role                                                 | Example IP    |
| --------- | ---------------------------------------------------- | ------------- |
| IIS-ARR01 | ARR reverse proxy and load balancer                  | 192.168.10.10 |
| WEB01     | Backend IIS web server 1                             | 192.168.10.21 |
| WEB02     | Backend IIS web server 2                             | 192.168.10.22 |
| FILE01    | Shared configuration, certificates, deployment files | 192.168.10.30 |

Example website: www.example.com. Example application directory: C:\Sites\WebApp. Replace example values with those from your environment.

## Prerequisites

* Supported Windows Server versions and compatible IIS components.
* Administrator access, static IP addresses, working DNS, and network connectivity.
* IIS on WEB01, WEB02, and IIS-ARR01.
* URL Rewrite and ARR on IIS-ARR01.
* A valid TLS certificate.
* Restricted SMB shares and appropriate NTFS permissions if shared content/configuration is used.
* Matching application versions, runtimes, and required IIS modules on backend servers.

## Step 1 — Install IIS web farm infrastructure

### 1.1 Install IIS on WEB01 and WEB02

Run PowerShell as Administrator on each backend server:

```powershell
Install-WindowsFeature Web-Server -IncludeManagementTools
Install-WindowsFeature Web-Http-Logging, Web-Request-Monitor, Web-Filtering, Web-Stat-Compression, Web-Dyn-Compression
```

Install additional features and application runtimes only as required. ASP.NET Core applications typically require the appropriate ASP.NET Core Hosting Bundle.

Verify IIS:

```powershell
Get-WindowsFeature Web-Server
Invoke-WebRequest http://localhost
```

### 1.2 Install IIS on IIS-ARR01

```powershell
Install-WindowsFeature Web-Server -IncludeManagementTools
```

### 1.3 Prepare shared folders (if required)

On FILE01:

```powershell
New-Item -ItemType Directory -Force -Path D:\WebFarm\Config, D:\WebFarm\Certificates, D:\WebFarm\Deploy
```

Publish restricted SMB shares such as WebFarmConfig$, WebFarmCertificates$, and WebFarmDeploy$. Grant access only to administrators, the deployment identity, and relevant server/service identities. Do not grant Everyone Full Control. Restrict certificate private-key access especially carefully.

### 1.4 Install ARR and URL Rewrite

On IIS-ARR01, install compatible versions of:

1. IIS URL Rewrite
2. IIS Application Request Routing (ARR)

Use official IIS extension downloads and verify compatibility with your Windows Server and IIS versions. Open IIS Manager (inetmgr) and confirm Application Request Routing Cache and URL Rewrite are available.

Microsoft reference: [Step 1 — Install IIS Web Farm Infrastructure](https://learn.microsoft.com/en-us/iis/web-hosting/scenario-build-a-web-farm-with-iis-servers/configuring-step-1-install-iis-web-farm-infrastructure).

## Step 2 — Configure IIS web farm servers

### 2.1 Create a test website

On WEB01:

```powershell
New-Item -ItemType Directory -Force -Path C:\Sites\WebApp

@'
<!DOCTYPE html>
<html>
<head><title>IIS Web Farm Test</title></head>
<body><h1>Response from WEB01</h1></body>
</html>
'@ | Set-Content C:\Sites\WebApp\index.html
```

In IIS Manager, select Sites → Add Website and configure:

* Site name: WebApp
* Physical path: C:\Sites\WebApp
* Binding: HTTP, port 80
* Host name: www.example.com if using a host-header binding

Repeat on WEB02, changing the page text to Response from WEB02. This helps identify which backend responds.

### 2.2 Choose a content model

* **Shared content:** Both backend servers read the application from a shared SMB path such as \\\FILE01\WebFarmContent$. Set the site's physical path to that UNC path and grant the effective application identity the required share and NTFS permissions.
* **Replicated local content:** Keep a local copy on each web server and deploy the same release to both using Web Deploy or a controlled pipeline.

Do not assume the default IIS application-pool identity can access a remote share. Use an appropriately configured service identity. Consider file locking, write access, availability, and performance before choosing shared content.

### 2.3 Configure IIS Shared Configuration (optional)

IIS Shared Configuration synchronizes IIS configuration. It does not synchronize website files, runtimes, certificates automatically, or databases.

On WEB01:

1. Open IIS Manager and select the server node.
2. Open Shared Configuration and back up the existing IIS configuration.
3. Export configuration to a protected location.
4. Securely copy exported files and required encryption keys to the shared configuration directory on FILE01.
5. Enable shared configuration, enter the UNC path and required credentials, then apply and test.

On WEB02:

1. Back up its existing IIS configuration.
2. Open Shared Configuration.
3. Enable shared configuration and enter the same UNC path and credentials.
4. Import required encryption keys as needed.
5. Apply and verify the website.

Protect encryption passwords and keys. Keep IIS modules and application dependencies consistent. Test changes on one server before applying them to the farm.

### 2.4 Verify backend connectivity

From IIS-ARR01:

```powershell
Test-NetConnection 192.168.10.21 -Port 80
Test-NetConnection 192.168.10.22 -Port 80
```

Both should return TcpTestSucceeded : True. If not, check firewall rules, routing, IIS bindings, and site status.

Microsoft reference: [Step 2 — Configure IIS Web Farm Servers](https://learn.microsoft.com/en-us/iis/web-hosting/scenario-build-a-web-farm-with-iis-servers/configuring-step-2-configure-iis-web-farm-servers).

## Step 3 — Configure IIS web farm load balancing

### 3.1 Enable the ARR proxy

On IIS-ARR01:

1. Open IIS Manager and select the server node.
2. Open Application Request Routing Cache.
3. Select Server Proxy Settings.
4. Enable Proxy and apply the change.

If the feature is missing, verify ARR and URL Rewrite installation.

### 3.2 Create a server farm

1. In IIS Manager, right-click Server Farms and select Create Server Farm.
2. Name the farm WebFarm.
3. Add backend servers 192.168.10.21 and 192.168.10.22.
4. Complete the wizard and accept the option to create the URL Rewrite rule for the farm.

### 3.3 Configure load balancing

Open Server Farms → WebFarm → Load Balance and choose an algorithm. Round Robin is a reasonable starting point for a lab.

| Algorithm             | Typical use                                   |
| --------------------- | --------------------------------------------- |
| Round Robin           | Distributes requests sequentially             |
| Weighted Round Robin  | Gives servers different shares of traffic     |
| Least current request | Prefers the server with fewer active requests |

Algorithms vary by ARR version. Round Robin does not guarantee that a user stays on the same backend. Applications using in-memory sessions may need persistence or a shared session store.

### 3.4 Configure health monitoring

Configure the farm health test using a path that returns success on both backend servers. For a lab, create a static health.html file on each server and configure the test path supported by your ARR version.

For production, prefer an application-specific endpoint that checks required dependencies. A static page confirms IIS responds but does not prove that the database or other dependencies are healthy.

### 3.5 Configure the frontend site

On IIS-ARR01, create or configure the frontend website:

* Site name: WebFarmFrontend
* Port: 80 for the HTTP lab
* Host name: www.example.com

Confirm the generated URL Rewrite rule forwards requests to WebFarm. Avoid conflicting catch-all rules that override the farm rule.

### 3.6 Configure DNS and firewall rules

Point www.example.com to the frontend address or public IP/NAT endpoint that forwards traffic to IIS-ARR01. For a temporary lab test, add a hosts-file entry only if the frontend address is reachable from the client:

```
192.168.10.10 www.example.com
```

Allow clients to reach the frontend on required ports and allow IIS-ARR01 to reach backend servers on their configured application ports. Restrict backend traffic to authorized sources and limit RDP/administration access to management networks.

### 3.7 Test load balancing

Set different text in the index page on WEB01 and WEB02. From a client that can reach the frontend:

```powershell
1..10 | ForEach-Object {
    (Invoke-WebRequest "http://www.example.com" -UseBasicParsing).Content
}
```

If Round Robin is operating as expected and affinity/caching do not interfere, repeated requests should show responses from both servers. If only one server responds, inspect farm status, health tests, URL Rewrite, proxy settings, affinity, and caching.

Microsoft reference: [Step 3 — Configure IIS Web Farm Load Balancing](https://learn.microsoft.com/en-us/iis/web-hosting/scenario-build-a-web-farm-with-iis-servers/configuring-step-3-configure-iis-web-farm-load-balancing).

## Step 4 — Configure SSL Central Certificate Store (CCS)

CCS allows IIS to load certificates from a central network share. It is optional; a small lab can use a certificate installed locally on the TLS-terminating IIS server.

### 4.1 Install the CCS feature

Check feature availability on each IIS server that will use CCS:

```powershell
Get-WindowsFeature Web-CertProvider
```

Where supported:

```powershell
Install-WindowsFeature Web-CertProvider
```

Alternatively, use Server Manager → Add Roles and Features → Web Server (IIS) → Web Server → Security → Centralized SSL Certificate Support. Confirm feature availability for your Windows Server version.

### 4.2 Prepare the certificate share

Create a restricted directory on FILE01, for example D:\WebFarm\Certificates, and share it as \\\FILE01\WebFarmCertificates$. Restrict share and NTFS permissions to intended IIS server identities or a dedicated account.

Obtain a valid PFX certificate for the website, such as www.example.com.pfx, following the IIS CCS naming convention. Protect PFX files and private keys. Never place them in a public web directory.

### 4.3 Enable CCS in IIS Manager

On each IIS server using CCS:

1. Open IIS Manager and select the server node.
2. Open Centralized Certificates and select Edit Feature Settings.
3. Enable centralized certificates and specify the certificate share UNC path.
4. Configure required credentials and certificate password settings.
5. Apply and verify certificate access.

### 4.4 Configure HTTPS bindings

On the server terminating client HTTPS, open the frontend site's Bindings → Add:

* Type: HTTPS
* Port: 443
* Host name: www.example.com
* SNI: enable when required for hostname-based TLS bindings
* Certificate: select the appropriate certificate or CCS option

Test:

```powershell
Invoke-WebRequest https://www.example.com
```

Verify hostname matching, certificate trust, expiry, and private-key access. If ARR terminates TLS and forwards over HTTP, protect the backend network. Use HTTPS between ARR and backend as required by policy.

Microsoft reference: [Step 4 — Configure SSL Central Certificate Store](https://learn.microsoft.com/en-us/iis/web-hosting/scenario-build-a-web-farm-with-iis-servers/configuring-step-4-configure-ssl-central-certificate-store).

## Step 5 — Configure application deployment

Use Web Deploy or a CI/CD pipeline for controlled deployments. FTP is optional and should not be exposed unnecessarily.

### 5.1 Install Web Deploy

Install a compatible Microsoft Web Deploy version on the deployment workstation/server and destinations as required. Configure the Web Management Service and publishing endpoint only for remote deployment. Restrict access to trusted management networks and use a dedicated least-privilege deployment identity.

Reference: [Introduction to Web Deploy](https://learn.microsoft.com/en-us/iis/publish/using-web-deploy/introduction-to-web-deploy).

### 5.2 Choose a deployment model

* **Shared content:** Deploy the release once to the shared content location. Both backend servers read the same files.
* **Local copies:** Deploy the same release to WEB01 and WEB02 using Web Deploy or a controlled pipeline.

### 5.3 Deployment workflow

1. Build and package the application.
2. Back up the current release and configuration.
3. Deploy to staging and validate.
4. Deploy the same version to the backend servers.
5. Verify application health and behavior.
6. Monitor logs and roll back if the release fails.

A local directory synchronization example:

```powershell
& "$env:ProgramFiles\IIS\Microsoft Web Deploy V3\msdeploy.exe" -verb:sync "-source:contentPath=C:\Build\WebApp" "-dest:contentPath=C:\Sites\WebApp"
```

This synchronizes local directories; it is not a remote publishing command. Adjust paths and provider settings for your installed version and deployment design. Test in staging first.

### 5.4 FTP option

If FTP is required, install the IIS FTP role service, create a dedicated site and deployment directory, configure authentication and authorization, use FTPS with a valid certificate, and restrict access to trusted deployment clients. FTP is not required for ARR or the web farm itself.

Microsoft reference: [Step 5 — Configure Application Deployment](https://learn.microsoft.com/en-us/iis/web-hosting/scenario-build-a-web-farm-with-iis-servers/configuring-step-5-configure-application-deployment).

## Step 6 — Validate the web farm

* [ ] WEB01 and WEB02 respond directly.
* [ ] Both servers have compatible IIS modules, runtimes, and application dependencies.
* [ ] Both servers serve the intended application release.
* [ ] ARR proxy is enabled and WebFarm contains both backend servers.
* [ ] Both backend servers pass health tests.
* [ ] Requests through the frontend reach both servers.
* [ ] HTTPS certificate matches the hostname and is trusted.
* [ ] Deployment succeeds and rollback is documented.
* [ ] Share and NTFS permissions are restricted.
* [ ] Backend ports are accessible only from authorized sources.
* [ ] Configuration, certificates, and application data are backed up.

Check IIS status:

```powershell
Import-Module WebAdministration
Get-Website
Get-WebAppPoolState *
```

IIS logs are normally located under C:\inetpub\logs\LogFiles.

## Step 7 — Test backend failure

Perform this test in a lab or planned maintenance window:

1. Confirm WEB01 and WEB02 are healthy.
2. Send repeated requests through the frontend.
3. Stop the website on WEB01.
4. Confirm ARR health monitoring marks WEB01 unhealthy or removes it from distribution as configured.
5. Verify requests continue to reach WEB02.
6. Restore WEB01 and verify it returns to service after passing health checks.

Backend failover does not make IIS-ARR01 highly available. If the ARR frontend fails, the website may still be unavailable. Consider redundant ARR servers behind an external load balancer or another suitable high-availability mechanism for production.

## Troubleshooting

| Symptom                       | Checks                                                                               |
| ----------------------------- | ------------------------------------------------------------------------------------ |
| HTTP 502 from ARR             | Backend reachability, ports, farm status, proxy settings, URL Rewrite rule, and logs |
| HTTP 500 from IIS             | Application logs, IIS logs, runtimes, permissions, and configuration                 |
| Only one backend responds     | Health status, affinity, caching, and routing rules                                  |
| HTTP 403 accessing a share    | Effective application identity, SMB share permissions, and NTFS permissions          |
| HTTPS certificate error       | Hostname, chain, expiry, SNI, private-key access, and CCS configuration              |
| Application sessions are lost | In-memory session state, persistence, and shared session storage                     |

Test backend connectivity from IIS-ARR01:

```powershell
Test-NetConnection 192.168.10.21 -Port 80
Test-NetConnection 192.168.10.22 -Port 80
```

## Production recommendations

* Deploy redundant ARR servers behind an appropriate highly available frontend.
* Make shared storage highly available and back up IIS configuration and certificate data.
* Keep sessions, uploads, and application data consistent across backend servers.
* Monitor application health, backend latency, HTTP error rates, and certificate expiry.
* Use least-privilege identities, restricted firewall rules, HTTPS, and tested recovery procedures.
* Validate installers and feature availability against the actual Windows Server and IIS versions; Microsoft's original walkthrough may target an older platform generation.
