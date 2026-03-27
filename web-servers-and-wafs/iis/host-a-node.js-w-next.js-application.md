---
icon: node-js
---

# Host a Node.js /w Next.js Application

## Intro

Running a **Next.js** app on a **Windows Server with IIS** (Internet Information Services) so it's publicly accessible requires a few steps, since IIS is not built to directly run Node.js apps. But you can do it by using a **reverse proxy** to forward IIS requests to your Next.js app running on a local port.

***

## Step 1: Install Node.js on Windows Server

1. <mark style="color:green;">Go to</mark> [<mark style="color:green;">https://nodejs.org/</mark>](https://nodejs.org/) <mark style="color:green;">and download the LTS version.</mark>
2.  <mark style="color:green;">Install it and verify with:</mark>

    ```bash
    node -v
    npm -v
    ```

***

## Step 2: Copy or Build Your Next.js App

* <mark style="color:green;">Copy your app to the Windows Server.</mark>
* <mark style="color:green;">Navigate to the app folder and run:</mark>

```bash
npm install
npm run build
npm run start
```

* <mark style="color:green;">This starts your app, likely on</mark> <mark style="color:green;"></mark><mark style="color:green;">`http://localhost:3000`</mark><mark style="color:green;">.</mark>

{% hint style="warning" %}
If needed, you can configure it to use a different port (e.g., 5000) by setting the `PORT` environment variable:
{% endhint %}

```bash
set PORT=5000 && npm run start
```

***

## Step 3: Set Up IIS as a Reverse Proxy

<mark style="color:green;">To make the app accessible via IIS:</mark>

### **Install URL Rewrite & ARR (Application Request Routing)**

* <mark style="color:green;">**URL Rewrite Module**</mark>
* <mark style="color:green;">**ARR**</mark>

### Enable Proxy in ARR

* <mark style="color:green;">Open IIS Manager</mark>
* <mark style="color:green;">Click on the server name (root node)</mark>
* <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Application Request Routing Cache**</mark>
* <mark style="color:green;">On the right-hand side, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Server Proxy Settings"**</mark>
* <mark style="color:green;">Check</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Enable proxy"**</mark> <mark style="color:green;"></mark><mark style="color:green;">and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Apply**</mark>

### Create a Website in IIS

* <mark style="color:green;">Point the site root to any folder (even if empty—it won’t serve files directly).</mark>
* <mark style="color:green;">Assign a host name (e.g.,</mark> <mark style="color:green;"></mark><mark style="color:green;">`myapp.mydomain.com`</mark><mark style="color:green;">) or use a port binding.</mark>

### Add URL Rewrite Rule

* <mark style="color:green;">Select the website in IIS</mark>
* <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**URL Rewrite**</mark>
* <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Add Rules"**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Reverse Proxy"**</mark>
* <mark style="color:green;">Set the destination as:</mark>

```
http://localhost:3000
```

{% hint style="warning" %}
(or whatever port your Next.js app is running on)
{% endhint %}

***

## Step 4: Make Sure the App Is Running Continuously

<mark style="color:green;">IIS won’t run the Node app directly, so use one of these tools:</mark>

* <mark style="color:orange;">**PM2**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">(recommended for production):</mark>

```bash
npm install pm2 -g
pm2 start npm --name "nextjs-app" -- run start
pm2 save
pm2 startup
```

* <mark style="color:orange;">**NSSM**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">(Non-Sucking Service Manager) to run it as a Windows Service</mark>

***

## Step 5: Test Public Access

* <mark style="color:green;">Make sure your domain (e.g.,</mark> <mark style="color:green;"></mark><mark style="color:green;">`myapp.mydomain.com`</mark><mark style="color:green;">) points to your Windows server’s IP.</mark>
* <mark style="color:green;">Open a browser and visit the domain — you should see your Next.js app!</mark>

***

{% hint style="warning" %}
#### Extra Notes

* Make sure ports 80/443 are open in the firewall.
* You can also configure HTTPS using a certificate in IIS.
{% endhint %}



***

## REFERENCES

* [https://medium.com/@adarsh-d/deploy-node-js-application-on-iis-9703d5dfcaca](https://medium.com/@adarsh-d/deploy-node-js-application-on-iis-9703d5dfcaca)
* [https://medium.com/@unlikelycreator/enable-iis-and-host-nodejs-application-on-iis-a27058e1ca79](https://medium.com/@unlikelycreator/enable-iis-and-host-nodejs-application-on-iis-a27058e1ca79)
* [https://github.com/tjanczuk/iisnode](https://github.com/tjanczuk/iisnode)
* [https://dev.to/petereysermans/hosting-a-node-js-application-on-windows-with-iis-as-reverse-proxy-397b](https://dev.to/petereysermans/hosting-a-node-js-application-on-windows-with-iis-as-reverse-proxy-397b)
* [https://www.skillsoft.com/course/running-nodejs-applications-in-iis-92fa6817-14c0-11e7-92d9-0242c0a80b07](https://www.skillsoft.com/course/running-nodejs-applications-in-iis-92fa6817-14c0-11e7-92d9-0242c0a80b07)
