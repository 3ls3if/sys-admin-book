---
icon: octopus-deploy
---

# Deploying Anubis on Windows Server with IIS – Complete Installation and Configuration Guide

## Deploying Anubis on Windows Server with IIS – Complete Installation and Configuration Guide

### 1. Introduction

Modern websites receive traffic from different types of automated clients, including search engine crawlers, monitoring services, automated scripts, and AI-powered web scrapers. While some bots are useful, others can generate excessive requests, consume server resources, and collect website content without permission.

**Anubis** is an open-source web protection utility developed by Techaro. It uses browser-based challenges, including Proof-of-Work (PoW), to distinguish legitimate browser traffic from automated clients before forwarding requests to the backend web server.

In this guide, we will implement Anubis on Windows Server using Internet Information Services (IIS).

The deployment will use three components:

* **IIS Frontend:** Accepts incoming HTTP/HTTPS requests and forwards them to Anubis.
* **Anubis:** Evaluates incoming requests and presents challenges when necessary.
* **IIS Backend:** Hosts the actual website and receives validated requests from Anubis.

This architecture allows administrators to introduce Anubis protection without replacing their existing IIS-hosted website.

### 2. Understanding the Architecture

The traffic flow will be:

1. A visitor accesses the website using its public domain name.
2. IIS Frontend receives the incoming HTTPS request.
3. IIS forwards the request to Anubis running locally.
4. Anubis evaluates the request and determines whether a browser challenge is required.
5. After successful verification, Anubis forwards the request to the IIS Backend.
6. The backend processes the request and returns the response through Anubis and IIS to the visitor.

#### Network Architecture

<figure><img src="../../.gitbook/assets/mermaid-diagram (3).png" alt=""><figcaption></figcaption></figure>

#### Example Configuration

The following configuration will be used throughout this article.

| Component             | Configuration                |
| --------------------- | ---------------------------- |
| Operating System      | Windows Server 2016 or later |
| Web Server            | IIS                          |
| Public Domain         | example.com                  |
| Frontend Port         | TCP 443                      |
| Anubis Listening Port | TCP 8923                     |
| Backend Port          | TCP 3923                     |
| Frontend Site         | anubis-example-frontend      |
| Backend Site          | anubis-example-backend       |
| Backend Directory     | C:\inetpub\wwwroot           |

**Important:** The ports above are local application communication ports. Only the public web ports should be exposed to the internet.

### 3. Prerequisites

Before starting the installation, ensure the following requirements are met:

* Windows Server 2016, 2019, 2022, or a supported newer version.
* Administrator access to the server.
* A public IP address assigned to the server.
* A domain name pointing to the server's public IP.
* IIS Web Server role installed.
* URL Rewrite Module.
* Application Request Routing (ARR).
* A valid SSL/TLS certificate for the domain.
* An Anubis Windows MSI installer.

The server must also have internet connectivity to download the required installation packages.

### 4. Install and Configure IIS

#### Step 1: Install IIS

Open Server Manager and navigate to:

**Manage → Add Roles and Features → Server Roles**

Select:

* Web Server (IIS)
* Common HTTP Features
* Static Content
* Default Document
* HTTP Errors
* Application Development features as required by your website
* IIS Management Console

Complete the installation.

Alternatively, use PowerShell:

```
Install-WindowsFeature Web-Server -IncludeManagementTools
```

Verify the IIS service:

```
Get-Service W3SVC
```

If the service is stopped, start it:

```
Start-Service W3SVC
```

#### Step 2: Install URL Rewrite

Download and install the IIS URL Rewrite Module.

Official download:

