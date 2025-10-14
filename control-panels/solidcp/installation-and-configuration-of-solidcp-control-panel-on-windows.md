---
icon: gears
---

# Installation and Configuration of SolidCP Control Panel on Windows

## **Installation and Configuration of SolidCP with Windows OS**

The following is required in advance:

* Windows Server (2003 or above)
* SQL Server (2005 or above)
* Download and install Web Deploy: [http://www.iis.net/downloads/microsoft/web-deploy](https://www.iis.net/downloads/microsoft/web-deploy)
* Download and install the SolidCP  [http://solidcp.com/downloads/](http://solidcp.com/downloads/)

1. The setup wizard will install SolidCP on your server, check the check box beside "I accept the terms in the license Agreement" click "Install".
2. Click on Install to continue.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/1(106).png" alt=""><figcaption></figcaption></figure>

3. Click finish to complete the installation.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/2(102).png" alt=""><figcaption></figcaption></figure>

4. Open the SolidCP, then click **“View Available Components”** .

<figure><img src="https://kb.diadem.in/kb_upload/image/image/3(81).png" alt=""><figcaption></figcaption></figure>

5. Click on Install beside SolidCP Standalone Server Setup.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/4(64).png" alt=""><figcaption></figcaption></figure>

6. SolidCP download manager will appear which will download the setup files.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/5(50).png" alt=""><figcaption></figcaption></figure>

7. Click on **NEXT** to continue.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/7(28).png" alt=""><figcaption></figcaption></figure>

8. System Configuration check will appear, click NEXT to continue

<figure><img src="https://kb.diadem.in/kb_upload/image/image/image-20190827161614-1.png" alt=""><figcaption></figcaption></figure>

9. Provide the IP address.
10. Type the Host name.
11. Click Next to continue.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/9(20).png" alt=""><figcaption></figcaption></figure>

12. Type localhost beside SQL Server
13. Select the Authentication type.
14. provide the username and password
15. Click **Next** to continue.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/11(26).png" alt=""><figcaption></figcaption></figure>

16. Now set the administrative password.
17. Click **NEXT** to continue.

<figure><img src="https://kb.diadem.in/kb_upload/image/image/12(5).png" alt=""><figcaption></figcaption></figure>

18. Once the installation procedure is completed click  on Next to complete the setup

![](https://kb.diadem.in/kb_upload/image/image/13\(5\).png)

**Note :**  In order to access SolidCP  open your Internet Browser then type your Server IP address which you have assigned during post installation along with port number for example  http:\\\10.0.0.1:9001.

### Configuring IIS for SolidCP

1. **Open IIS Management --> Click on "Application pools"**
2. **For each SolidCP Application pool**
3. **click:** --> Advanced settings...

![](https://kb.diadem.in/kb_upload/image/image/14\(5\).png)

4. Set startmode to "AlwaysRunning"

![](https://kb.diadem.in/kb_upload/image/image/15\(4\).png)

5. set Idle Time-out (minutes) to "0"

![](https://kb.diadem.in/kb_upload/image/image/16\(7\).png)

6. set Regular Time Interval (minutes) to "0"
7. Click on OK.

![](https://kb.diadem.in/kb_upload/image/image/17\(3\).png)

**Note :**

* **Repeat the step from 1 to 7 for each SolidCP Application pool.**
* **Above IIS configuration is required only when you want to configure shared server.**

**Adding Domain into the Solid CP**

For Installation and configuration of Domain follow the below Steps-

1. Once you login into SolidCP under Systems you will get an option **Domains** Click on it.

&#x20;&#x20;

<figure><img src="https://kb.diadem.in/kb_upload/image/image/18(1).png" alt=""><figcaption></figcaption></figure>

2. &#x20;Now Click on **Add Domain**.  &#x20;

![](https://kb.diadem.in/kb_upload/image/image/19\(1\).png)

3. Click on **Domain**.

![](https://kb.diadem.in/kb_upload/image/image/20\(1\).png)

4. Now provide the Domain name.
5. type the host name.
6. Tick beside Allow customer subdomain if  you want to allow customer to crate subdomain.
7. Click on Add Domain.

![](https://kb.diadem.in/kb_upload/image/image/21\(5\).png)

8. Now go to Web Sites.

![](https://kb.diadem.in/kb_upload/image/image/22\(5\).png)

9. Click on the website name.

![](https://kb.diadem.in/kb_upload/image/image/23\(5\).png)

10. Tick the checkbox beside **Enable Write Permissions.**
11. Tick the checkbox  beside **Enable Static Compression**.
12. Click on **Save Changes.**

![](https://kb.diadem.in/kb_upload/image/image/24\(6\).png)

13. Now go to left pan expand Configuration.
14. Go to IP address click on it.

![](https://kb.diadem.in/kb_upload/image/image/25\(4\).png)

15. Now check whether your IP address has been added.

![](https://kb.diadem.in/kb_upload/image/image/image-20190831145116-1.png)

16. Now under System Settings go to web platform Installer settings provide the developer url.

![](https://kb.diadem.in/kb_upload/image/image/27\(5\).png)





***

## REFERENCES

* [https://kb.diadem.in/installation-and-configuration-of-solidcp-control-panel-on-windows\_1239.html](https://kb.diadem.in/installation-and-configuration-of-solidcp-control-panel-on-windows_1239.html)
