---
icon: cpanel
---

# cPanel: Generate CSR

#### Generating a CSR using cPanel

please follow the instructions below to generate the CSR code in your cPanel account:

1. Log into your cPanel account
2. Locate and click "SSL/TLS" in the Security section:\
   \

3.

    ![](https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/csr_1.png)
4. Click on _Generate, view, or delete SSL certificate signing requests_ under the Certificate Signing Requests (CSR) menu:\

5.

    ![](https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/csr_2.png)
6. On the next page, locate the option titled Generate a New Certificate Signing Request (CSR). The "Generate a New 2048-bit key" option is pre-selected by default, and this means that a completely new Private Key will be generated.\
   If the Private key was generated separately within this cPanel account, you can select it from the drop-down.\
   \

7. Enter the following information for the CSR code that will be submitted to the Certificate Authority. Please use only [alphanumeric](http://en.wikipedia.org/wiki/Alphanumeric) characters when filling in the details.
8. \
   Domains: Enter the fully qualified domain name on which the SSL will be activated (common name). The common name for all Wildcard certificates should be represented with an asterisk in front of the domain (\*.example.com). To create your CSR code for multiple domains, enter each domain in a new line.\
   City: Provide the complete name of your city or locality. Do not use abbreviations.\
   State: Provide the complete name of your state or region.\
   Country: Select your country from the drop-down list.\
   Company: Provide the officially registered name for your business. For Organization and Extended Validation certificates, Certificate Authorities will be verifying the submitted organization. For Domain Validation SSLs, this field will not be listed on the issued certificate (you can use "NA" for Organization when issuing a Domain Validation certificate if you do not have an organization registered).\
   Company Division: Provide the name of a division or department within the organization indicated above. For Domain Validation certificates, you can enter "NA".\
   E-mail: Enter your e-mail address. The e-mail used for CSR generation will not be used for domain control validation or for reception of the issued certificate. It can be left blank.\
   Passphrase: It was designed to be another verification parameter to confirm the identity of a certificate requester. At the moment, this field is considered obsolete. Feel free to leave it empty.\
   Description: Add some keywords to easily locate a particular CSR in the list.\
   \

9.

    ![](https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/csr__3.png)
10. Click on the Generate button.\
    \

11. The next page will show the newly generated CSR code. You can now use the Encoded Certificate Signing Request to [activate](https://www.namecheap.com/support/knowledgebase/article.aspx/794/67/how-do-i-activate-an-ssl-certificate) the certificate purchased with Namecheap or any other certificate provider. Please include _-----BEGIN CERTIFICATE REQUEST-----_ and _-----END CERTIFICATE REQUEST-----_ when submitting the CSR code for SSL activation.\
    \

12.

    ![](https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/csr_ready.png)

\
