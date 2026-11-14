---
icon: ubuntu
---

# Configure NGINX as a Reverse Proxy and Load Balancer with Windows IIS Servers

## Configure NGINX as a Reverse Proxy and Load Balancer with Windows IIS Servers

### 1. Introduction

NGINX is a high-performance web server that can also function as a reverse proxy and load balancer. It distributes incoming client requests across multiple backend servers, helping improve application availability, scalability, and resource utilization.

In this lab, we will configure an Ubuntu Server running NGINX as a reverse proxy and load balancer for two Windows Server IIS web servers.

The NGINX server will receive HTTP requests from a Windows 10 client and distribute them between the two IIS backend servers using the Round Robin load-balancing algorithm.

This implementation will also demonstrate backend failure testing, request distribution, service monitoring, and basic troubleshooting.

#### Lab Objectives

* Install and configure NGINX on Ubuntu Server.
* Configure NGINX as a reverse proxy.
* Create an upstream backend server pool.
* Implement Round Robin load balancing.
* Forward HTTP requests to multiple IIS servers.
* Configure passive backend failure detection.
* Test load balancing and backend availability.
* Monitor NGINX access and error logs.

***

### 2. Lab Architecture

The lab consists of four virtual machines operating within the same network.

#### Network Architecture

<figure><img src="../.gitbook/assets/NGINX Load Balancer Network Architecture.png" alt=""><figcaption></figcaption></figure>

| Component     | Operating System | IP Address   | Service     |
| ------------- | ---------------- | ------------ | ----------- |
| Client        | Windows 10       | 10.20.20.100 | HTTP Client |
| Load Balancer | Ubuntu Server    | 10.20.20.10  | NGINX       |
| Backend 1     | Windows Server   | 10.20.20.11  | IIS         |
| Backend 2     | Windows Server   | 10.20.20.12  | IIS         |

#### Traffic Flow

1. The Windows 10 client sends an HTTP request to 10.20.20.10.
2. NGINX receives the request on TCP port 80.
3. NGINX selects a backend server from the configured upstream pool.
4. The selected IIS server processes the request.
5. The response travels back through NGINX to the client.

**Network Configuration**

* Frontend: HTTP – TCP 80
* Backend: HTTP – TCP 80
* Load Balancing Algorithm: Round Robin
* Backend Pool: IIS01 and IIS02

***

### 3. Prerequisites

Before starting the configuration, ensure that the following requirements are met:

* Ubuntu Server is installed and configured.
* Two Windows Server virtual machines are available.
* IIS is installed and running on both Windows servers.
* All virtual machines are connected to the same network.
* Each machine has a static IP address.
* TCP port 80 is allowed through the relevant firewalls.
* Administrative access is available on all servers.

#### Verify Network Connectivity

From Ubuntu Server, test connectivity to both IIS servers:

```
ping 10.20.20.11
ping 10.20.20.12
```

Test HTTP connectivity:

```
curl http://10.20.20.11
curl http://10.20.20.12
```

Both commands should return valid HTTP content.

***

### 4. Configure IIS Backend Servers

Before configuring NGINX, we need to prepare both IIS servers with different web pages.

This will help identify which backend server is processing each request.

#### Step 4.1: Configure IIS01

Log in to the first Windows Server (10.20.20.11).

Open PowerShell as Administrator and execute:

```
Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value @"
<html>
<head>
<title>IIS01 Backend</title>
</head>
<body>
<h1>Welcome to IIS01</h1>
<p>Backend Server: 10.20.20.11</p>
</body>
</html>
"@
```

#### Step 4.2: Configure IIS02

Log in to the second Windows Server (10.20.20.12).

Execute:

```
Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value @"
<html>
<head>
<title>IIS02 Backend</title>
</head>
<body>
<h1>Welcome to IIS02</h1>
<p>Backend Server: 10.20.20.12</p>
</body>
</html>
"@
```

#### Step 4.3: Allow HTTP Traffic

Execute the following command on both IIS servers:

