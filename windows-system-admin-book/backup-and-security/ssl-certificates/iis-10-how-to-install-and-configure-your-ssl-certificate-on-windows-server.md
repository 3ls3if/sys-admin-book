---
icon: windows
---

# IIS 10: How to Install and Configure Your SSL Certificate on Windows Server

#### (Single Certificate) How to install your SSL certificate and configure the server to use it

Install SSL Certificate

1. On the server where you created the CSR, save the SSL certificate .cer file (e.g., _your\_domain\_com.cer_) that DigiCert sent to you.
2. In the Windows start menu, type _Internet Information Services (IIS) Manager_ and open it.
3.  In Internet Information Services (IIS) Manager, in the Connections menu tree (left pane), locate and click the server name.

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-1.png)
4. On the server name Home page (center pane), in the IIS section, double-click Server Certificates.
5.  On the Server Certificates page (center pane), in the Actions menu (right pane), click the Complete Certificate Request… link.

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-1.png)
6.  In the Complete Certificate Request wizard, on the Specify Certificate Authority Response page, do the following and then click OK:

    | File name containing the          | Click the … box and browse to and select the .cer file                                                                                                          |
    | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | certificate authority's response: | (e.g., _your\_domain\_com.cer_) that DigiCert sent to you.                                                                                                      |
    |                                   |                                                                                                                                                                 |
    | Friendly name:                    | Type a friendly name for the certificate.                                                                                                                       |
    |                                   | The friendly name is not part of the certificate; instead, it is used to identify the certificate.                                                              |
    |                                   | We recommend that you add DigiCert and the expiration date to the end of your friendly name, for example: yoursite-digicert-(expiration date).                  |
    |                                   | This information helps identify the issuer and expiration date for each certificate. It also helps distinguish multiple certificates with the same domain name. |
    |                                   |                                                                                                                                                                 |
    | Select a certificate store        | In the drop-down list, select Web Hosting.                                                                                                                      |
    | for the new certificate:          |                                                                                                                                                                 |

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-sni-1.png)
7. Now that you've successfully installed your SSL certificate, you need to assign the certificate to the appropriate site.
8. Assign SSL Certificate
9.  In Internet Information Services (IIS) Manager, in the Connections menu tree (left pane), expand the name of the server on which the certificate was installed. Then expand Sites and click the site you want to use the SSL certificate to secure.

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-3.png)
10. On the website Home page, in the Actions menu (right pane), under Edit Site, click the Bindings… link.
11. In the Site Bindings window, click Add.

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-4.png)
12. In the Add Site Bindings window, do the following and then click OK:

    | Type:            | In the drop-down list, select https.                                               |
    | ---------------- | ---------------------------------------------------------------------------------- |
    |                  |                                                                                    |
    | IP address:      | In the drop-down list, select the IP address of the site or select All Unassigned. |
    |                  |                                                                                    |
    | Port:            | Type port _443_. The port over which traffic is secure by SSL is port 443.         |
    |                  |                                                                                    |
    | SSL certificate: | In the drop-down list, select your new SSL certificate (e.g., _yourdomain.com_).   |

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-5.png)
13. Your SSL certificate is now installed, and the website configured to accept secure connections.

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-6.png)



***



#### (Multiple Certificates) How to install your SSL certificates and configure the server to use them using SNI

This instructions explains how to install multiple SSL certificates and assign them using SNI. The process is split into two parts as follows:

* [Installing and Configuring Your First SSL Certificate](https://www.digicert.com/kb/csr-creation-ssl-installation-iis-10.htm#install-first-certificate)
* [Installing and Configuring All Additional Certificates](https://www.digicert.com/kb/csr-creation-ssl-installation-iis-10.htm#install-additional-certificates)

**Install First SSL Certificate**

Do this first set of instructions only once, for the first SSL certificate.

1. On the server where you created the CSR, save the SSL certificate .cer file (e.g., _your\_domain\_com.cer_) that DigiCert sent to you.
2. In the Windows start menu, type _Internet Information Services (IIS) Manager_ and open it.
3.  In Internet Information Services (IIS) Manager, in the Connections menu tree (left pane), locate and click the server name.

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-1.png)
4. On the server name Home page (center pane), in the IIS section, double-click Server Certificates.
5.  On the Server Certificates page (center pane), in the Actions menu (right pane), click the Complete Certificate Request… link.

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-1.png)
6.  In the Complete Certificate Request wizard, on the Specify Certificate Authority Response page, do the following and then click OK:

    | File name containing the          | Click the … box and browse to and select the .cer file                                                                                                          |
    | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | certificate authority's response: | (e.g., _your\_domain\_com.cer_) that DigiCert sent to you.                                                                                                      |
    |                                   |                                                                                                                                                                 |
    | Friendly name:                    | Type a friendly name for the certificate.                                                                                                                       |
    |                                   | The friendly name is not part of the certificate; instead, it is used to identify the certificate.                                                              |
    |                                   | We recommend that you add DigiCert and the expiration date to the end of your friendly name, for example: yoursite-digicert-(expiration date).                  |
    |                                   | This information helps identify the issuer and expiration date for each certificate. It also helps distinguish multiple certificates with the same domain name. |
    |                                   |                                                                                                                                                                 |
    | Select a certificate store        | In the drop-down list, select Web Hosting.                                                                                                                      |
    | for the new certificate:          |                                                                                                                                                                 |

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-sni-1.png)
7. Now that you've successfully installed your SSL certificate, you need to assign the certificate to the appropriate site.
8.  In Internet Information Services (IIS) Manager, in the Connections menu tree (left pane), expand the name of the server on which the certificate was installed. Then expand Sites and click the site you want to use the SSL certificate to secure.

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-3.png)
9. On the website Home page, in the Actions menu (right pane), under Edit Site, click the Bindings… link.
10. In the Site Bindings window, click Add.

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-4.png)
11. In the Add Site Bindings window, do the following and then click OK:

    | Type:            | In the drop-down list, select https.                                               |
    | ---------------- | ---------------------------------------------------------------------------------- |
    |                  |                                                                                    |
    | IP address:      | In the drop-down list, select the IP address of the site or select All Unassigned. |
    |                  |                                                                                    |
    | Port:            | Type port _443_. The port over which traffic is secure by SSL is port 443.         |
    |                  |                                                                                    |
    | SSL certificate: | In the drop-down list, select your new SSL certificate (e.g., _yourdomain.com_).   |

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-5.png)
12. Your first SSL certificate is now installed, and the website configured to accept secure connections.

