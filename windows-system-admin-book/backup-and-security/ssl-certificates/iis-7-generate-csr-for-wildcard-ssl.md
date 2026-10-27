---
icon: windows
---

# IIS 7: Generate CSR for Wildcard SSL

### How To Generate CSR For Wildcard SSL Certificate In IIS 7?

Here, we have enumerated the CSR generation for the [installation of Wildcard SSL on IIS 7](https://www.clickssl.net/blog/how-to-install-wildcard-ssl-certificate-in-iis-7).

IIS is an internet information server created by Microsoft for the use of the window. It supports HTTP, HTTPS, FTP, SMTP, and NNTP. It carries request filter, which rejects suspicious URL and thus reduces the attack. As we know, SSL certificates are the most trusted certificate all over the world.

### Generate Certificate Signing Request (CSR)

**Step #1:** Open Internet Information Services (IIS) Manager and click on the name of the server in the connections column on the left and double-click on “**Server Certificates**”.

<figure><img src="https://www.clickssl.net/wp-content/uploads/2020/07/server-certificates.png" alt=""><figcaption></figcaption></figure>

**Step #2:** Go to the right in the Actions column, click on “**Create Certificate Request**”.

<figure><img src="https://www.clickssl.net/wp-content/uploads/2020/07/create-certificate-request.png" alt=""><figcaption></figcaption></figure>

**Step #3:** Enter all of the subsequent information about your company and the domain you are securing and then click “**Next”**.

<figure><img src="https://www.clickssl.net/wp-content/uploads/2020/07/request-certificate.png" alt=""><figcaption></figcaption></figure>

**Step #4:** Allow the default **Cryptographic Service Provider**. Rise the Bit length to **2048 bit** or higher. Click **Next**.

<figure><img src="https://www.clickssl.net/wp-content/uploads/2020/07/cryptographic-service-provider-properties.png" alt=""><figcaption></figcaption></figure>

**Step #5:** Browse the filename to save the request certificate and click **Finish**. You will require that contents of this file to enroll an SSL Certificate.

<figure><img src="https://www.clickssl.net/wp-content/uploads/2020/07/save-your-certificate.png" alt=""><figcaption></figcaption></figure>

<br>
