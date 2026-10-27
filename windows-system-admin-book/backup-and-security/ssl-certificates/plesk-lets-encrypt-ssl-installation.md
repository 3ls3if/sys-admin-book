---
icon: windows
---

# Plesk: Let's Encrypt SSL Installation

## How to install a Let's Encrypt SSL certificate for a domain in Plesk?

{% hint style="success" %}
**Note:** Before securing a domain with a Let's Encrypt certificate, make sure the domain name is resolved to a public IP address of the Plesk server from the Internet. If in doubt, check the domain name availability using [DNS Lookup by MxToolBox](https://mxtoolbox.com/DnsLookup.aspx).
{% endhint %}

1. [Log in to Plesk](https://support.plesk.com/hc/en-us/articles/12377667582743).
2. [Install extensions](https://support.plesk.com/hc/en-us/articles/12377511962007) [SSL It!](https://www.plesk.com/extensions/sslit/) and [Let's Encrypt](https://www.plesk.com/extensions/letsencrypt/).
3. Go to **Domains > example.com > Hosting & DNS >** **Hosting Settings** (or **Hosting**).
4.  Enable the option **SSL/TLS support** if it is disabled and click **OK** or **Apply** at the bottom of the page:

    ![SSL/TLS support enabled](https://support.plesk.com/hc/article_attachments/15934514588439)
5.  Go to **Domains > example.com** and click **SSL/TLS Certificates:**

    ![SSL/TLS Certificates](https://support.plesk.com/hc/article_attachments/15934775219351)
6.  At the bottom of the page, click **Install** in the section **More options > Install a free basic certificate provided by Let's Encrypt**:

    ![Install Let's Encrypt certificate button](https://support.plesk.com/hc/article_attachments/15934775219735)
7.  Select the desired options for the certificate to be issued. We recommend enabling the following options:

    * Secure the domain name
    * Include a "www" subdomain for the domain and each selected alias
    * Secure webmail on this domain
    * Assign the certificate to mail domain

    ![Options for issuing Let's Encrypt certificate](https://support.plesk.com/hc/article_attachments/15934775220119)



{% hint style="success" %}
**Note:** The specified **Email address** will be used to receive important notifications and warnings about the certificate sent by Let's Encrypt. Plesk by default takes the email from the owner of the domain to secure.
{% endhint %}

8. Click **Get it free**.

{% hint style="success" %}
At this stage, a SSL certificate from Let’s Encrypt is generated and automatically assigned in Plesk to secure the domain. The certificate is valid for the next 90 days and will be auto-renewed by the SSL It! extension.
{% endhint %}



***

## REFERENCES

* [https://support.plesk.com/hc/en-us/articles/12377676289815-How-to-install-Let-s-Encrypt-SSL-certificate-for-domain-in-Plesk](https://support.plesk.com/hc/en-us/articles/12377676289815-How-to-install-Let-s-Encrypt-SSL-certificate-for-domain-in-Plesk)

