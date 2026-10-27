---
icon: envelope-open-dollar
---

# How to Enable “Send From Alias” in Microsoft 365 (Exchange Online)

## How to Enable “Send From Alias” in Microsoft 365 (Exchange Online)

Microsoft 365 allows users to have multiple email aliases on a single mailbox. By default, users can **receive** email on those aliases — but they cannot **send** from them unless the feature is enabled at the tenant level.

This article explains what Send From Alias is, why you might use it, and how to enable it across your Microsoft 365 tenant using Exchange Online PowerShell.

***

### What Is Send From Alias?

In Microsoft 365 (formerly Office 365), users can have multiple SMTP addresses (aliases) assigned to one mailbox in Exchange Online.

Example:

* Primary address: john@company.com
* Alias: sales@company.com
* Alias: info@company.com

Without Send From Alias enabled:

* The user can **receive** messages sent to those aliases.
* The user **cannot send** email as those aliases.

After enabling Send From Alias:

* Users can send mail directly from any configured alias.

***

### Prerequisites

You must:

* Be a **Global Administrator** or **Exchange Administrator**
* Have the Exchange Online PowerShell module installed
* Have PowerShell execution policy configured appropriately (e.g., RemoteSigned)

***

## Step 1: Connect to Exchange Online

Install the module (if needed):

```powershell
Install-Module ExchangeOnlineManagement
```

Import and connect:

```powershell
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline
```

Sign in with your admin credentials when prompted.

***

## Step 2: Enable Send From Alias for the Entire Tenant

Run the following command:

```powershell
Set-OrganizationConfig -SendFromAliasEnabled $True
```

If successful, **PowerShell** will return no error.

This setting applies to the entire Microsoft 365 tenant.

***

## Step 3: Verify the Setting

Confirm the feature is enabled:

```powershell
Get-OrganizationConfig | ft SendFromAliasEnabled
```

Expected output:

```
SendFromAliasEnabled
--------------------
True
```

If it shows `True`, the feature is active.

***

## Step 4: Test the Feature

After enabling:

1. Open Outlook (Desktop or Web).
2. Compose a new email.
3. Click **From**.
4. Select **Other Email Address**.
5. Enter the alias address.

The email should now send successfully from that alias.

***

### Important Notes

* The alias must already be added to the mailbox.
* It may take several minutes for the setting to propagate.
* Outlook may need to be restarted.
* Older Outlook versions may not fully support this feature.

***

### How to Disable It (If Needed)

To turn it off:

```powershell
Set-OrganizationConfig -SendFromAliasEnabled $False
```

***

### Summary

Enabling Send From Alias in Microsoft 365 allows users to:

* Send from multiple email identities
* Maintain one mailbox
* Improve flexibility for departments and shared functions

This is a tenant-wide configuration and must be done through Exchange Online PowerShell.



***

