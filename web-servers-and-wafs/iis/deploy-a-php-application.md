---
icon: php
---

# Deploy a PHP Application

1. Install IIS through ‘Windows Features’ and make sure to select following options, and then IIS manager will be installed in your windows.\
   — Dot Net Framework\
   — Internet Information Services\
   — CGI

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*GJS0muLQ1k5jhpcJIwc_1w.png" alt="" height="354" width="700"><figcaption><p>Turn Windows features on or off</p></figcaption></figure>

2\. Once IIS manager Installation is completed then to verify it type localhost in your browser and press enter and it will show you IIS manager welcome screen.

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*ioJ5UpT6VY7zoyg3DXDkGw.png" alt="" height="274" width="700"><figcaption></figcaption></figure>

3\. [Download and install PHP Manager](https://www.iis.net/downloads/community/2018/05/php-manager-150-for-iis-10) and once finished then close IIS Manager and open it again then you can see PHP Manager option is available.

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*4JJKau5VxUS63cH0FGiZZg.png" alt="" height="299" width="700"><figcaption><p>Internet Information Services (IIS) Manager</p></figcaption></figure>

4\. [Download](https://windows.php.net/download/) PHP Version

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*Hb9VTI9OJAQywlIzIraPTg.png" alt="" height="224" width="700"><figcaption></figcaption></figure>

5\. Extract the PHP version (Do not extract this version in “C” Drive).

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*rPDD4-t8Mv45siS97qeqqg.png" alt="" height="191" width="700"><figcaption></figcaption></figure>

6\. Next select ‘Default Web Site’ from left panel and double click on **PHP Manager** then click on ‘Register new PHP version’ and here select ‘php-cgi.exe’ from extracted PHP version and click OK and then you can see PHP configuration details in PHP Manager.

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*iexSiyK0V2Xc-G6V_nlSzw.png" alt="" height="322" width="700"><figcaption><p>Default Web Site → PHP Manager</p></figcaption></figure>

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*UdKPg2fxtqkhU8QFZTaBRQ.png" alt="" height="305" width="700"><figcaption><p>Register new PHP version</p></figcaption></figure>

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*XrOzAL1DE6BT0dHcE4Lcbw.png" alt="" height="390" width="700"><figcaption><p>PHP Manager</p></figcaption></figure>

7\. To verify this click on ‘check phpinfo()’ and click OK then PHP version details will be displayed.

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*LlnidkQgmqlzLXNS_0p0Hw.png" alt="" height="270" width="700"><figcaption><p>phpinfo()</p></figcaption></figure>

8\. You can also place PHP file in the wwwroot location of ‘Default Web Site’ which is ‘C:\inetpub\wwwroot’ then type this URL in browser ‘http://localhost/filename.php'

<figure><img src="https://miro.medium.com/v2/resize:fit:875/1*8davtRLU7Ky7_fM29hmoRg.png" alt="" height="329" width="700"><figcaption><p>index.php file</p></figcaption></figure>



{% hint style="warning" %}
[HTTP Error 500.0 - Internal Server Error An unknown FastCGI error occured](https://stackoverflow.com/questions/6176093/http-error-500-0-internal-server-error-an-unknown-fastcgi-error-occured)<br>
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

1. Go to IIS manager
2. Click on your server's `Application Pools` tab
3. Click `Set Application Pool Defaults`...
4. Set the `Identity` under `Process Model` to LocalSystem
{% endhint %}





***

## REFERENCES

* [https://stackoverflow.com/questions/6176093/http-error-500-0-internal-server-error-an-unknown-fastcgi-error-occured](https://stackoverflow.com/questions/6176093/http-error-500-0-internal-server-error-an-unknown-fastcgi-error-occured)
* [https://medium.com/@srghimire061/how-to-deploy-a-php-website-or-application-to-iis-windows-server-bf91a32b91ad](https://medium.com/@srghimire061/how-to-deploy-a-php-website-or-application-to-iis-windows-server-bf91a32b91ad)