```
New-NetFirewallRule `
    -DisplayName "Allow HTTP from NGINX" `
    -Direction Inbound `
    -Protocol TCP `
    -LocalPort 80 `
    -Action Allow `
    -RemoteAddress 10.20.20.10
```

This firewall rule permits HTTP connections from the NGINX load balancer.

#### Step 4.4: Verify IIS Websites

From Ubuntu Server, execute:

```
curl http://10.20.20.11
curl http://10.20.20.12
```

Verify that IIS01 and IIS02 return their respective web pages.

***

### 5. Install NGINX on Ubuntu Server

Log in to the Ubuntu Server (10.20.20.10).

#### Step 5.1: Update Package Repository

```
sudo apt update
```

#### Step 5.2: Install NGINX

```
sudo apt install nginx -y
```

#### Step 5.3: Enable and Start NGINX

```
sudo systemctl enable nginx
sudo systemctl start nginx
```

#### Step 5.4: Verify NGINX Service

```
sudo systemctl status nginx
```

Check the installed version:

```
nginx -v
```

#### Step 5.5: Allow HTTP Traffic

If UFW is enabled, allow HTTP traffic:

```
sudo ufw allow 80/tcp
```

#### Step 5.6: Test Default NGINX Website

Execute:

```
curl http://localhost
```

You should receive the default NGINX welcome page.

NGINX is now installed and running.

***

### 6. Configure NGINX as a Load Balancer

NGINX uses the `upstream` directive to define a group of backend servers.

We will create an upstream group containing IIS01 and IIS02 and configure NGINX to distribute incoming requests between them.

#### Step 6.1: Create Load Balancer Configuration

Create a separate configuration file:

```
sudo nano /etc/nginx/conf.d/load-balancer.conf
```

#### Step 6.2: Configure Backend Server Pool

Add the following configuration:

```
# Define IIS backend servers
upstream iis_backend {

    # Backend Server 1
    server 10.20.20.11:80 max_fails=2 fail_timeout=10s;

    # Backend Server 2
    server 10.20.20.12:80 max_fails=2 fail_timeout=10s;

}
```

#### Configuration Explanation

| Directive         | Description                                           |
| ----------------- | ----------------------------------------------------- |
| upstream          | Defines a group of backend servers.                   |
| iis\_backend      | Name assigned to the backend server group.            |
| server            | Specifies an individual backend server.               |
| max\_fails=2      | Failure threshold for passive failure detection.      |
| fail\_timeout=10s | Failure tracking and temporary unavailability period. |

By default, NGINX uses Round Robin when multiple backend servers are defined without specifying another load-balancing method.

#### Step 6.3: Configure NGINX Frontend

Add the following server block below the upstream configuration:

```
server {

    listen 80;

    server_name _;

    location / {

        proxy_pass http://iis_backend;

        # Forward original request information
        proxy_set_header Host $host;

        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header X-Forwarded-For
            $proxy_add_x_forwarded_for;

        proxy_set_header X-Forwarded-Proto $scheme;

        # Proxy timeout settings
        proxy_connect_timeout 5s;

        proxy_send_timeout 30s;

        proxy_read_timeout 30s;

        # Retry another backend for eligible failures
        proxy_next_upstream error timeout
            http_500 http_502 http_503 http_504;

    }

}
```

#### Configuration Explanation

| Directive               | Purpose                                                         |
| ----------------------- | --------------------------------------------------------------- |
| listen 80               | Accepts incoming HTTP requests on port 80.                      |
| server\_name \_         | Acts as a catch-all server name for this server block.          |
| location /              | Processes requests for the root URL and its paths.              |
| proxy\_pass             | Forwards requests to the upstream backend group.                |
| proxy\_set\_header      | Passes original request and client information.                 |
| proxy\_connect\_timeout | Defines the backend connection timeout.                         |
| proxy\_read\_timeout    | Defines the timeout between successive backend reads.           |
| proxy\_send\_timeout    | Defines the timeout between successive backend writes.          |
| proxy\_next\_upstream   | Defines conditions under which NGINX may retry another backend. |

