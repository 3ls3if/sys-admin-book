---
icon: windows
---

# Azure AD Connect: Install and Setup Guide

The **Azure AD Connect** tool has been renamed to **Microsoft Entra Connect** as part of Microsoft’s transition from Azure Active Directory to Microsoft Entra ID.

Microsoft Entra Connect allows you to sync your on-premises Active Directory users to Microsoft 365. Your users will then be able to use their on-premises user id and password to log onto computers on your network as well as Microsoft 365.&#x20;

NOTE: This article assumes you already have an on-premises Active Directory domain and a Microsoft 365 tenant.



### Requirements for **Microsoft Entra Connect** <a href="#requirements" id="requirements"></a>

There are several requirements for using Azure AD Connect, and I have summarized them below.

1. You need a Microsoft Entra tenant.
2. Your on-premises AD domain needs to have a routable domain, or the user accounts need a registered UPN suffix that matches the verified domain in your tenant. For example, if your on-premises domain is .local then you have a problem. This is not a routable domain and will be different from your registered Entra tenant.
3. Must be installed on a domain joined server that runs Windows Server 2022, 2019 or 2016.
4. The Active Directory schema version and forest functional level must be Windows Server 2003 or higher.
5. The domain controller used by the Entra connect must be writable.
6. Windows Server full GUI



### Download Microsoft Entra Connect <a href="#download" id="download"></a>

The Microsoft Entra Connect tool is only available from the Admin Center.

**Step 1**. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/)

**Step 2**. Expand Entra ID and then Entra Connect

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-2.webp" alt="click entra connect" height="329" width="284"><figcaption></figcaption></figure>

**Step 3**. Click on “Connect Sync” and “Download the latest Entra Connect Sync Version”. This will download the AzureADConnect.msi install file.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-3.webp" alt="download entra connect sync" height="518" width="957"><figcaption></figcaption></figure>

**Step 4**. Click on **Accept terms & download**

The .msi file (AzureADConnect.msi) should then automatically download.



### Install and configure Microsoft Entra Connect <a href="#install" id="install"></a>

**Step 1**. Run the AzureADConnect.msi file

**Step 2**. Agree to the license terms and click “Continue”.

**Step 3**. Click on “Customize” for the custom install. This will give you more options and allow you to choose the best options.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-4.webp" alt="click customize" height="625" width="882"><figcaption></figcaption></figure>

Refer to the [Select your installation type](https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/how-to-connect-install-select-installation) document for more details.

**Step 4.** On the **Install required components screen**, make your selection and click “Install”. In most cases you will not need to select anything on this screen.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-5.webp" alt="install required components" height="624" width="884"><figcaption></figcaption></figure>

**Step 5**. On the **User sign-in screen**, select your sign on method and click “Next”. In most cases Password Hash Synchronization is used.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-6.webp" alt="user sign in" height="624" width="882"><figcaption></figcaption></figure>

**Step 6**. Enter your Entra ID account that has global administrator role and click “Next”.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-7.webp" alt="connect to Microsoft id" height="621" width="879"><figcaption></figcaption></figure>

You will be prompted to sign in with your Microsoft account.

Step 7. On the **Connect your directories** screen, under FORES&#x54;**,** select your directory and click “Add Directory”.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-8.webp" alt="connect your directories" height="623" width="882"><figcaption></figcaption></figure>

**Step 8**. Select “Create new AD account” and fill in the box with an account that has enterprise admin permissions. Then click “OK”.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-9-1.webp" alt="create new ad account" height="481" width="604"><figcaption></figcaption></figure>

By default, the install creates an account in your **on-premises Active Directory** named:

```
MSOL_<random characters>
```

The account is placed in the **Users container** by default (not in an OU). Here is a screenshot of the account that was created in my AD.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-ad-connect.png" alt="" height="47" width="573"><figcaption></figcaption></figure>

Configured Directories should now be listed. Click “next”.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-10.webp" alt="configured directories" height="625" width="881"><figcaption></figcaption></figure>

**Step 9**. The **Microsoft Entra Sign-in Configuration** screen.

