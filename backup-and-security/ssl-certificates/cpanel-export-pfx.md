---
icon: linux
---

# cPanel: Export PFX

## Export PFX

{% hint style="success" %}
To export an SSL certificate as a .pfx file from cPanel, you'll need to access the cPanel SSL/TLS Manager, locate the certificate, and then use the "Manage SSL Sites" feature to copy the certificate and private key, saving them as separate files, and then use OpenSSL to combine them into a .pfx file.&#x20;
{% endhint %}

## Steps to Follow:

<mark style="color:red;">**1. Access cPanel and SSL/TLS Manager:**</mark>

* <mark style="color:green;">Log in to your cPanel account.</mark>
* <mark style="color:green;">Navigate to the "SSL/TLS" section under the Security section.</mark>
* <mark style="color:green;">Click on "Manage SSL Sites".</mark>&#x20;

<mark style="color:red;">**2. Locate and Copy Certificate and Private Key:**</mark>

* <mark style="color:green;">Choose the domain for which you want to export the SSL certificate.</mark>
* <mark style="color:green;">Select "Autofill by Domain".</mark>
* <mark style="color:green;">Copy the certificate text and paste it into a text editor (like Notepad).</mark>
* <mark style="color:green;">Save this file with a</mark> <mark style="color:green;"></mark><mark style="color:green;">`.crt`</mark> <mark style="color:green;"></mark><mark style="color:green;">extension (e.g.,</mark> <mark style="color:green;"></mark><mark style="color:green;">`mywebsite.crt`</mark><mark style="color:green;">).</mark>
* <mark style="color:green;">Copy the private key text and paste it into another text editor.</mark>
* <mark style="color:green;">Save this file with a</mark> <mark style="color:green;"></mark><mark style="color:green;">`.key`</mark> <mark style="color:green;"></mark><mark style="color:green;">extension (e.g.,</mark> <mark style="color:green;"></mark><mark style="color:green;">`myprivate.key`</mark><mark style="color:green;">).</mark>&#x20;

<mark style="color:red;">**3. Use OpenSSL to Create the .pfx File:**</mark>

* <mark style="color:green;">Open a terminal or command prompt with root access.</mark>&#x20;
* <mark style="color:green;">Navigate to the directory where you saved the</mark> <mark style="color:green;"></mark><mark style="color:green;">`.crt`</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">`.key`</mark> <mark style="color:green;"></mark><mark style="color:green;">files.</mark>&#x20;
* <mark style="color:green;">Use the following OpenSSL command to create the .pfx file:</mark>&#x20;

```bash
openssl pkcs12 -export -out domain_name.pfx -inkey domain_name.key -in domain_name.crt
```

* <mark style="color:green;">You will be prompted to enter a password for the .pfx file.</mark>&#x20;
* <mark style="color:green;">Confirm the password.</mark>&#x20;