**Install Additional SSL Certificates**

To install and assign each additional SSL certificate, repeat the steps below, as needed.

1. On the server where you created the CSR, save the SSL certificate .cer file (e.g., _your\_domain\_com.cer_) that DigiCert sent to you.
2. In the Windows start menu, type _Internet Information Services (IIS) Manager_ and open it.
3.  In Internet Information Services (IIS) Manager, in the Connections menu tree (left pane), locate and click the server name.

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-1.png)
4. On the server name Home page (center pane), in the IIS section, double-click Server Certificates.
5.  On the Server Certificates page (center pane), in the Actions menu (right pane), click the Complete Certificate Request… link.

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-1.png)
6.  In the Complete Certificate Request wizard, on the Specify Certificate Authority Response page, do the following and then click OK:

    | File name containing the          | Click the … box and browse to and select the .cer file                                                                                                          |
    | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | certificate authority's response: | (e.g., _your\_domain\_com.cer_) that DigiCert sent to you.                                                                                                      |
    |                                   |                                                                                                                                                                 |
    | Friendly name:                    | Type a friendly name for the certificate.                                                                                                                       |
    |                                   | The friendly name is not part of the certificate; instead, it is used to identify the certificate.                                                              |
    |                                   | We recommend that you add DigiCert and the expiration date to the end of your friendly name, for example: yoursite-digicert-(expiration date).                  |
    |                                   | This information helps identify the issuer and expiration date for each certificate. It also helps distinguish multiple certificates with the same domain name. |
    |                                   |                                                                                                                                                                 |
    | Select a certificate store        | In the drop-down list, select Web Hosting.                                                                                                                      |
    | for the new certificate:          |                                                                                                                                                                 |

    ![IIS 10 Install SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-sni-1.png)
7. Now that you've successfully installed your SSL certificate, you need to assign the certificate to the appropriate site.
8.  In Internet Information Services (IIS) Manager, in the Connections menu tree (left pane), expand the name of the server on which the certificate was installed. Then expand Sites and click the site you want to use the SSL certificate to secure.

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-3.png)
9. On the website Home page, in the Actions menu (right pane), under Edit Site, click the Bindings… link.
10. In the Site Bindings window, click Add.

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-4.png)
11. In the Add Site Bindings window, do the following and then click OK:

    | Type:            | In the drop-down list, select https.                                                                                               |
    | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
    |                  |                                                                                                                                    |
    | IP address:      | In the drop-down list, select the IP address of the site or select All Unassigned.                                                 |
    |                  |                                                                                                                                    |
    | Port:            | Type port _443_. The port over which traffic is secure by SSL is port 443.                                                         |
    |                  |                                                                                                                                    |
    | Host name:       | Type the host name that you want to secure.                                                                                        |
    |                  |                                                                                                                                    |
    | Require Server   | After you enter the host name, check this box.                                                                                     |
    | Name Indication: | This is required for all additional certificates/sites, after you've installed the first certificate and secured the primary site. |
    |                  |                                                                                                                                    |
    | SSL certificate: | In the drop-down list, select an additional SSL certificate (e.g., _yourdomain2.com_).                                             |

    ![IIS 10 Assign SSL Certificate](https://www.digicert.com/kb/images/support-images/iis10/iis10-ssl-certificate-install-sni-2.png)
12. You have successfully installed another SSL certificate and configured the website to accept secure connections.



***

## REFERENCES

* [https://www.digicert.com/kb/csr-creation-ssl-installation-iis-10.htm#ssl\_certificate\_install](https://www.digicert.com/kb/csr-creation-ssl-installation-iis-10.htm#ssl_certificate_install)