***

### 7. Validate and Apply NGINX Configuration

After completing the configuration, validate the NGINX syntax.

#### Step 7.1: Test Configuration

```
sudo nginx -t
```

Expected output:

```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok

nginx: configuration file /etc/nginx/nginx.conf test is successful
```

#### Step 7.2: Reload NGINX

```
sudo systemctl reload nginx
```

#### Step 7.3: Verify NGINX Status

```
sudo systemctl status nginx
```

Check whether NGINX is listening on port 80:

```
sudo ss -tulpn | grep :80
```

The NGINX service should now be accepting incoming HTTP requests.

***

### 8. Test Load Balancing from Windows 10

Now that NGINX is configured, we can test request distribution from the Windows 10 client.

Client IP: 10.20.20.100

Load Balancer IP: 10.20.20.10

#### Step 8.1: Access Load Balancer

Open a browser on Windows 10 and navigate to:

```
http://10.20.20.10
```

Alternatively, execute:

```
curl http://10.20.20.10
```

#### Step 8.2: Generate Multiple HTTP Requests

Execute the following command in Windows Command Prompt:

```
for /L %i in (1,1,10) do @curl -s http://10.20.20.10
```

You should receive responses from both backend servers.

#### Expected Results

| Request | Expected Backend |
| ------- | ---------------- |
| 1       | IIS01            |
| 2       | IIS02            |
| 3       | IIS01            |
| 4       | IIS02            |
| 5       | IIS01            |
| 6       | IIS02            |
| 7       | IIS01            |
| 8       | IIS02            |
| 9       | IIS01            |
| 10      | IIS02            |

The sequence above illustrates the expected Round Robin distribution when requests are processed sequentially under normal conditions.

Actual request distribution can vary with concurrency, retries, and backend failures.

***

### 9. Test Backend Failure and Failover

An important part of load balancing is maintaining service availability when one backend server becomes unavailable.

We will simulate an IIS01 failure and verify whether NGINX continues forwarding requests to IIS02.

#### Step 9.1: Stop IIS01 Website Service

Log in to IIS01 (10.20.20.11).

Execute:

```
Stop-Service W3SVC
```

This stops the IIS World Wide Web Publishing Service.

#### Step 9.2: Generate Requests from Windows 10

On the Windows 10 client, execute:

```
for /L %i in (1,1,10) do @curl -s http://10.20.20.10
```

Observe the responses.

NGINX should continue serving requests through IIS02 after detecting eligible backend failures.

#### Step 9.3: Restore IIS01

Log in to IIS01 and execute:

```
Start-Service W3SVC
```

Generate additional requests to verify that IIS01 can receive traffic again.

#### Understanding Passive Health Checks

The open-source NGINX implementation used in this lab supports passive health monitoring.

It observes failures during actual client requests.

The following directives control failure tracking:

```
server 10.20.20.11:80 max_fails=2 fail_timeout=10s;
```

* `max_fails=2`: Defines the number of unsuccessful attempts within the failure tracking period.
* `fail_timeout=10s`: Defines the failure observation period and the time a server is considered unavailable after reaching the threshold.

**Important:** This is not an active health check. NGINX does not continuously send independent health probes to the IIS servers using this configuration. Active periodic health checks are available in NGINX Plus or through suitable third-party solutions.

***

### 10. NGINX Monitoring and Log Management

NGINX maintains access and error logs that help administrators troubleshoot connectivity and backend issues.

#### Access Logs

Location:

```
/var/log/nginx/access.log
```

View live access logs:

```
sudo tail -f /var/log/nginx/access.log
```

#### Error Logs

Location:

```
/var/log/nginx/error.log
```

View live error logs:

```
sudo tail -f /var/log/nginx/error.log
```

#### Useful NGINX Administration Commands

