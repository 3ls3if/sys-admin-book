---
icon: windows
---

# IIS: Import Pfx using MMC

### How to Import the SSL Certificate w/Private Key .pfx File

If you have not yet exported the SSL certificate and its private key as a .pfx file from the server on which the certificate is installed, see [How to Export/Back Up Your SSL Certificate w/Private Key](https://www.digicert.com/kb/ssl-support/certificate-pfx-file-export-import-iis-10.htm#export-pfx).

1.  On the Windows server 2016 where you want to install the SSL certificate, open the Console.

    In the Windows start menu, type _mmc_ and open it.
2.  In the Console window, in the top menu, click File > Add/Remove Snap-in.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-1.png)
3.  In the Add or Remove Snap-ins window, in the Available snap-ins pane (left side), select Certificates and then click Add >.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-2.png)
4.  In the Certificate snap-in window, select Computer account and then click Next.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-3.png)
5.  In the Select Computer window, select Local computer: (the computer this console is running on), and then click Finish.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-4.png)
6.  In the Add or Remove Snap-ins window, click OK.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-5.png)
7.  In the Console window, in the Console Root pane (left side), expand Certificates (Local Computer), right-click on the Web Hosting folder, and then click All Tasks > Import.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-import-ssl-certificate-1.png)
8. In the Certificate Import Wizard, on the Welcome to the Certificate Import Wizard page, click Next.
9.  On the File to Import page, browse to and select the file that you want import and then, click Next.

    Notes: In the File Explorer window, in the file type drop-down, make sure to select All Files (\*.\*). By default, it is set to search for X.509 Certificate (\*.cert;\*.crt) file types only.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-import-ssl-certificate-2.png)
10. On the Private key protection page, do the following:

    | Password:            | Type the password that you created when the SSL certificate was exported.         |
    | -------------------- | --------------------------------------------------------------------------------- |
    |                      |                                                                                   |
    | Mark this key as     | Check this box so that you can back up or export the SSL certificate when needed. |
    | exportable.          | Note that a certificate without it's private key does not work.                   |
    |                      |                                                                                   |
    | Include all extended | Check this box.                                                                   |
    | properties.          |                                                                                   |

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-import-ssl-certificate-3.png)
11. On the Certificate Store page, do the following and then click Next:

    1. Select Place all certificates in the following store and click Browse.
    2. In the Select Certificate Store window, select Web Hosting and click OK.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-import-ssl-certificate-4.png)
12. On the Completing the Certificate Import Wizard page, verify that the settings are correct and then, click Finish.
13. You should receive _"The import was successful_" message.

    The SSL certificate w/private key .pfx file is now saved to the Web Hosting store (folder).

