---
icon: circle-nodes
---

# Hosting a Local Application Behind HTTPS Using IIS Reverse Proxy

## Hosting a Local Application Behind HTTPS Using IIS Reverse Proxy

This article explains how to configure **Internet Information Services (IIS)** on Windows Server to act as a **reverse proxy**, allowing a public HTTPS domain to display content from a locally running application.

In this setup:

* Public URL: [**https://example.com**](https://example.com/)
* Local application: [**http://192.168.31.172:3000**](http://192.168.31.172:3000/)

When users visit `https://example.com`, IIS will securely forward the request to the local application running on port `3000` and return the response transparently.

***

### Why Use a Reverse Proxy in IIS?

A reverse proxy allows IIS to:

* Serve a **local or internal application** over HTTPS
* Terminate SSL (HTTPS) at IIS while the backend remains HTTP
* Hide internal IP addresses and ports from users
* Centralize security, logging, and access control

IIS does not provide reverse proxy functionality by default, so we use **Application Request Routing (ARR)** along with **URL Rewrite**.

***

### Prerequisites

Before you begin, ensure:

* IIS is installed on Windows Server
* You have administrator access
* The IIS server can reach `http://192.168.31.172:3000`
* A valid SSL certificate is available for `example.com`

***

### Step 1 — Install Application Request Routing (ARR)

IIS requires **ARR** and **URL Rewrite** to function as a reverse proxy.

#### Option A: Install via Web Platform Installer

Install the following components:

* **Application Request Routing 3.0**
* **URL Rewrite Module 2.1**

Restart IIS Manager after installation.

#### Option B: Manual Installation

Download and install manually:

* URL Rewrite Module: [https://www.iis.net/downloads/microsoft/url-rewrite](https://www.iis.net/downloads/microsoft/url-rewrite)
* Application Request Routing: [https://www.iis.net/downloads/microsoft/application-request-routing](https://www.iis.net/downloads/microsoft/application-request-routing)

After installation, restart IIS Manager.

***

### Step 2 — Enable Proxy Support in ARR

By default, ARR proxy functionality is disabled.

1. Open **IIS Manager**
2. Click the **server name** in the left panel
3. Open **Application Request Routing Cache**
4. In the right panel, click **Server Proxy Settings**
5. Check **Enable Proxy**
6. Click **Apply**

This enables IIS to forward incoming requests to backend servers.

***

### Step 3 — Create the Reverse Proxy Rule

Now configure the website to forward traffic to the local application.

1. In **IIS Manager**, select your website (e.g., `example.com`)
2. Open **URL Rewrite**
3. Click **Add Rule(s)…**
4. Choose **Reverse Proxy**
5. Enter the backend URL:

```
http://192.168.31.172:3000
```

6. Enable the option:
   * ✔ **Reverse rewrite host in response headers**
7. Click **Apply**

IIS will automatically generate the necessary inbound and outbound rewrite rules.

***

### Step 4 — Configure HTTPS Binding

Ensure the website is properly bound to HTTPS.

1. Select the website in IIS
2. Click **Bindings…**
3. Add or edit an HTTPS binding with:
   * **Type:** https
   * **Hostname:** example.com
   * **SSL Certificate:** Select your valid certificate
4. Click **OK**

IIS will now handle HTTPS traffic and forward it to the backend application over HTTP.

***

### Final Result

Once configured, users visiting:

```
https://example.com
```

Will see the content served from:

```
http://192.168.31.172:3000
```

The reverse proxy is completely transparent to the end user.

***

### Common Troubleshooting Tips

* **502 Bad Gateway**: Ensure the backend application is running and reachable
* **500.52 Error**: Proxy is not enabled in ARR settings
* **Connection refused**: Confirm port `3000` is open and listening on `0.0.0.0`
* **Mixed content warnings**: Ensure the application generates relative URLs or respects forwarded headers

***

### Conclusion

Using IIS with Application Request Routing provides a powerful and secure way to expose internal or local applications over HTTPS. This approach is ideal for APIs, dashboards, admin panels, and development tools that should remain hidden behind a controlled entry point.

With this configuration, IIS acts as a secure gateway while your application remains simple and isolated.

***

**You have successfully configured an IIS reverse proxy using ARR.**
