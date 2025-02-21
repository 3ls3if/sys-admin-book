---
icon: windows
---

# IIS: Import Pfx using IIS Manager

### Import PFX using IIS Manager <a href="#id-4" id="id-4"></a>

1. Launch Internet Information Services Manager (Start >> Administrative Tools >> Internet Information Services (IIS) Manager), and choose the server the certificate should be imported to.
2. Double-click Server Certificates in the central menu.
3.  Click the Import button in the right-hand menu:\
    \


    <figure><img src="https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/iis_exp_27.png" alt=""><figcaption></figcaption></figure>
4.  Locate the PFX file on your machine and specify the password that was used when exporting the certificate. Optionally, you may check Allow this certificate to be exported. Then, click OK:\
    \


    <figure><img src="https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/iis_exp_28.png" alt=""><figcaption></figcaption></figure>

**Assigning a certificate to a website**

Once the certificate has been imported by any of the methods described above, it will be shown in the list of server certificates in IIS Manager.

After that, please make sure to complete the binding of the certificate to a specific website.

You can find more information on how to bind the certificate to a website in IIS in [this installation guide](https://www.namecheap.com/support/knowledgebase/article.aspx/9424/0/iis-7).
