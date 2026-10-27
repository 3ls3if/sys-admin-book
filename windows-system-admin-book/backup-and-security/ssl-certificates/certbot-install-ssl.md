---
icon: windows
---

# Certbot - Install SSL

## Install with Certbot

1. Download the latest Certbot [installer for Windows from the official website.](https://dl.eff.org/certbot-beta-installer-win32.exe)
2. Open the installer, and follow the installation wizard steps.
3. Open the Windows Start Menu and launch **Windows PowerShell** as an Administrator.
4.  Enter the following commands to request a free Let's Encrypt SSL certificate. Replace `example.com` with your actual domain.

    ```
     PS> certbot -d example.com -m admin@example.com --agree-tos --webroot
    ```

    Enter the path to your domain files directory created earlier. For example, `C:\inetpub\example.com`.

    Certbot stores your SSL certificate in the installation directory's `live` folder and automatically renews it before the certificate expiry date. Certbot generates and saves SSL certificates as `.pem` files. However, the IIS certificate store requires the `.pfx` format. Convert your Certbot certificates using OpenSSL and bind them to your domain, as explained in the following steps.
5. Download the latest OpenSSL installation file from an [official download link.](https://slproweb.com/products/Win32OpenSSL.html)
6. Run the installer and follow the wizard steps to install OpenSSL.
7.  Open **Windows PowerShell** and switch to the OpenSSL program directory. For example, if installed in program files, run the following command.

    ```
     PS> cd "C:\Program Files\OpenSSL-Win64\bin"
    ```
8.  Enter the following commands to convert your Certbot certificates to the `.pfx` format.

    ```
     PS> .\openssl.exe pkcs12 -export -out C:\Certbot\live\example.com\certificate.pfx -inkey C:\Certbot\live\example.com\privkey.pem -in C:\Certbot\live\example.com\fullchain.pem
    ```
9. Enter a strong password to secure your certificate file.
10. Open the IIS Manager.
11. Navigate to your Windows server hostname under the **Connections** navigation bar.
12. Double click to open**Server Certificates**.



    <figure><img src="https://docs.vultr.com/public/doc-assets/1359/1a260a94f7de5d81.png" alt=""><figcaption></figcaption></figure>
13. Click **Import** from the right **Actions** navigation bar.
14. Enter the path to your `.pfx` certificate file, or click `...` to browse the directory.
15. Enter the certificate file password created earlier.
16. Click **OK** to import your SSL certificate file.
17. Navigate to your domain under the **Sites** subgroup on the left navigation bar.
18. Find and click **Bindings** under **Edit Site** on the right navigation bar.
19. In the open **Site Bindings** window, click **Add**.
20. Toggle **Type:** and select `https` from the drop-down options.
21. Keep `443` as the **Port:**, and enter your domain in the **Hostname:** field.
22. Check and activate **Require Server Name Indication**.
23. Select your imported certificate from the **SSL Certificate:** drop-down list.



    <figure><img src="https://docs.vultr.com/public/doc-assets/1359/53c0656092017aa5.png" alt=""><figcaption></figcaption></figure>
24. Click **OK** to save changes and close the **Site Bindings** window.

You have successfully installed your SSL certificate, visit the domain in a web browser to confirm the access is secure. For example, navigate to `https://example.com` and verify the certificate is correct.
