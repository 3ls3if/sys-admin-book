---
icon: house
---

# In-Place Upgrade Windows Server to 2019/2022

## Introduction

Microsoft announced that Windows Server 2016 will continue to receive updates until January 12, 2027, while Windows Server 2019's end of life is set for January 9, 2029, with Windows Server 2022 being released in September 2021.

Although Windows Server 2016 is still widely used, we recommend upgrading to the latest version for enhanced security and improved performance.

#### Comparison of Windows Server 2016 vs. 2019

Windows Server 2019 updates the Storage Migration Service, adds Kubernetes platform support, introduces unified management, enables virtual network peering, enhances Windows Defender ATP, and more, whereas Windows Server 2016 removes features like iSNS, business scanning, remote desktop connection broker, remote desktop virtualization host, print components, and others.

Read Microsoft's guide about Windows Server 2019 edition comparisons.

#### Comparison of Windows Server 2019 vs. 2022

Server 2022 introduces four advanced security features, including Hypervisor-based code integrity, secured-core server, hardware-enforced stack protection, and Transport Layer Security (TLS 1.3) enablement.

The new version of Windows Server provides improved platform flexibility, a new Windows admin center, upgraded Hyper-V Manager, Hybrid Cloud Support, and Enhanced Kubernetes Experience.

Learn more: check editions comparison server 2022.



### How to Upgrade Windows Server to 2019/2022

A step-by-step guide to performing In-Place Server Upgrade:

{% hint style="danger" %}
Before executing the setup.exe file, make sure you have disabled or removed the network adapter from your current windows server.
{% endhint %}

#### Phase 1: Start Server setup.

**Step 1.** To start the installation process, go to the Windows Server 2019 setup media and click on the setup.exe file.

**Step 2.** Click Yes to Confirm the setup process.

**Step 3.** Select the "Download updates, drivers and optional features (recommended)" option and click "Next".

![Windows update setup - 1](https://www.idiskhome.com/resource/databackup/images/updates-win-setup-1.png)

**Step 4.** Wait for setup to check the device configuration. When it finishes, select Next.

**Step 5.** You need to enter the Server license key to proceed. If you're unsure about where to find the Windows Server product key, you can refer to a guide on how to locate it.

**Step 6.** Select the wanted Windows Server 2019 image and then click "Next" to proceed.

**Step 7.** Click "Accept" to agree with the Applicable notices and license terms.

![Windows update setup - 2](https://www.idiskhome.com/resource/databackup/images/updates-win-setup-2.png)

**Step 8.** Choose what to keep and click Next:

To keep your personal files and apps, choose the "Keep personal files and apps" option. This will allow you to retain access to your data.

"Nothing" will cause all data to be deleted, including files, apps, and settings.

![Windows update setup - 3](https://www.idiskhome.com/resource/databackup/images/updates-win-setup-3.png)

**Step 9.** After analyzing finish, you can click "Install" to prompt.

#### Phrase 2: Check whether the system is successfully upgraded.

Type Registry Editor on the search box and click to open it:

Follow the path to see ProductName: Computer\HKEY\_LOCAL\_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion

![check Windows OS](https://www.idiskhome.com/resource/databackup/images/check-os-edtion.png)

Your ProductName should be Windows Server 2019. It's essential to ensure all applications are running smoothly. If any apps or files are lost, Qiling Disk Master can help you create image files to keep everything safe.

If Windows Server is malfunctioning, navigate to the C:\Windows\Panther folder, compress the files into a zip, and reach out to Microsoft for assistance.



***

## REFERENCES

* [https://www.idiskhome.com/resource/databackup/windows-server-2016-upgrade-migrate-to-2019-2022.shtml](https://www.idiskhome.com/resource/databackup/windows-server-2016-upgrade-migrate-to-2019-2022.shtml)
* [https://learn.microsoft.com/en-us/windows-server/get-started/upgrade-in-place?tabs=media](https://learn.microsoft.com/en-us/windows-server/get-started/upgrade-in-place?tabs=media)
