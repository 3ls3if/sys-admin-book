---
icon: expand
---

# Enable auto-expanding archiving

## How to Enable Auto-Expanding Archiving in Exchange Online (Step-by-Step Guide)

### Overview

Microsoft Exchange Online provides an **Auto-Expanding Archiving** feature that automatically increases archive mailbox storage when a user's archive mailbox becomes full.

Once enabled, Microsoft automatically provisions additional archive storage up to **1.5 TB**.

This feature is useful for:

* Long-term email retention
* Compliance and eDiscovery requirements
* Large mailboxes with retention policies
* Organizations using Microsoft Purview retention features

This article explains:

* What Auto-Expanding Archiving is
* Important limitations
* PowerShell commands required
* Real-world command examples
* How to verify the configuration
* Common mistakes and troubleshooting

***

## Important Notes Before Enabling

Before enabling Auto-Expanding Archiving, keep the following limitations in mind:

### 1. The Feature Cannot Be Disabled

After Auto-Expanding Archiving is enabled:

* It cannot be turned off
* Microsoft does not provide a rollback option

***

### 2. Archive Mailbox Must Already Exist

The user must already have an archive mailbox enabled.

You can verify using:

```powershell
Get-Mailbox user@domain.com | FL ArchiveStatus
```

If the archive is not enabled:

```powershell
Enable-Mailbox user@domain.com -Archive
```

***

### 3. Exchange Admin Center Cannot Enable It

Auto-Expanding Archiving can only be enabled using:

* Exchange Online PowerShell

It cannot be enabled from:

* Exchange Admin Center
* Microsoft Purview Portal

***

### 4. Additional Storage Is Provisioned Automatically

When the archive mailbox reaches approximately **90 GB**, Microsoft automatically provisions additional archive storage.

Provisioning can take:

* Up to 30 days

***

### 5. Shared Mailboxes Are Supported

Auto-expanding archives also work with:

* Shared mailboxes

***

## Connect to Exchange Online PowerShell

First connect to Exchange Online:

```powershell
Connect-ExchangeOnline -UserPrincipalName admin@tenant.onmicrosoft.com
```

Example:

```powershell
Connect-ExchangeOnline -UserPrincipalName admin@sandeepcsin.onmicrosoft.com
```

After connecting successfully, you will see the Exchange Online V3 module banner.

***

## Enable Auto-Expanding Archiving for Entire Organization

To enable the feature globally for all mailboxes:

```powershell
Set-OrganizationConfig -AutoExpandingArchive
```

### Important

Many administrators incorrectly try:

```powershell
Set-OrganizationConfig -AutoExpandingArchiveEnabled $true
```

This command fails because:

```powershell
-AutoExpandingArchiveEnabled
```

is not a valid parameter.

You must use:

```powershell
Set-OrganizationConfig -AutoExpandingArchive
```

#### Example Error

```powershell
Set-OrganizationConfig : A parameter cannot be found that matches parameter name 'AutoExpandingArchiveEnabled'.
```

***

## Enable Auto-Expanding Archiving for a Specific User

To enable it for a single mailbox:

```powershell
Enable-Mailbox user@domain.com -AutoExpandingArchive
```

Example:

```powershell
Enable-Mailbox sandeep@sandeep-cs.in -AutoExpandingArchive
```

When enabled successfully, Exchange returns mailbox information.

If already enabled, you will see:

```powershell
WARNING: Auto-expanding Archive is already enabled
```

***

## Verify Auto-Expanding Archiving Status

### Verify Organization-Wide Status

Run:

```powershell
Get-OrganizationConfig | FL AutoExpandingArchiveEnabled
```

Expected output:

```powershell
AutoExpandingArchiveEnabled : True
```

***

### Verify Specific Mailbox Status

Run:

```powershell
Get-Mailbox user@domain.com | FL AutoExpandingArchiveEnabled
```

Example:

```powershell
Get-Mailbox sandeep@example.com | FL AutoExpandingArchiveEnabled
```

Expected output:

```powershell
AutoExpandingArchiveEnabled : True
```

***

## Run Managed Folder Assistant

After enabling the archive, administrators commonly trigger the Managed Folder Assistant manually.

Commands:

```powershell
Start-ManagedFolderAssistant -Identity user@domain.com
```

Full crawl:

```powershell
Start-ManagedFolderAssistant -Identity user@domain.com -FullCrawl
```

Example:

```powershell
Start-ManagedFolderAssistant -Identity sandeep@example.com

Start-ManagedFolderAssistant -Identity sandeep@example.com -FullCrawl
```

This helps process:

* Retention policies
* Archive movement
* Mailbox cleanup
* Compliance actions

***

## Real-World PowerShell Session Example

```powershell
Connect-ExchangeOnline -UserPrincipalName admin@sandeepcsin.onmicrosoft.com

Set-OrganizationConfig -AutoExpandingArchive

Enable-Mailbox sandeep@sandeep-cs.in -AutoExpandingArchive

Get-OrganizationConfig | FL AutoExpandingArchiveEnabled

Get-Mailbox sandeep@sandeep-cs.in | FL AutoExpandingArchiveEnabled

Start-ManagedFolderAssistant -Identity sandeep@sandeep-cs.in

Start-ManagedFolderAssistant -Identity sandeep@sandeep-cs.in -FullCrawl
```

***

## Additional Information

### Archive Storage Limits

With Auto-Expanding Archiving:

* Initial archive size: 100 GB
* Auto expansion starts near 90 GB
* Maximum supported size: 1.5 TB

***

### Hybrid Exchange Environment Limitation

In Exchange Hybrid deployments:

* Organization-wide enablement is supported
* Per-user enablement may not work if:
  * Primary mailbox is on-premises
  * Archive mailbox is cloud-based

In such cases use:

```powershell
Set-OrganizationConfig -AutoExpandingArchive
```

instead of:

```powershell
Enable-Mailbox -AutoExpandingArchive
```

***

### Storage Provisioning Delay

Additional archive storage is not added immediately.

Microsoft states provisioning may take:

* Up to 30 days

***

## Troubleshooting

### Error: Parameter Cannot Be Found

#### Incorrect Command

```powershell
Set-OrganizationConfig -AutoExpandingArchiveEnabled $true
```

#### Correct Command

```powershell
Set-OrganizationConfig -AutoExpandingArchive
```

***

### AutoExpandingArchiveEnabled Shows False

Possible reasons:

* Archive mailbox not enabled
* Replication delay
* Mailbox not synchronized yet

Try:

```powershell
Enable-Mailbox user@domain.com -Archive
```

Then:

```powershell
Enable-Mailbox user@domain.com -AutoExpandingArchive
```

***

## Best Practices

* Enable archive mailboxes before enabling auto-expansion
* Apply retention policies properly
* Monitor mailbox growth regularly
* Use Managed Folder Assistant after policy changes
* Avoid using archive mailboxes for journaling purposes

***

## Conclusion

Microsoft Exchange Online Auto-Expanding Archiving is an excellent feature for organizations requiring long-term email retention and large archive storage.

The feature is simple to enable using Exchange Online PowerShell, but administrators must remember:

* The feature cannot be disabled later
* Archive mailboxes must already exist
* Correct PowerShell syntax is required
* Storage expansion may take time

The most important command is:

```powershell
Set-OrganizationConfig -AutoExpandingArchive
```

Once enabled successfully, Exchange Online automatically manages archive storage growth up to 1.5 TB.





***

## REFERENCES

* [https://learn.microsoft.com/en-us/purview/enable-autoexpanding-archiving](https://learn.microsoft.com/en-us/purview/enable-autoexpanding-archiving)
