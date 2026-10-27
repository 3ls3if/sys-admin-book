---
icon: windows
---

# IIS: Export Pfx using MMC

### How to Export/Back Up Your SSL Certificate w/Private Key

1.  On the Windows server 2016 where the SSL certificate is installed, open the Console.

    In the Windows start menu, type mmc and open it.
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
7.  In the Console window, in the Console Root pane (left side), expand Certificates (Local Computer), expand the folder that contains the certificate that you want to export/back up, and then, click the associated Certificates folder.

    Note: Your certificate _should be_ in either the Personal or the Web Hosting folder.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-6.png)
8. In the center pane, right-click on the certificate that you want to export/back up and then click All Tasks > Export.
9. In the Certificate Export Wizard, on the Welcome to the Certificate Export Wizard page, click Next.
10. On the Export Private Key page, select Yes, export the private key, and then, click Next.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-7.png)
11. On the Export File Format page, select Personal Information Exchange – PKCS #12 (.PFX) and then check Include all certificates in the certification path if possible.

    Warning: Do not select Delete the private key if the export is successful.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-8.png)
12. On the Security page, do following one of the following options:

    | Password:          | i. Check this box.                                                                                                       |
    | ------------------ | ------------------------------------------------------------------------------------------------------------------------ |
    | Confirm password:  | ii. Then, create and confirm the password.                                                                               |
    |                    | Password Note:                                                                                                           |
    |                    | This password will be required when you import the certificate w/private key to your (different) Windows server 2016.    |
    |                    |                                                                                                                          |
    | Group or user name | i. Check this box                                                                                                        |
    | (recommended)      | ii. In the field below, select the Active Directory user or group account to which you want to assign                    |
    |                    | access to the certificate w/private key.                                                                                 |
    |                    | iii. Then, click Add.                                                                                                    |
    |                    | Export/Import Note:                                                                                                      |
    |                    | The server from which you export the certificate w/private key must be part of an AD domain.                             |
    |                    | The server to which you import the certificate w/private key must be tied to an AD domain with a domain controller (DC). |

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-9.png)
13. On the File to Export page, click Browse. In the Save As window, locate and select the certificate file that you want to export and then click Save. Finally, on the File to Export page, click Next.

    Make sure to note the filename and the location where you saved your file. If you only enter the filename without selecting a location, your file is saved to the following location: C:\Windows\System32.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-10.png)
14. On the Completing the Certificate Export Wizard page, verify that the settings are correct and then, click Finish.

    ![](https://www.digicert.com/kb/images/support-images/iis10/iis-10-export-ssl-certificate-11.png)
15. You should receive _"The export was successful_" message.

    The SSL certificate w/private key .pfx file is now saved to the location that you selected.
