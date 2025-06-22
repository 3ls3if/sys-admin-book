---
icon: windows
---

# Export a Let’s Encrypt SSL Certificate with Private Key via MMC Console

If you do not have the private key installed, follow these steps to resolve the issue and successfully export the Let’s Encrypt SSL certificate with its private key.

**Follow the steps:**

Step 1: Start MMC and Attempt to Export the Certificate:

1. Open Microsoft Management Console (MMC).
2. Add the Certificates snap-in.
3. Locate the Let’s Encrypt certificate.
4.  Right-click on the certificate, select All Tasks, and click Export….\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f056c9.png" alt=""><figcaption></figcaption></figure>
5.  The Certificate Export Wizard will appear. Click Next.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f10e03.png" alt=""><figcaption></figcaption></figure>
6. Select Yes, export the private key.
7.  If this option is greyed out, click Cancel and proceed to the next step to import the private key.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f1dc6f.png" alt=""><figcaption></figcaption></figure>

Step 2: Retrieve the Private Key Password from Win-ACME\
Before importing the private key, you need to obtain the certificate password from the Win-ACME client.

1. Navigate to the Win-ACME installation folder.
2. Launch the Win-ACME client.
3.  Select A to manage renewals and press Enter.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f2f6e7.png" alt=""><figcaption></figcaption></figure>
4.  Choose D to display renewal details and press Enter.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f37afc.png" alt=""><figcaption></figcaption></figure>
5.  Locate the .pfx password and copy it. Example:\
    n8LVJLxx2vQrC3QB2G7cn/mdeMK/RyGMBt8ECq8GYjs=\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f4b6f6.png" alt=""><figcaption></figcaption></figure>
6. Use this password in the next step to import the private key.

Step 3: Import the Private Key in Windows

1. Navigate to the certificate directory:\
   C:\ProgramData\win-acme\acme-v02.api.letsencrypt.org\Certificates
2.  Double-click the certificate to start the Certificate Import Wizard.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f71856.png" alt=""><figcaption></figcaption></figure>
3.  Select Local Machine and click Next.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38f904c5.png" alt=""><figcaption></figcaption></figure>
4.  The file path is automatically populated. Click Next.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38fa4d81.png" alt=""><figcaption></figcaption></figure>
5. Paste the private key password copied earlier.
6. Check both options:
   1. Mark this key as exportable (allows backup and transportation of keys).
   2. Include all extended properties.
7.  Click Next, and allow Windows to automatically select the certificate store.

    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38fb046d.png" alt=""><figcaption></figcaption></figure>
8. Click Finish. The certificate import should be successful.

Step 4: Export the Let’s Encrypt Certificate to PFX Format

1. Open MMC or refresh the session if already open.
2. Navigate to Certificates snap-in.
3. Right-click the Let’s Encrypt certificate, select All Tasks, then Export….
4. Click Next.
5.  This time, the Yes, export the private key option should be selectable. Click Next.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38fd1f1f.png" alt=""><figcaption></figcaption></figure>
6. Check the following options:
   * Include all certificates in the certification path if possible
   * Export all extended properties
   * Enable certificate privacy
7.  Click Next.\


    <figure><img src="https://www.eukhost.com/kb/wp-content/uploads/2025/03/Snag_38fe6bf3.png" alt=""><figcaption></figcaption></figure>
8. Select Password, enter a secure password, and confirm it. This password is required for future imports.
9. Click Browse to choose the export location. Ensure the filename includes the .pfx format (e.g., C:\Certs\certificate.pfx).
10. Click Finish to complete the export process.

Your Let’s Encrypt SSL certificate is now successfully exported with its private key.



***

## REFERENCES

* [https://www.eukhost.com/kb/how-to-export-a-lets-encrypt-ssl-certificate-with-private-key-via-mmc-console/](https://www.eukhost.com/kb/how-to-export-a-lets-encrypt-ssl-certificate-with-private-key-via-mmc-console/)
