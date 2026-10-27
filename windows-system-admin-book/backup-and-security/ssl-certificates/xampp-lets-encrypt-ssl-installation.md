---
icon: windows
---

# XAMPP - Let's Encrypt SSL Installation

{% hint style="warning" %}
If you currently run Apache (or the other distributions such as XAMPP and Wamp Server) on Windows which is hosted as a virtual machine in some cloud based server, then this guide is for you.
{% endhint %}

## Prerequisites

* <mark style="color:green;">**XAMPP installed**</mark> <mark style="color:green;"></mark><mark style="color:green;">on your Windows Server.</mark>
* <mark style="color:green;">A</mark> <mark style="color:green;"></mark><mark style="color:green;">**registered domain**</mark> <mark style="color:green;"></mark><mark style="color:green;">pointing to your server's IP address (via DNS A record).</mark>
* <mark style="color:green;">Port</mark> <mark style="color:green;"></mark><mark style="color:green;">**80 (HTTP)**</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">**443 (HTTPS)**</mark> <mark style="color:green;"></mark><mark style="color:green;">open in firewall.</mark>

## Step-by-Step Guide

### Download win-acme

* <mark style="color:green;">Go to</mark> [<mark style="color:green;">https://www.win-acme.com/</mark>](https://www.win-acme.com/)
* <mark style="color:green;">Download the latest version (x64 recommended).</mark>
* <mark style="color:green;">Extract it to a folder, e.g.,</mark> <mark style="color:green;"></mark><mark style="color:green;">`C:\win-acme\`</mark>&#x20;

{% hint style="warning" %}
Before we go on, Create a new folder called “apache-certs” on your C-drive.

\
You need to make sure your webroot is allowing `.well-known/acme-challenge/` to be publicly accessible.\
If this folder is not available under the website directory then you need to create it and then win-acme will automatically create the required txt files for verification.
{% endhint %}

### Generate the SSL Certificate

* <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Command Prompt as Administrator**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Navigate to the win-acme folder:</mark>

1. <mark style="color:orange;">“M” - Create new certificate</mark>
2. <mark style="color:orange;">“1” - Manually input host names</mark>
3. <mark style="color:orange;">“Enter your domain name here”</mark>
4. <mark style="color:orange;">“Enter” - Just click enter to confirm again</mark>
5. <mark style="color:orange;">“5” - Save file on local or network path</mark>
6. <mark style="color:orange;">“C:\xampp\htdocs” - Your site root folder (C:\xampp\htdocs\\\<domain name>)</mark>
7. <mark style="color:orange;">“y” - Default config settings</mark>
8. <mark style="color:orange;">“2” - Choosing CSR</mark>
9. <mark style="color:orange;">“3”- Write .pem files</mark>
10. <mark style="color:orange;">“C:\apache-certs” - The reason we created the folder.</mark>
11. <mark style="color:orange;">“3” - No extra steps</mark>
12. <mark style="color:orange;">“1” - No extra steps</mark>
13. <mark style="color:orange;">“Enter e-mail” - Enter your email adres</mark>
14. <mark style="color:orange;">“Y” - Opens some docs</mark>
15. <mark style="color:orange;">“Y” - Ofcourse we agree</mark>

{% hint style="success" %}
Your SSL Files should now be created and placed in your “C:\apache-certs” folder and you see something like this on your console:
{% endhint %}

{% hint style="danger" %}
**The hard part is now over.**

Now we need to configure Apache to be able to use the SSL-Files.\
Before we start this please make a new folder on your C:\ Drive named “Logs”.
{% endhint %}

### **Configuring Apache**

{% hint style="warning" %}
To use certificates obtained with the help of WACS with the Apache 2.4 server, you need to make settings in `Apache\conf\extra\httpd-vhosts.conf` file; you could also make these changes in the `\Apache24\conf\extra\httpd-ssl.conf` file as well instead if you so wish.
{% endhint %}

#### Updating C:\xampp\apache\conf\extra\httpd-ssl.conf

{% hint style="success" %}
Replace the certificate file paths with your actual file locations.
{% endhint %}

```
<VirtualHost *:443>
    ServerName urc.ac.in
    DocumentRoot "C:/xampp/htdocs/<domain name>"

    SSLEngine on
    SSLCertificateFile "C:/ProgramData/win-acme/.../cert.pem"
    SSLCertificateKeyFile "C:/ProgramData/win-acme/.../privkey.pem"
    SSLCertificateChainFile "C:/ProgramData/win-acme/.../fullchain.pem"

    <Directory "C:/xampp/htdocs/<domain name>">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

{% hint style="warning" %}
#### Step 4: Enable SSL in Apache

Open `C:\xampp\apache\conf\httpd.conf` and make sure these lines are **uncommented**:

```apache
LoadModule ssl_module modules/mod_ssl.so
Include conf/extra/httpd-ssl.conf -> Not required, Disable if error occurs
```
{% endhint %}

#### Configure C:\xampp\apache\conf\extra\httpd-vhosts.conf

```
<VirtualHost *:443>
    ServerName urc.ac.in
    DocumentRoot "C:/xampp/htdocs/<domain name>"

    SSLEngine on
    SSLCertificateFile "C:/ProgramData/win-acme/.../cert.pem"
    SSLCertificateKeyFile "C:/ProgramData/win-acme/.../privkey.pem"
    SSLCertificateChainFile "C:/ProgramData/win-acme/.../fullchain.pem"

    <Directory "C:/xampp/htdocs/<domain name>">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

{% hint style="warning" %}
#### Enable Virtual Hosts in Apache

In `httpd.conf` (main Apache config), make sure this line is **uncommented**:

```apache
Include conf/extra/httpd-vhosts.conf

Listen 0.0.0.0 443
Or
Listen <Public IP> 443
```
{% endhint %}

### Load the Required Apache Module

Open this file:

```
C:\xampp\apache\conf\httpd.conf
```

Find this line (or similar):

```apache
#LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
```

**Uncomment it** by removing the `#`:

```apache
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
```

{% hint style="warning" %}
#### Make Sure These Modules Are Enabled Too

In `httpd.conf`, make sure these are also uncommented:

```apache
LoadModule ssl_module modules/mod_ssl.so
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
Include conf/extra/httpd-vhosts.conf
```
{% endhint %}

### Force Redirect HTTP → HTTPS

Add this to your `.htaccess` file in:

```
C:\xampp\htdocs\<domain>\.htaccess
```

```apache
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

## **Opening the Port in Windows Firewall Security.**

Search for Windows Firewall Security for Windows and Open it.

Click on Inbound Rule, and follow the below steps:

* <mark style="color:green;">Click on New Rule from the right panel</mark>
* <mark style="color:green;">Select Port, Hit Next</mark>
* <mark style="color:green;">Click on TCP and Give Specific Port number as 443,80</mark>
* <mark style="color:green;">Allow all connection</mark>
* <mark style="color:green;">Check on Domain, private and Public</mark>
* <mark style="color:green;">Give the respective name and Click Finish</mark>
* <mark style="color:green;">And then, repeat the same steps for Outbound Rules and Finish</mark>

## Troubleshooting Commands

```
Check Errors: C:\xampp\apache\logs\error.log

netstat -an | findstr :443

You should now see something like:
TCP    0.0.0.0:443   0.0.0.0:0   LISTENING
```



***

## REFERENCES

* [https://community.letsencrypt.org/t/setting-up-ssl-on-xampp/97512/8](https://community.letsencrypt.org/t/setting-up-ssl-on-xampp/97512/8)
