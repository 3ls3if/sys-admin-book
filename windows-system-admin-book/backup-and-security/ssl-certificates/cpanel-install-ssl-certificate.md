---
icon: cpanel
---

# cPanel: Install SSL Certificate

### Installation Instructions <a href="#installation-instructions4" id="installation-instructions4"></a>

#### 1. Log in to cPanel <a href="#id-1-log-in-to-cpanel5" id="id-1-log-in-to-cpanel5"></a>

The first step is to login to your **cPanel account**, this can typically be accessed by going to **https://domain.com:2083**

_**Note:** You may encounter an error message “Your connection is not private” or something similar when attempting to visit your cPanel login page. This is caused due to your login page using a self-signed certificate by default. Please disregard this and proceed past the error message._

After navigating to your cPanel login page, enter your Username/Password and click **Log in.**

<figure><img src="https://www.thesslstore.com/knowledgebase/wp-content/uploads/2017/03/installation-cpanel-step3.png" alt=""><figcaption></figcaption></figure>

Your **cPanel Homepage** should look like this:

![cPanel Step4](https://www.thesslstore.com/knowledgebase/wp-content/uploads/2017/03/installation-cpanel-step4.png)

_**Note:** Older versions such as X3 Theme-Classic may not look like the image above, but should still contain the same concept and category structure._

#### 2. Navigate to the SSL/TLS Manager <a href="#id-2-navigate-to-the-ssl-tls-manager6" id="id-2-navigate-to-the-ssl-tls-manager6"></a>

You can access your **SSL/TLS Manager** page by scrolling down to the **Security** section and selecting the **SSL/TLS** button.

<figure><img src="https://www.thesslstore.com/knowledgebase/wp-content/uploads/2017/03/installation-cpanel-step5.png" alt=""><figcaption></figcaption></figure>

_**Note:** You can also navigate to the SSL/TLS Manager page by utilizing the Search Feature at the top right of the cPanel home page and searching for “SSL”._&#x20;

#### 3. Select “Manage SSL Sites” <a href="#id-3-select-manage-ssl-sites7" id="id-3-select-manage-ssl-sites7"></a>

Your **SSL/TLS Manager** page will allow you to manage everything related to SSL/TLS configuration for cPanel. The “**Manage SSL Sites”** Hyperlink is located underneath “Install and Manage SSL for your site (HTTPS)” shown below.

![cPanel Step6](https://www.thesslstore.com/knowledgebase/wp-content/uploads/2017/03/installation-cpanel-step6.png)

#### 4. Select your domain <a href="#id-4-select-your-domain8" id="id-4-select-your-domain8"></a>

Change the **Domain** drop-down to the appropriate domain name that you want to install your SSL certificate on.

![cPanel Step8](https://www.thesslstore.com/knowledgebase/wp-content/uploads/2017/03/installation-cpanel-step8.png)

#### 5. Copy and paste your certificate files <a href="#id-5-copy-and-paste-your-certificate-files9" id="id-5-copy-and-paste-your-certificate-files9"></a>

Once you have your domain selected, you just need to copy and paste your individual certificate files into the appropriate text box(s) pictured below.

![cPanel Step9](https://www.thesslstore.com/knowledgebase/wp-content/uploads/2017/03/installation-cpanel-step9.png)

1. **Certificate (CRT)** – This is your server certificate that was issued to your domain(s). _**Note 1:** cPanel should automatically fetch the Certificate (CRT) text if you previously uploaded the server certificate in the “Generate, view, upload or delete SSL certificate” section of your SSL/TLS Manager and selected the correct domain name above in the dropdown. **Note 2:** If you received the certificate in a ZIP file, click “Extract All” and then drag your server certificate into a text editor such as Notepad. This will allow you to copy all text contents needed including “—–BEGIN CERTIFICATE—–” and “END CERTIFICATE—–“._
2. **Private Key (KEY)** – This is your private key that was created during the generation process. _**Note 1:** cPanel should automatically fetch the Private Key (Key) text if you previously created the Certificate Signing Request (CSR) in the “Generate, view, or delete SSL certificate signing requests” section of your SSL/TLS Manager and selected the correct domain name above in the dropdown. **Note 2:** If you made the CSR and private key outside of your cPanel account and failed to save the files, you will have problems proceeding and may need to re-issue the SSL certificate with a newly created key pair._
3. **Certificate Authority Bundle (CABundle)** – This is your intermediate certificates that allow browsers and devices to understand who issued your trusted certificate. _**Note 1:** cPanel should automatically fetch the CA Bundle from a public repository. If not,_ [_download the appropriate CA Bundle for your certificate._](https://www.thesslstore.com/knowledgebase/ssl-support/ca-bundle/) _**Note 2:** If you have multiple intermediate certificates, paste each of them one after another to create the correct certificate chain/path._

#### 6. Click “Install Certificate” <a href="#id-6-click-install-certificate10" id="id-6-click-install-certificate10"></a>

Once you have the correct certificate files in the appropriate text boxes, simply click the blue “Install Certificate” button.

Congratulations! You’ve successfully installed your SSL certificate! To check your work, visit the website in your browser at _https://yourdomain.tld_ and view the certificate/site information to see if HTTPS/SSL is working properly. Remember, you may need to restart your server for changes to take effect.

_**Note 1:** You are not required to “Enable SNI for Mail Services.” Server Name Indication (SNI) should only be used if multiple hostnames are being served over HTTPS from the same IP address. **Note 2:** You or your web host may need to restart the Apache server before the certificate will work._

To check your server’s configurations more thoroughly, use our [SSL Checker Tool](https://www.thesslstore.com/ssltools/ssl-checker.php) or contact our Customer Experience Department for additional assistance.
