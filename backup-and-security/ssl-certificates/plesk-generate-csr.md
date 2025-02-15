---
icon: windows
---

# Plesk: Generate CSR

**Generating a Certificate Signing Request (CSR)**

To watch a video that demonstrates the following procedure, please click below:

{% embed url="https://youtu.be/UAPKrtjTNs0" %}

**To generate a Certificate Signing Request for your site, follow these steps:**

1. Log in to Plesk.If you do not know how to log in to your Plesk account, please see [this article](https://www.a2hosting.com/kb/a2-hosting-products/windows-hosting/logging-in-and-out-of-plesk).
2.  In the left sidebar, click Websites & Domains:

    ![Plesk - Sidebar - Websites and Domains](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-sidebar-websites-and-domains.png)
3.  Click SSL/TLS Certificates:

    ![Plesk - SSL Certificates icon](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-ssl-certificates-icon.png)
4.  Click Add SSL/TLS Certificate:\


    ![Plesk - Add SSL Certificate button](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-add-ssl-certificate.png)
5. On the Add SSL/TLS Certificate page, complete the fields in the request form, and then click Request.\


{% hint style="success" %}
Most of the fields in the request form are self-explanatory, but a few fields require special attention:\


* **Certificate name:** This is how the certificate is displayed in Plesk. To make it easy to identify later, you should use the domain name.
* **Domain name:** If you want your SSL certificate to protect the domain with and without the _www_ prefix, you must type _www_, for example, _www.example.com_.
  * A certificate for _www.example.com_ protects both _example.com_ and _www.example.com_.
  * A certificate for _example.com_ only protects _example.com_.
* **Email:** Plesk sends the CSR to this e-mail address.
{% endhint %}



1.  The SSL Certificates page for the domain appears. Click the certificate name:\


    ![Plesk - Certificate name](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-certificate-name.png)
2.  Scroll down to the CSR section, and then copy all of the text, including the **BEGIN CERTIFICATE REQUEST** and **END CERTIFICATE REQUEST** headers:\


    ![Plesk - CSR text](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-csr-text.png)
