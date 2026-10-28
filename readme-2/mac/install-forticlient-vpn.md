---
icon: bars-progress
---

# Install FortiClient VPN

## Introduction

The following instructions guide you though the manual installation of FortiClient on a macOS computer. For more information, see the [_FortiClient (macOS) Release Notes_](https://docs.fortinet.com/document/forticlient/7.4.2/macos-release-notes/).

After manually running the FortiClient installer on a macOS computer, you must enable certain permissions and perform other actions for FortiClient to work properly. This topic provides instructions on the necessary configurations. The process is as follows:

1. <mark style="color:green;">Install FortiClient on a macOS computer using the installer file. See</mark> [<mark style="color:green;">To install FortiClient on a macOS computer:</mark>](https://docs.fortinet.com/document/forticlient/7.4.2/administration-guide/903183/macos#To)<mark style="color:green;">.</mark>
2. <mark style="color:green;">Activate system extensions. See</mark> [<mark style="color:green;">To activate system extensions:</mark>](https://docs.fortinet.com/document/forticlient/7.4.2/administration-guide/903183/macos#To2)<mark style="color:green;">.</mark>
3. <mark style="color:green;">(macOS 11 Big Sur and 10.15 Catalina only) Enable full disk access. See</mark> [<mark style="color:green;">To enable full disk access:</mark>](https://docs.fortinet.com/document/forticlient/7.4.2/administration-guide/903183/macos#To3)<mark style="color:green;">.</mark>
4. <mark style="color:green;">Enable notifications. See</mark> [<mark style="color:green;">To enable notifications:</mark>](https://docs.fortinet.com/document/forticlient/7.4.2/administration-guide/903183/macos#To4)<mark style="color:green;">.</mark>

Depending on what features are enabled on EMS, installing FortiClient (macOS) may require admin credentials to handle prompts for system keychain changes and granting permissions under _Security & Privacy_.

For FortiClient upgrade, system certificates and security permissions remain unchanged, so no special user privileges are required.

***

## To install FortiClient on a macOS computer:

1. <mark style="color:green;">Double-click the FortiClient\_7.4.2.xx\_macosx .dmg installer file. The</mark> <mark style="color:green;"></mark>_<mark style="color:green;">FortiClient for macOS</mark>_ <mark style="color:green;"></mark><mark style="color:green;">dialog displays.</mark>
2. <mark style="color:green;">Double-click</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Install</mark>_<mark style="color:green;">. The</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Welcome to the FortiClient Installer</mark>_ <mark style="color:green;"></mark><mark style="color:green;">dialog displays.</mark>
3. <mark style="color:green;">(Optional) Click the lock icon in the upper-right corner to view certificate details and click</mark> <mark style="color:green;"></mark>_<mark style="color:green;">OK</mark>_ <mark style="color:green;"></mark><mark style="color:green;">to close the dialog. Click</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Continue</mark>_<mark style="color:green;">.</mark>
4. <mark style="color:green;">Read the Software License Agreement and click</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Continue</mark>_<mark style="color:green;">. You have the option to print or save the Software Agreement in this window. You are prompted to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Agree</mark>_ <mark style="color:green;"></mark><mark style="color:green;">with the terms of the license agreement.</mark>
5. <mark style="color:green;">If you agree with the terms of the license agreement, click</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Agree</mark>_ <mark style="color:green;"></mark><mark style="color:green;">to continue the installation.</mark>
6. <mark style="color:green;">Depending on your system, you may be prompted to enter your system password.</mark>
7. <mark style="color:green;">After the installation completes successfully, Click</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Close</mark>_ <mark style="color:green;"></mark><mark style="color:green;">to exit the installer. FortiClient has been saved to the</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Applications</mark>_ <mark style="color:green;"></mark><mark style="color:green;">folder.</mark>
8.  <mark style="color:green;">If using macOS Mojave (version 10.14), you must reboot the macOS device after installing FortiClient (macOS). FortiClient (macOS) displays the following prompt after installation. Click</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Restart System</mark>_<mark style="color:green;">:</mark>

    ![](https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/resources/e518fda0-b66f-11ef-9411-ae1fcf29f169/images/1c8b1b0f5573ad73d66d337447de24a1_Restart_prompt.png)
9. <mark style="color:green;">Double-click the FortiClient icon to launch the application. The application loads to your desktop.</mark>



***

## **To activate system extensions:**

{% hint style="success" %}
After you perform an initial install of FortiClient, the device prompts you to allow some settings for FortiClient processes. You must have administrator credentials for the macOS machine to configure these changes.
{% endhint %}

#### VPN <a href="#vpn" id="vpn"></a>

You must allow the macOS system software to load the FortiTray.

**To allow FortiTray to load:**

1. <mark style="color:green;">Do one of the following:</mark>
   * <mark style="color:green;">If using macOS Sequoia (version 15), go to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Settings > General > Login Items & Extensions > Network Extensions</mark>_<mark style="color:green;">.</mark>
   * <mark style="color:green;">If using another macOS version, go to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Settings > Privacy & Security</mark>_<mark style="color:green;">.</mark>
2.  <mark style="color:green;">Enable</mark> <mark style="color:green;"></mark>_<mark style="color:green;">FortiTray</mark>_<mark style="color:green;">.</mark>

    ![](https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/resources/4f6d1ee2-b670-11ef-9411-ae1fcf29f169/images/94c3366a5ea13b37b98c0fec1f3ad426_FortiTray.jpg)

#### Web Filter and Application Firewall <a href="#web_filter_and_application_firewall" id="web_filter_and_application_firewall"></a>

You must enable the FortiClientProxy extension for Web Filter to work properly. You must enable the FortiClientPacketFilter extension for Application Firewall and network lockdown to work properly. The FortiClient (macOS) team ID is AH4XFXJ7DK.

**To enable the FortiClientNetwork extension:**

1. <mark style="color:green;">Do one of the following:</mark>
   * <mark style="color:green;">If using macOS Sequoia (version 15), go to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Settings > General > Login Items & Extensions > Network Extensions</mark>_<mark style="color:green;">.</mark>
   * <mark style="color:green;">If using another macOS version, go to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Settings > Privacy & Security</mark>_<mark style="color:green;">.</mark>
2.  <mark style="color:green;">Enable the</mark> <mark style="color:green;"></mark>_<mark style="color:green;">FortiClientProxy</mark>_ <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark>_<mark style="color:green;">FortiClientPacketFilter</mark>_ <mark style="color:green;"></mark><mark style="color:green;">toggles.</mark>

    ![](https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/resources/4f6d1ee2-b670-11ef-9411-ae1fcf29f169/images/94c3366a5ea13b37b98c0fec1f3ad426_FortiTray.jpg)
3.  <mark style="color:green;">Verify the extension status by running</mark> <mark style="color:green;"></mark><mark style="color:green;">`systemextensionsctl list`</mark> <mark style="color:green;"></mark><mark style="color:green;">in the macOS terminal. In the output, the FortiClientPacketFilter extension displays as macos.webfilter. The following provides example output when the extension is enabled:</mark>

    ![](https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/resources/4f6d1ee2-b670-11ef-9411-ae1fcf29f169/images/e839afae751ac6737d0f62d083536172_fct_macos_setup_steps.jpg)

#### Proxy mode extension <a href="#proxy_mode_extension" id="proxy_mode_extension"></a>

The com.fortinet.forticlient.macos.proxy system extension works as a proxy server to proxy a TCP connection. macOS manages the extension's connection status and other statistics. This resolves the issue that Web Filter fails to work when SSL and IPsec VPN are connected.

FortiClient (macOS) automatically installs the extension on an M1 Pro or newer macOS device.



***

## To enable full disk access:

{% hint style="success" %}
macOS 11 Big Sur and 10.15 Catalina include security setting changes, which require you to enable full disk access for FortiClient services. If you do not grant full disk access to FortiClient services, FortiClient only provide partial protection of files in the /Applications directory. The first time that FortiClient detects an attempt to run an executable file located in another protected location on the endpoint as malware protection, macOS denies FortiClient access and prompts the user to grant full disk access.
{% endhint %}

1. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">System Preferences > Security & Privacy</mark>_ <mark style="color:green;"></mark><mark style="color:green;">tab, and select</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Full Disk Access</mark>_
2. <mark style="color:green;">To make changes, click lock icon on the bottom left, enter your credentials, and</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Unlock</mark>_<mark style="color:green;">.</mark>
3. <mark style="color:green;">Select the following services to grant them full disk access:</mark>
   * <mark style="color:green;">fctservctl2</mark>
   * <mark style="color:green;">FortiClient</mark>

If you did not grant full disk access permissions for the daemons, you can check their status on the _Settings_ tab under _Privacy Status_. Click _Open File Access_ to grant permissions for the daemons. If you do not configure this, macOS displays a popup asking for permissions each time that you use a feature related to one of the daemons, such as scanning for viruses.

![](https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/resources/e518fda0-b66f-11ef-9411-ae1fcf29f169/images/f1e2c01d7cff52b3a37a3c8dbead86e5_Open_file_access.png)

***

## To enable notifications:

After initial installation, macOS prompts the user to enable FortiClient (macOS) notifications.

![](https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/resources/e518fda0-b66f-11ef-9411-ae1fcf29f169/images/61ed3e58d4a415f0b29c222c00dea12a_mac_fct_7.0.3_notification_permission_prompt.png)

1. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark>_<mark style="color:green;">System Preferences > Notifications > FortiClientAgent</mark>_<mark style="color:green;">.</mark>
2. <mark style="color:green;">Toggle</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Allow Notifications</mark>_ <mark style="color:green;"></mark><mark style="color:green;">on.</mark>



![](https://fortinetweb.s3.amazonaws.com/docs.fortinet.com/v2/resources/e518fda0-b66f-11ef-9411-ae1fcf29f169/images/c43e3a99a8de7f73fca33218bb83d1d5_mac_fct_7.0.3_notification_permission_setting.png)

<br>

***

## REFERENCES

* [https://docs.fortinet.com/document/forticlient/7.4.2/administration-guide/903183/macos#To2](https://docs.fortinet.com/document/forticlient/7.4.2/administration-guide/903183/macos#To2)
* [https://docs.fortinet.com/document/forticlient/7.4.2/macos-release-notes/223986](https://docs.fortinet.com/document/forticlient/7.4.2/macos-release-notes/223986)

