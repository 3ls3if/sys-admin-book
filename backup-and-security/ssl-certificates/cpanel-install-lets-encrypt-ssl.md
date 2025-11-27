---
icon: cpanel
---

# cPanel: Install Let's Encrypt SSL

#### How to install Let’s Encrypt SSL on your domain <a href="#how-to-install-lets-encrypt-ssl-on-your-domain" id="how-to-install-lets-encrypt-ssl-on-your-domain"></a>

This tutorial assumes you’ve already logged in to [**cPanel.**](https://chemicloud.com/kb/article/how-to-login-into-your-cpanel-or-whm-account/)

**1)** Once you are logged in to cPanel, scroll down the page to the ‘SECURITY’ area. Then click on **SSL/TLS Status** icon.

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

**2)** The next step is to issue a new SSL certificate for the desired domain name. Select one or multiple domains/subdomains, then click ‘**Run AutoSSL**‘. It will take a few minutes for the SSL Certificate to be issued and installed.

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

If you see a green padlock next to the domain, it indicates that a valid SSL Certificate is already in place, preventing the issuance of another one.

If the certificate request involves multiple subdomains, it will automatically include a wildcard (\*.example.tld).

**3)** Once you have installed the **SSL Certificate**, you should redirect visitors to the secure version of your website ( **https://** ). Learn how to [Redirect HTTP Requests to HTTPS ](https://chemicloud.com/kb/article/redirect-http-to-https/)



***

#### How to install a wildcard Let’s Encrypt SSL on your domain <a href="#how-to-install-a-wildcard-lets-encrypt-ssl-on-your-domain" id="how-to-install-a-wildcard-lets-encrypt-ssl-on-your-domain"></a>

1\) First you have to create a wildcard subdomain by going into **cPanel -> Domains.**

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

2\) Create the subdomain by entering **\*.example.tld** (_replace example.tld with your domain name_) in the domain box and clicking ‘**Submit’.**

<figure><img src="../../.gitbook/assets/image (4) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

3\) Return to the main cPanel dashboard and scroll down to the ‘**SECURITY**‘ section. Click on the **SSL/TLS Status** icon. Here, you will see the wildcard subdomain that was created. If the WildCard SSL Certificate was not previously generated and installed by cPanel, it will automatically be done once AutoSSL runs on the entire server, which occurs every 3 hours. Currently, there is no way to manually trigger the WildCard SSL generation.

<figure><img src="../../.gitbook/assets/image (5) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

<br>