[https://www.iis.net/downloads/microsoft/url-rewrite](https://www.iis.net/downloads/microsoft/url-rewrite)

URL Rewrite allows IIS to redirect or forward incoming HTTP requests to another application.

#### Step 3: Install Application Request Routing (ARR)

Download and install Application Request Routing.

Official download:

[https://www.iis.net/downloads/microsoft/application-request-routing](https://www.iis.net/downloads/microsoft/application-request-routing)

ARR enables IIS to operate as a reverse proxy and forward incoming requests to Anubis.

After installing both modules, restart IIS Manager and verify that the URL Rewrite and Application Request Routing features are available.

#### Step 4: Enable Proxy Functionality

Open IIS Manager.

1. Select the server name.
2. Open Application Request Routing Cache.
3. Select Server Proxy Settings from the Actions panel.
4. Enable the **Enable proxy** option.
5. Apply the configuration.

This enables IIS to forward incoming requests to the Anubis service.

### 5. Install Anubis on Windows Server

Anubis provides native Windows installation support through an MSI package.

Download the appropriate installer from:

[https://github.com/TecharoHQ/anubis/releases](https://github.com/TecharoHQ/anubis/releases)

Choose the appropriate architecture:

* Windows AMD64 (x64)
* Windows ARM64 (AArch64)

The AMD64 installer has the most established Windows testing.



<figure><img src="../../.gitbook/assets/image (269).png" alt=""><figcaption></figcaption></figure>

#### Step 1: Install the MSI Package

Run the downloaded MSI installer with administrator privileges and complete the installation.

The default installation directory is:

```
C:\Program Files\Techaro\Anubis
```

Anubis registers a Windows service named:

```
Anubis
```

#### Step 2: Verify the Installation

Open PowerShell as Administrator:

```
Get-Service -Name Anubis
```

The installer does not automatically start the service. This is intentional because the administrator should configure the application before starting it.

#### Step 3: Locate the Configuration Files

Anubis stores its Windows configuration and operational files under:

```
C:\ProgramData\Techaro\Anubis
```

This is separate from the application installation directory.

Review the generated configuration files before starting the service.

#### Step 4: Configure Anubis

Anubis supports environment-variable-based configuration.

For this deployment, the important settings are:

| Setting                  | Purpose                                        |
| ------------------------ | ---------------------------------------------- |
| BIND                     | Address and port on which Anubis listens       |
| TARGET                   | Backend website address                        |
| CUSTOM\_REAL\_IP\_HEADER | Header used to identify the original client IP |
| COOKIE\_DOMAIN           | Domain for the Anubis verification cookie      |
| SLOG\_LEVEL              | Logging verbosity                              |

The default Anubis listener is port 8923, and the default backend target is localhost port 3923.

For the IIS implementation, the intended traffic path is:

```
IIS Frontend
     |
     v
Anubis :8923
     |
     v
IIS Backend :3923
```

**Configuration note:** The exact method for setting these values must follow the installed MSI version's Windows configuration format. Do not assume that setting a machine-wide environment variable will automatically update an already registered Windows service.

### 6. Configure the IIS Frontend Website

The frontend website will receive all public requests and forward them to Anubis.

<figure><img src="../../.gitbook/assets/image (270).png" alt=""><figcaption></figcaption></figure>

#### Step 1: Create the Frontend Website

Open IIS Manager.

Navigate to:

**Sites → Add Website**

Configure the website:

| Setting         | Value                      |
| --------------- | -------------------------- |
| Site Name       | anubis-example-frontend    |
| Physical Path   | C:\inetpub\anubis-frontend |
| Binding Type    | HTTPS                      |
| Port            | 443                        |
| Hostname        | example.com                |
| SSL Certificate | Valid domain certificate   |

Create an empty directory for the frontend site.

Do not use the physical directory of the actual backend website.

#### Step 2: Configure SSL/TLS

Assign a valid SSL certificate to the frontend website.

You can use win-acme to obtain and renew Let's Encrypt certificates:

[https://www.win-acme.com/](https://www.win-acme.com/)

The frontend should be the public HTTPS entry point for the website.

#### Step 3: Configure Reverse Proxy

<figure><img src="../../.gitbook/assets/image (271).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (272).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (273).png" alt=""><figcaption></figcaption></figure>

Select the frontend website in IIS Manager.

Open:

**URL Rewrite → Add Rule(s) → Reverse Proxy**

Enter the following destination:

```
localhost:8923
```

Apply the configuration.

IIS will now forward incoming website requests to Anubis.

#### Step 4: Configure the Client IP Header

<figure><img src="../../.gitbook/assets/image (274).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (275).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (276).png" alt=""><figcaption></figcaption></figure>

Anubis needs the original visitor IP address rather than the address of the local reverse proxy.

Open the newly created reverse proxy rule.

Navigate to its Server Variables section and add:

```
HTTP_X_REAL_IP
```

Set its value to:

```
{REMOTE_ADDR}
```

Enable:

```
Replace the existing value
```

Next, open the URL Rewrite Actions panel and select:

**View Server Variables → Add**

Add:

```
HTTP_X_REAL_IP
```

Apply the changes.

This allows IIS to pass the original connection address to Anubis.

For security, ensure the public-facing proxy overwrites this header instead of trusting a client-supplied value.

### 7. Configure the IIS Backend Website

The backend website will host the actual application or website files.

It will not be directly exposed to public internet traffic.

<figure><img src="../../.gitbook/assets/image (277).png" alt=""><figcaption></figcaption></figure>

#### Step 1: Create the Backend Directory

Create the following directory:

```
C:\inetpub\wwwroot
```

For testing, create a simple HTML file:

```
<!DOCTYPE html>
<html>
<head>
    <title>Anubis Protected Website</title>
</head>
<body>
    <h1>Welcome to the Protected Website</h1>
    <p>Your request successfully reached the IIS backend.</p>
</body>
</html>
```

Save it as:

```
index.html
```

#### Step 2: Create the Backend IIS Website

Open IIS Manager.

Navigate to:

**Sites → Add Website**

Configure:

| Setting       | Value                  |
| ------------- | ---------------------- |
| Site Name     | anubis-example-backend |
| Physical Path | C:\inetpub\wwwroot     |
| Binding Type  | HTTP                   |
| IP Address    | 127.0.0.1              |
| Port          | 3923                   |
| Hostname      | example.com            |

Click OK.

#### Step 3: Configure the IPv6 Binding

Anubis may connect to the backend through the IPv6 loopback address.

IIS must therefore accept connections on both IPv4 and IPv6 loopback addresses.

Open the backend website's Bindings configuration.

Add another binding:

| Setting    | Value       |
| ---------- | ----------- |
| Type       | HTTP        |
| IP Address | ::1         |
| Port       | 3923        |
| Hostname   | example.com |

Apply the configuration.

The backend now accepts local requests through:

```
127.0.0.1:3923
```

and:

```
[::1]:3923
```

This is important because a backend that only listens on IPv4 may return a Bad Request response when Anubis attempts to connect through IPv6.

### 8. Start and Verify Anubis

Once the IIS frontend and backend configurations are complete, start the Anubis service.

Run PowerShell as Administrator:

```
Start-Service -Name Anubis
```

Check its status:

```
Get-Service -Name Anubis
```

Set the service to start automatically during Windows startup:

```
Set-Service -Name Anubis -StartupType Automatic
```

Verify the listening port:

```
Get-NetTCPConnection -LocalPort 8923 -State Listen
```

Check the backend listener:

```
Get-NetTCPConnection -LocalPort 3923 -State Listen
```

The backend should be listening on the configured loopback addresses.

### 9. Testing the Deployment

<figure><img src="../../.gitbook/assets/image (278).png" alt=""><figcaption></figcaption></figure>

After completing the configuration, test the website from an external browser.

#### Test 1: Access the Public Domain

Open:

```
https://example.com
```

The request should reach the IIS frontend and then Anubis.

#### Test 2: Verify the Anubis Challenge

Open the website in a modern browser.

Depending on the request and the configured policy, Anubis may display a browser verification or Proof-of-Work challenge.

Complete the challenge.

#### Test 3: Verify Backend Access

After successful verification, the browser should display:

```
Welcome to the Protected Website
Your request successfully reached the IIS backend.
```

This confirms that the request successfully travelled through IIS Frontend, Anubis, and IIS Backend.

#### Test 4: Verify Backend Isolation

From an external machine, confirm that the backend port 3923 is not publicly accessible.

Only the frontend should be exposed through the public website bindings.

### 10. Troubleshooting

| Issue                          | Possible Cause                               | Recommended Check                                    |
| ------------------------------ | -------------------------------------------- | ---------------------------------------------------- |
| HTTP 502 Bad Gateway           | Anubis is stopped or unavailable             | Check Anubis service and port 8923                   |
| HTTP 400 Bad Request           | Backend binding mismatch                     | Verify IPv4 and IPv6 bindings                        |
| Anubis challenge does not load | Required Anubis assets are not being proxied | Check URL Rewrite and ARR configuration              |
| Infinite challenge loop        | Cookie or proxy-header configuration problem | Check cookies, hostname, HTTPS and client IP headers |
| Backend website inaccessible   | Incorrect port or binding                    | Verify port 3923 and IIS site status                 |
| Anubis service fails to start  | Invalid configuration or service permissions | Review Anubis startup logs                           |
| Incorrect client IP in logs    | Original IP header is not passed correctly   | Verify HTTP\_X\_REAL\_IP                             |

#### Check Anubis Service

```
Get-Service Anubis
```

#### Check Port Availability

```
Test-NetConnection -ComputerName 127.0.0.1 -Port 8923
```

```
Test-NetConnection -ComputerName 127.0.0.1 -Port 3923
```

#### Check IIS Websites

```
Import-Module WebAdministration

Get-Website
```

#### Review Anubis Logs

The default Windows log directory is:

```
C:\ProgramData\Techaro\Anubis
```

Review the following files:

* `anubis.log`
* `anubis-bootstrap.log`
* `anubis-startup.log`

These logs help identify application errors, installation problems, and service startup issues.

### 11. Production Deployment Recommendations

Before deploying Anubis on a production IIS server, consider the following recommendations:

1. **Restrict backend access:** Do not expose port 3923 publicly. Keep the backend bound to loopback addresses.
2. **Secure Anubis:** Keep the Anubis listener accessible only to the local reverse proxy.
3. **Use HTTPS:** Configure a valid TLS certificate on the frontend website.
4. **Preserve client IP information:** Configure trusted proxy headers correctly.
5. **Review bot policies:** Avoid unintentionally blocking legitimate crawlers and monitoring services.
6. **Monitor service health:** Monitor the Anubis service, IIS application pools, CPU, RAM, and disk usage.
7. **Maintain configuration backups:** Back up the Anubis configuration and policy files before upgrades.
8. **Plan upgrades:** Schedule Anubis upgrades during maintenance windows and verify the service startup configuration afterward.
9. **Test application compatibility:** Check login sessions, redirects, API requests, uploads, and WebSocket-dependent features before production rollout.

Anubis should be considered an additional application-layer protection component, not a replacement for a network firewall, WAF, DDoS protection, or regular server hardening.

### 12. Conclusion

Deploying Anubis on Windows Server with IIS provides administrators with another layer of protection against automated scraping and unwanted bot traffic.

By implementing a separate IIS frontend and backend, administrators can introduce Anubis without making major changes to their existing website hosting environment.

The resulting architecture is:

```
Internet
   |
   v
IIS Frontend (HTTPS)
   |
   v
Anubis (Bot Verification)
   |
   v
IIS Backend (Website Hosting)
```

This approach is particularly useful for Windows hosting environments where IIS is already used to host websites and applications.

For production deployments, administrators should carefully validate proxy headers, application compatibility, service permissions, logging, and backend isolation before making the website publicly available.

***

### Official References

* Anubis Project: [https://github.com/TecharoHQ/anubis](https://github.com/TecharoHQ/anubis)
* Anubis Windows Installation Documentation: [https://anubis.techaro.lol/docs/admin/environments/windows](https://anubis.techaro.lol/docs/admin/environments/windows)
* Anubis on IIS – Original Implementation Guide: [https://rentry.co/anubis-on-iis](https://rentry.co/anubis-on-iis)
* IIS URL Rewrite: [https://www.iis.net/downloads/microsoft/url-rewrite](https://www.iis.net/downloads/microsoft/url-rewrite)
* IIS Application Request Routing: [https://www.iis.net/downloads/microsoft/application-request-routing](https://www.iis.net/downloads/microsoft/application-request-routing)
* win-acme: [https://www.win-acme.com/](https://www.win-acme.com/)

