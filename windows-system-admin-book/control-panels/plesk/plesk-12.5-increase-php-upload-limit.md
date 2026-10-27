---
icon: chart-line-up
---

# Plesk 12.5 – Increase PHP Upload Limit

### Overview <a href="#overview" id="overview"></a>

This article describes how to increase the maximum file upload limit from the default 2 Megabytes. The limit needs to be increased if you are uploading files (such as PDF’s and images) larger then 2 Megabytes via a CMS (e.g. WordPress , Joomla , Drupal).

### Prerequisite <a href="#prerequisite" id="prerequisite"></a>

Login credentials into your Plesk Server.

### Instructions <a href="#instructions" id="instructions"></a>

1.  Log into the Website hosting for your domain and select the _**Websites and Domains**_ tab, then click on _**PHP Settings:**_<br>

    <figure><img src="https://conetix.com.au/wp-content/uploads/2016/05/20/xphp_upload.png.pagespeed.ic.uJcex5YjdR.webp" alt=""><figcaption></figcaption></figure>
2.  Under _**Performance settings**_ you will need to increase both _**upload\_max\_filesize**_ and _**post\_max\_size**_ limits.\
    To adjust the maximum post size, enter a value into the select box by left clicking first.\
    For example for 20 Megabytes enter “20M”, for 64 Megabytes enter “64M”

    <figure><img src="https://conetix.com.au/wp-content/uploads/2016/05/20/xphp_upload_increase.png.pagespeed.ic.1ahE7bztvy.webp" alt=""><figcaption></figcaption></figure>
3. Click OK to save.





<br>

***

## REFERENCES

* [https://conetix.com.au/support/plesk-12-increase-php-upload-limit/](https://conetix.com.au/support/plesk-12-increase-php-upload-limit/)
* [https://docs.plesk.com/en-US/obsidian/advanced-administration-guide-win/changing-the-maximum-upload-file-size.74208/](https://docs.plesk.com/en-US/obsidian/advanced-administration-guide-win/changing-the-maximum-upload-file-size.74208/)
* [http://docs.plesk.com/en-US/onyx/advanced-administration-guide-linux/changing-the-maximum-upload-file-size.74207/](http://docs.plesk.com/en-US/onyx/advanced-administration-guide-linux/changing-the-maximum-upload-file-size.74207/)
