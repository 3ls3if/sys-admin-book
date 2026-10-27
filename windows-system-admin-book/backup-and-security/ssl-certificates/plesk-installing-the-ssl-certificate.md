---
icon: windows
---

# Plesk: Installing the SSL certificate

**Installing the SSL certificate in Plesk**

After you order and receive your SSL certificate, you are ready to install it in Plesk. To do this, follow these steps:

1. Log in to Plesk.If you do not know how to log in to your Plesk account, please see [this article](https://www.a2hosting.com/kb/a2-hosting-products/windows-hosting/logging-in-and-out-of-plesk).
2.  In the left sidebar, click Websites & Domains:

    ![Plesk - Sidebar - Websites and Domains](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-sidebar-websites-and-domains.png)
3.  Click SSL Certificates:

    ![Plesk - SSL Certificates icon](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-ssl-certificates-icon.png)
4.  The SSL Certificates page for the domain appears. Click the certificate name:<br>

    ![Plesk - Certificate name](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-certificate-name.png)
5.  Scroll down to the Upload the certificate as text section, and then in the Certificate (\*.crt) text box, paste all of the certificate text, including the **BEGIN CERTIFICATE** and **END CERTIFICATE** headers:<br>

    ![Plesk - Upload the certificate as text](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-upload-certificate.png)

    If Plesk does not fill in the CA certificate (\*-ca.crt) text box automatically, you must copy the Intermediate Bundle
6. Click Upload Certificate. Plesk installs the certificate.

**Configuring the domain to use SSL**

After you install the SSL certificate, you must enable SSL support for the domain in Plesk. To do this, follow these steps:

1. Log in to Plesk.If you do not know how to log in to your Plesk account, please see [this article](https://www.a2hosting.com/kb/a2-hosting-products/windows-hosting/logging-in-and-out-of-plesk).
2.  In the left sidebar, click Websites & Domains:

    ![Plesk - Sidebar - Websites and Domains](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-sidebar-websites-and-domains.png)
3.  Click Hosting Settings:

    ![Plesk - Hosting Settings](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-hosting-settings.png)
4.  Under Security, select the SSL support check box:<br>

    ![Plesk - Hosting Settings - Security](https://www.a2hosting.com/images/uploads/knowledgebase_images/kb-plesk-hosting-settings-security.png)
5. In the Certificate list box, select the SSL certificate you installed in the previous procedure.
6. Click OK.