This screen is very important! To sign-in to Office 365 with the same credentials as your on-premises AD, a matching Microsoft Entra ID domain is required. Your on-premises AD should have a UPN suffix that is also a verified domain in Entra. Typically, the on-premises userPrincipalName attribute is used as the Microsoft Entra ID username.

Select “Continue without matching all UPN suffixes to verified domains” and click “Next”.

You will have suffixes in your on-premises AD that do not need verified such as a subdomain or a .local domain. You can see in my screenshot below I have a verified domain “activedirectorypro.com” and one that is not verified.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-11.webp" alt="microsoft entra sign in configuration" height="623" width="882"><figcaption></figcaption></figure>

**Step 10**. On the Domain and OU filtering screen choose to sync all domains and OUs or choose to select specific domains and OUs. I have a lot of test accounts in my domain so I will choose to select specific OUs. You can always go back and change the filtering options.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-12.webp" alt="domain and ou filtering" height="623" width="880"><figcaption></figcaption></figure>

**Step 11**. On the **Uniquely identify your users** screen, select how users should be identified in your on-premises directories and select how users should be identified with Microsoft Entra ID. Click Next.

I’m leaving the default options selected.

<figure><img src="data:image/svg+xml,%3Csvg%20xmlns=&#x27;http://www.w3.org/2000/svg&#x27;%20width=&#x27;878&#x27;%20height=&#x27;625&#x27;%20viewBox=&#x27;0%200%20878%20625&#x27;%3E%3C/svg%3E" alt="identifying users" height="625" width="878"><figcaption></figcaption></figure>

**Step 12**. On the **Filter users and devices** screen select your option and click Next. The default selection (Synchronize all users and devices) is recommended unless you are testing or creating a pilot deployment.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-14.webp" alt="filter users and devices" height="623" width="881"><figcaption></figcaption></figure>

**Step 13**. On the Optional features screen select your options and click “Next”. I’m leaving the default; you can come back later and add options as needed.

<figure><img src="data:image/svg+xml,%3Csvg%20xmlns=&#x27;http://www.w3.org/2000/svg&#x27;%20width=&#x27;883&#x27;%20height=&#x27;625&#x27;%20viewBox=&#x27;0%200%20883%20625&#x27;%3E%3C/svg%3E" alt="optional install features" height="625" width="883"><figcaption></figcaption></figure>

**Step 14**. Select “Start the synchronization process when configuration completes”. Click “Install”**.**

<figure><img src="data:image/svg+xml,%3Csvg%20xmlns=&#x27;http://www.w3.org/2000/svg&#x27;%20width=&#x27;884&#x27;%20height=&#x27;623&#x27;%20viewBox=&#x27;0%200%20884%20623&#x27;%3E%3C/svg%3E" alt="click install" height="623" width="884"><figcaption></figcaption></figure>

The installation can take several minutes to complete.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-17.webp" alt="configuration complete" height="625" width="881"><figcaption></figcaption></figure>

If you get a message that says “The Active Directory Recycle Bin is not enabled for your forest” then I highly recommend you enable it. See my article [enable ad recycle bin](https://activedirectorypro.com/enable-active-directory-recycle-bin-server-2016/) for step by step instructions.



<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-install-17.webp" alt="configuration complete" height="625" width="881"><figcaption></figcaption></figure>

If you get a message that says “The Active Directory Recycle Bin is not enabled for your forest” then I highly recommend you enable it. See my article [enable ad recycle bin](https://activedirectorypro.com/enable-active-directory-recycle-bin-server-2016/) for step by step instructions.

### How to Check Entra Connect Sync Status <a href="#verify-sync" id="verify-sync"></a>

You can view the sync status by logging into the [Microsoft Entra admin center](https://entra.microsoft.com/), click on “Entra Connect” in the side bar menu and then click on “Connect Sync.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2023/08/entra-connect-sync-status.webp" alt="check entra status" height="540" width="1018"><figcaption></figcaption></figure>

<br>

***

## REFERENCES

* [https://activedirectorypro.com/azure-ad-connect-install-setup-guide/](https://activedirectorypro.com/azure-ad-connect-install-setup-guide/)