| Task                           | Command                                  |
| ------------------------------ | ---------------------------------------- |
| Check service status           | `sudo systemctl status nginx`            |
| Start NGINX                    | `sudo systemctl start nginx`             |
| Stop NGINX                     | `sudo systemctl stop nginx`              |
| Restart NGINX                  | `sudo systemctl restart nginx`           |
| Reload configuration           | `sudo systemctl reload nginx`            |
| Validate configuration         | `sudo nginx -t`                          |
| View NGINX version             | `nginx -v`                               |
| Display complete configuration | `sudo nginx -T`                          |
| Check listening ports          | `sudo ss -tulpn`                         |
| Monitor access logs            | `sudo tail -f /var/log/nginx/access.log` |
| Monitor error logs             | `sudo tail -f /var/log/nginx/error.log`  |

***

### 11. Troubleshooting

The following table covers common issues that may occur during the implementation.

| Issue                                   | Possible Cause                                | Troubleshooting                                          |
| --------------------------------------- | --------------------------------------------- | -------------------------------------------------------- |
| NGINX service fails to start            | Invalid configuration syntax                  | Run `sudo nginx -t`.                                     |
| Client cannot access NGINX              | Firewall or network issue                     | Check TCP port 80 and connectivity.                      |
| NGINX returns 502 Bad Gateway           | Backend IIS unavailable                       | Test backend using curl.                                 |
| Only one IIS server receives requests   | Other backend unavailable or failing          | Check IIS service and network connectivity.              |
| NGINX configuration changes not applied | Configuration not reloaded                    | Run `sudo systemctl reload nginx`.                       |
| Default NGINX page appears              | Default server block may be taking precedence | Inspect enabled site configurations and `sudo nginx -T`. |
| HTTP connection times out               | Firewall or routing issue                     | Verify firewall rules and network routes.                |

#### Useful Diagnostic Commands

Test IIS01:

```
curl -v http://10.20.20.11
```

Test IIS02:

```
curl -v http://10.20.20.12
```

Test NGINX frontend:

```
curl -v http://10.20.20.10
```

Inspect configuration:

```
sudo nginx -T
```

***

### 12. Final Lab Verification Checklist

Use this checklist to confirm that the implementation is complete.

* Ubuntu Server is configured with static IP 10.20.20.10.
* NGINX is installed and running.
* IIS01 is configured with IP 10.20.20.11.
* IIS02 is configured with IP 10.20.20.12.
* Both IIS websites are accessible directly.
* Backend pool is configured in NGINX.
* Round Robin load balancing is working.
* Windows 10 can access the NGINX frontend.
* Both backend servers receive requests.
* Backend failure testing is completed.
* NGINX logs are accessible.
* NGINX configuration passes validation.

***

### 13. Conclusion

In this lab, we successfully implemented NGINX as a reverse proxy and load balancer for two Windows IIS backend servers.

The Ubuntu Server acts as the central entry point for incoming HTTP traffic and distributes requests across the configured IIS backend pool using Round Robin load balancing.

We also explored passive failure detection, backend failover behavior, configuration validation, and log monitoring.

This architecture provides a practical foundation for understanding reverse proxies, web server load balancing, and high-availability web infrastructure.

#### Recommended Next Steps

After completing this basic implementation, the lab can be extended with the following technologies and configurations:

1. **Least Connections:** Configure NGINX to distribute traffic based on active backend connections.
2. **SSL/TLS Termination:** Configure HTTPS on NGINX and forward HTTP traffic to IIS.
3. **Active Health Checks:** Explore NGINX Plus or alternative health-monitoring solutions.
4. **Cloudflare CDN:** Integrate Cloudflare for DNS proxying, caching, and CDN functionality.
5. **OPNsense Firewall:** Introduce network segmentation and firewall policies.
6. **WAF Integration:** Explore web application firewall protection.
7. **High Availability:** Deploy a second NGINX load balancer and investigate Keepalived with a virtual IP.

**Lab Outcome:** A working NGINX reverse proxy and Round Robin load-balancing environment using Ubuntu Server and two Windows IIS backend servers.





***

## REFERENCES

* [https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/](https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/)
