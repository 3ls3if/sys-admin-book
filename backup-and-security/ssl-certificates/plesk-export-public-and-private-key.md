---
icon: windows
---

# Plesk: Export Public & Private Key

## Method 1

1. [Log into Plesk](https://plesk-new.zendesk.com/hc/en-us/articles/12377667582743).
2. Go to **Domains > example.com > SSL/TLS Certificates > Advanced Settings** or **Tools & Settings > SSL/TLS Certificates**.
3.  Click the green arrow button next to the certificate name:



    <figure><img src="https://support.plesk.com/hc/article_attachments/12377315856279/screenshot.1.png" alt=""><figcaption></figcaption></figure>

The `.pem` file will be downloaded which contains the following parts (in the order of appearance):

* CSR (certificate signing request).
* private key.
* the certificate itself (or public key).
* CA certificate(s).



***

## Method 2

In case you wish to find the Private Key of your installed SSL, follow the instructions described below: 1. **Log in to Plesk with your credentials.**<br>

<figure><img src="https://support.papaki.com/wp-content/uploads/imported/enartia.deskpro.com/dps-fs/b8f6e5d0ba63dd0f43f58f80adeba068d5599f32/files/28334/8526/1582285302408.png" alt=""><figcaption></figcaption></figure>

2\. On the **Websites & Domains** tab, **select SSL/TLS Certificates.**<br>

<figure><img src="https://support.papaki.com/wp-content/uploads/imported/enartia.deskpro.com/dps-fs/b8f6e5d0ba63dd0f43f58f80adeba068d5599f32/files/28334/7818/1580741343293.png" alt=""><figcaption></figcaption></figure>

3\. Select **Advanced Settings.**<br>

<figure><img src="https://support.papaki.com/wp-content/uploads/imported/enartia.deskpro.com/dps-fs/b8f6e5d0ba63dd0f43f58f80adeba068d5599f32/files/28334/7895/1580912006223.png" alt=""><figcaption></figcaption></figure>

4\. Click on the name of the installed SSL.<br>

<figure><img src="https://support.papaki.com/wp-content/uploads/imported/enartia.deskpro.com/dps-fs/b8f6e5d0ba63dd0f43f58f80adeba068d5599f32/files/28334/7818/1580741464866.png" alt=""><figcaption></figcaption></figure>

4\. Under the CSR category, you will find your SSL Private Key.

![](https://support.papaki.com/wp-content/uploads/imported/enartia.deskpro.com/dps-fs/b8f6e5d0ba63dd0f43f58f80adeba068d5599f32/files/28334/7896/1580912237290.png)
