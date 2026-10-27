---
icon: windows
---

# IIS 10: Create CSR and Install SSL Certificate

### IIS 10: How to Create Your CSR on Windows Server 2016

#### Using IIS 10 to Create Your CSR

1. In the Windows start menu, type _Internet Information Services (IIS) Manager_ and open it.
2.  In Internet Information Services (IIS) Manager, in the Connections menu tree (left pane), locate and click the server name.

    ![IIS 10 Create CSR](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-1.png)
3. On the server name Home page (center pane), in the IIS section, double-click Server Certificates.
4.  On the Server Certificates page (center pane), in the Actions menu (right pane), click the Create Certificate Request… link.

    ![IIS 10 Create CSR](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-2.png)
5.  In the Request Certificate wizard, on the Distinguished Name Properties page, provide the information specified below and then click Next:

    | Common name:         | Type the fully-qualified domain name (FQDN) (e.g., _www.example.com_).                                             |
    | -------------------- | ------------------------------------------------------------------------------------------------------------------ |
    |                      |                                                                                                                    |
    | Organization:        | Type your company’s legally registered name (e.g., _YourCompany, Inc._).                                           |
    |                      |                                                                                                                    |
    | Organizational unit: | The name of your department within the organization. Frequently this entry will be listed as "IT", "Web Security," |
    |                      | or is simply left blank.                                                                                           |
    |                      |                                                                                                                    |
    | City/locality:       | Type the city where your company is legally located.                                                               |
    |                      |                                                                                                                    |
    | State/province:      | Type the state/province where your company is legally located.                                                     |
    |                      |                                                                                                                    |
    | Country:             | In the drop-down list, select the country where your company is legally located.                                   |

    ![IIS 10 Add CSR Details](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-3.png)
6.  On the Cryptographic Service Provider Properties page, provide the information below and then click Next.

    | Cryptographic     | In the drop-down list, select Microsoft RSA SChannel Cryptographic Provider, |
    | ----------------- | ---------------------------------------------------------------------------- |
    | service provider: | unless you have a specific cryptographic provider.                           |
    |                   |                                                                              |
    | Bit length:       | In the drop-down list select 2048, unless you have a specific reason         |
    |                   | for opting for larger bit length.                                            |

    ![IIS 10 Add CSR Details](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-4.png)
7.  On the File Name page, under Specify a file name for the certificate request, click the … box to browse to a location where you want to save your CSR.

    Note: Remember the filename that you choose and the location to which you save your csr.txt file. If you just enter a filename without browsing to a location, your CSR will end up in C:\Windows\System32.

    ![IIS 10 Add CSR Details](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-5.png)
8. When you are done, click Finish.
9.  Use a text editor (such as Notepad) to open the file. Then, copy the text, including the -----BEGIN NEW CERTIFICATE REQUEST----- and -----END NEW CERTIFICATE REQUEST----- tags, and paste it into the DigiCert order form.

    ![IIS 10 Add CSR Details](https://www.digicert.com/kb/images/support-images/iis10/iis10-create-csr-6.png)

    \
    10\.  After you receive your SSL certificate from CA, you can install it.

    <br>

***

## REFERENCES

* [https://www.digicert.com/kb/csr-creation-ssl-installation-iis-10.htm#ssl\_certificate\_install](https://www.digicert.com/kb/csr-creation-ssl-installation-iis-10.htm#ssl_certificate_install)

