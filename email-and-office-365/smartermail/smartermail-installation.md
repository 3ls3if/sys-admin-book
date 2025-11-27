---
icon: gear
---

# SmarterMail Installation

## Installing Smartermail

<details>

<summary> Prerequisites</summary>

Current Smartermail builds require “**.NET Framework 4.8**”. If you do not already have this installed on your server, then you can install it during the Smartermail installation, but it will require a reboot of the server.

</details>

**Download the latest version of Smartermail below:**

* [https://www.smartertools.com/smartermail/downloads 12](https://www.smartertools.com/smartermail/downloads)

Once you have downloaded the latest version to your windows server you will then following the steps below:

1. Place the EXE or MSI file on the server that you are wanting to install Smartermail on.
2. Run the installer.
3.  Check the box to agree to the license terms.

    [![Smartermailp1](https://learn.xbytecloud.com/uploads/default/optimized/1X/fa3c3f73a2cd6070241a471cd384f34f57db2757_2_304x375.png)](https://learn.xbytecloud.com/uploads/default/original/1X/fa3c3f73a2cd6070241a471cd384f34f57db2757.png)
4.  If you have a license key choose “**Enter a license key**”. If not, then choose “**Free Edition**”.

    [![Smartermailp2](https://learn.xbytecloud.com/uploads/default/optimized/1X/daf34c5fd63faa673fab233ef4c7b98a4e2d5d42_2_304x375.png)](https://learn.xbytecloud.com/uploads/default/original/1X/daf34c5fd63faa673fab233ef4c7b98a4e2d5d42.png)
5.  If you have **NOT** created a site in IIS for Smartermail, then choose “**Create a new site**”. If you have a site made in Smartermail specifically for Smartermail choose “**Use a existing site**”.

    [![Smartermailp4](https://learn.xbytecloud.com/uploads/default/optimized/1X/280e340c1bc9b4a5330d702ad3e935637fd5a328_2_304x375.png)](https://learn.xbytecloud.com/uploads/default/original/1X/280e340c1bc9b4a5330d702ad3e935637fd5a328.png)

    _You shouldn’t need to pre-create a site in IIS for Smartermail unless the installer is not allowing you to create a new site._
6.  If you chose “**Create a new site**”, then you should be able to leave things as is and click “**Next**”.<br>

    [![Smartermailp5](https://learn.xbytecloud.com/uploads/default/optimized/1X/e98db5fbef89de3e423d3259d09de661acc3599c_2_302x375.png)](https://learn.xbytecloud.com/uploads/default/original/1X/e98db5fbef89de3e423d3259d09de661acc3599c.png)

    _if you want to change the name of the site or add a hostname then you can certainly do that._
7.  Click “**Install**”.

    [![Smartermailp6](https://learn.xbytecloud.com/uploads/default/optimized/1X/8d4dca277248ef36ab4a55611176612dd8cc2868_2_303x375.png)](https://learn.xbytecloud.com/uploads/default/original/1X/8d4dca277248ef36ab4a55611176612dd8cc2868.png)

    Smartermail has now been installed.

## Post-install Setup <a href="#post-install-setup-2" id="post-install-setup-2"></a>

1. On the server that you have installed Smartermail, Open up any browser other than IE and navigate to `http://127.0.0.1:9998/`
2.  Enter the username, password, and Data path, then click “**Finish**”.<br>

    [![image](https://learn.xbytecloud.com/uploads/default/optimized/1X/c88e952222f773f40ea0124322d92b545f728ac1_2_517x303.png)](https://learn.xbytecloud.com/uploads/default/original/1X/c88e952222f773f40ea0124322d92b545f728ac1.png)
3. Now open “**Windows Firewall**”
4. Create a new inbound rule, choose type “**Program**”, then “**Next**”.
5. Choose “**This program path**” and link to the following path:

`%ProgramFiles% (x86)\SmarterTools\SmarterMail\Service\MailService.exe`

6. Leave the rest of the options at their defaults and name the rule “**Smartermail**”
