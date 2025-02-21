---
icon: windows
---

# IIS: Export Pfx using IIS Manager

### Export using IIS <a href="#id-2" id="id-2"></a>

1. Go to Start >> Administrative Tools >> Internet Information Services (IIS) Manager.
2. Select the server on which the certificate is installed.
3.  Choose the Server Certificates option on the central menu:\
    \


    <figure><img src="https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/iis_exp_14.png" alt=""><figcaption></figcaption></figure>
4.  Right-click on the needed certificate and select Export.\
    \
    Only the certificates associated with private keys are shown in the list of server certificates in IIS Manager.\
    \


    <figure><img src="https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/iis_exp_15.png" alt=""><figcaption></figcaption></figure>
5.  Specify the filename, location, and PFX export password and click OK:\
    \
    \
    \
    A PFX file has now been exported and can be found in the specified location. Importing a certificate on a new server can be also performed by using either Microsoft Management Console or IIS Manager.

    <figure><img src="https://namecheap.simplekb.com/SiteContents/2-7C22D5236A4543EB827F3BD8936E153E/media/iis_exp_16.png" alt=""><figcaption></figcaption></figure>

\
