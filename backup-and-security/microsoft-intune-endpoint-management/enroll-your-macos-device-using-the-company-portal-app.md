---
icon: apple
---

# Enroll your macOS device using the Company Portal app

### How to enroll Mac devices in MDM

While it isn't universally the best option, the most common enrollment method that IT will need to know is enrollment via a companion app. That method is tailored to BYOD, but Mac administrators can also use it for corporate-owned devices when there is no ABM available. In either case, the device is, by default, registered as a personal device in Microsoft Intune. Desktop admins can manually adjust this if needed. IT can perform the task of Mac enrollment using the Company Portal app through the following steps:



1\. Open a browser and navigate to Microsoft's [site](https://docs.microsoft.com/en-us/mem/intune/user-help/enroll-your-device-in-intune-macos-cp) to download the Company Portal installer file under the **Install Company Portal app**.

2\. After it's downloaded, open the installer and follow the prompts to ensure proper installation.

3\. Once the installation is successful, open the Company Portal app and sign in with a work or school account.

4\. Once signed in with the Company Portal app open, click **Begin** to start the enrollment process.

5\. On the **Review privacy information** page, verify the information that the organization can see and click **Continue** (Figure 1).

<figure><img src="https://www.techtarget.com/rms/onlineimages/mdm_mac_enrollment_1_mobile.jpg" alt="An image of the Company Portal app displaying the Mac&#x27;s privacy information." height="433" width="560"><figcaption><p>Figure 1. The privacy information that the IT department can and can't see on the managed Mac displayed in the Company Portal app.</p></figcaption></figure>

6\. On the **Install management profile** page, perform the following actions:

* Click on **Download profile** to download the management profile (Figure 2).
* On the **Manage Profile** settings page, click **Install** to install the management profile.
* On the verification dialog box, click **Install** to install the management profile.
* On the credentials dialog box, provide administrator credentials to start the enrollment.

<figure><img src="https://www.techtarget.com/rms/onlineimages/mdm_mac_enrollment_2_mobile.jpg" alt="An image of the downloadable management profile for Macs." height="415" width="560"><figcaption><p>Figure 2. The management profile within the Company Portal app that IT can download for Mac management.</p></figcaption></figure>

7\. On the **Check device settings** page, verify the enrollment and compliance status of the device and click **Done**.

Once the enrollment of the Mac device is complete, IT can navigate to the location **System Preferences** > **Profiles** > **Management Profile** to verify the level of control that the IT administrators have over the device.



***

## REFERENCES

* [https://learn.microsoft.com/en-us/intune/intune-service/user-help/enroll-your-device-in-intune-macos-cp](https://learn.microsoft.com/en-us/intune/intune-service/user-help/enroll-your-device-in-intune-macos-cp)
* [https://www.techtarget.com/searchenterprisedesktop/tip/How-to-enroll-and-manage-Mac-devices-with-Intune-MDM](https://www.techtarget.com/searchenterprisedesktop/tip/How-to-enroll-and-manage-Mac-devices-with-Intune-MDM)
