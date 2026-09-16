---
icon: microsoft
---

# How to Allow APK File Attachments in Microsoft 365 Exchange Online

## Overview

Microsoft 365 Exchange Online includes attachment filtering that blocks certain potentially dangerous file types. Android application package files (`.apk`) can be blocked by the **Common Attachment Types Filter**.

When an APK attachment is rejected, the sender may receive an error similar to:

```text
550 5.0.350 One or more of the attachments in your email is of a file type that is NOT allowed by the recipient's organization.
```

This article explains how to allow `.apk` attachments using both the **Microsoft Defender portal GUI** and **Exchange Online PowerShell**.

> **Important:** If the error says the attachment is not allowed by the **recipient's organization**, the change must be made in the recipient's Microsoft 365 tenant. Changing the sender's tenant will not override the recipient's attachment policy.

---

## Prerequisites

Before making the change, ensure that you have:

- Microsoft 365 administrator access.
- Appropriate Exchange Online / Microsoft Defender permissions.
- Access to the tenant where the attachment is being blocked.
- Exchange Online PowerShell access if using the PowerShell method.

---

# Method 1: Allow APK Using the Microsoft Defender GUI

## Step 1: Open Microsoft Defender

Sign in to the Microsoft Defender portal with an account that has the required administrative permissions.

Navigate to:

**Email & collaboration → Policies & rules → Threat policies**

---

## Step 2: Open Anti-malware Policies

Under **Policies**, select:

**Anti-malware**

Open the anti-malware policy that applies to the affected recipients.

If the default configuration is being used, open the **Default** policy.

> If your organization has multiple custom anti-malware policies, identify the policy that actually applies to the affected users before making changes.

---

## Step 3: Locate the Common Attachment Types Filter

Open the applicable anti-malware policy and locate:

**Common Attachment Types Filter**

This setting controls filtering for common potentially dangerous attachment file types.

Click **Edit** if the policy allows the setting to be modified.

---

## Step 4: Locate APK

Review the configured file-type list.

Search for:

```text
apk
```

or:

```text
.apk
```

If APK is included in the blocked file-type list, remove or unselect it.

---

## Step 5: Save the Policy

Click:

**Save**

Allow some time for the policy change to propagate through Microsoft 365.

---

## Step 6: Test APK Delivery

Send a test email containing an APK file, for example:

```text
MyApplication.apk
```

Verify that the message reaches the recipient successfully.

---

# Method 2: Allow APK Using Exchange Online PowerShell

PowerShell can be used to inspect and modify the Exchange Online malware filter configuration.

## Step 1: Install the Exchange Online Module

If the Exchange Online Management module is not already installed, run:

```powershell
Install-Module ExchangeOnlineManagement
```

If prompted, confirm the installation.

---

## Step 2: Connect to Exchange Online

Run:

```powershell
Connect-ExchangeOnline
```

Sign in with an account that has the required Exchange Online permissions.

---

## Step 3: Check the Current Malware Filter Policy

For the default policy, run:

```powershell
Get-MalwareFilterPolicy -Identity Default |
Format-List EnableFileFilter,FileTypeAction,FileTypes
```

Review the output.

For example:

```text
EnableFileFilter : True
FileTypeAction   : Reject
FileTypes        : {ace, ani, apk, app, ...}
```

If `apk` appears in `FileTypes`, it is included in the file-type filtering configuration.

---

## Step 4: Remove Only APK From the File-Type List

To remove only `apk` while preserving the other configured file types, run:

```powershell
$policy = Get-MalwareFilterPolicy -Identity Default

$fileTypes = [System.Collections.ArrayList]$policy.FileTypes

$fileTypes.Remove("apk")

Set-MalwareFilterPolicy -Identity Default -FileTypes $fileTypes
```

This modifies the existing list instead of replacing the complete list of blocked file types.

---

## Step 5: Verify the Change

Run:

```powershell
Get-MalwareFilterPolicy -Identity Default |
Format-List EnableFileFilter,FileTypeAction,FileTypes
```

Confirm that:

```text
apk
```

is no longer present in the `FileTypes` output.

---

# Check All Malware Filter Policies

If APK is still being blocked, the recipient may be covered by another custom anti-malware policy.

Run:

```powershell
Get-MalwareFilterPolicy |
Select-Object Name,EnableFileFilter,FileTypeAction,FileTypes
```

Review all policies and check whether `apk` is present.

You can also check the associated rules:

```powershell
Get-MalwareFilterRule |
Format-Table Name,Priority,State,MalwareFilterPolicy
```

This helps identify which malware filter policy applies to a particular recipient.

---

# Verify the Email Using Message Trace

After changing the policy, send another test message with the APK attachment.

Use the Exchange admin center:

**Exchange admin center → Mail flow → Message trace**

Search for the test message and review its delivery status.

You can also investigate message events in Microsoft Defender where available:

**Microsoft Defender → Email & collaboration → Explorer**

Check whether the message was delivered, rejected, quarantined, or otherwise filtered.

---

# Troubleshooting

## 1. APK Is Still Being Blocked

Check all malware filter policies:

```powershell
Get-MalwareFilterPolicy |
Select Name,EnableFileFilter,FileTypeAction,FileTypes
```

Look for:

```text
apk
```

in any applicable policy.

Then check the policy rules:

```powershell
Get-MalwareFilterRule |
Format-Table Name,Priority,State,MalwareFilterPolicy
```

---

## 2. The Recipient Is in Another Organization

Consider this scenario:

```text
Company A
   |
   | Email + MyApplication.apk
   ↓
Company B
   |
   X Attachment rejected
```

If Company B's Microsoft 365 tenant rejects the APK, the administrator of Company A cannot change Company B's attachment filtering policy.

The administrator of **Company B** must review its Exchange Online / Microsoft Defender attachment filtering configuration.

The phrase:

```text
recipient's organization
```

in the NDR is an important indication that the rejection may be occurring on the recipient side.

---

## 3. Safe Sender Does Not Resolve the Issue

Adding a sender to a safe sender or allow list does not necessarily resolve a file-type filtering rejection.

If the message is being rejected because the attachment type is blocked, investigate the **Common Attachment Types Filter** and the applicable anti-malware policy.

---

# Do Not Disable the Entire Attachment Filter

It is possible to disable file filtering completely:

```powershell
Set-MalwareFilterPolicy -Identity Default -EnableFileFilter $false
```

However, this is not recommended simply to allow APK files.

Disabling the filter can reduce protection against other potentially dangerous attachment types.

A more controlled approach is to remove only the required file extension:

```text
Remove:
    apk

Keep:
    exe
    dll
    js
    vbs
    bat
    cmd
    and other required blocked types
```

---

# Security Considerations

APK files are Android application packages and can contain executable application code.

Before allowing APK files through email, consider:

- Whether users actually require APK attachments.
- Whether APK files should be distributed through email.
- Whether the APK files are internally developed applications.
- Whether applications are digitally signed.
- Whether APK files are scanned before distribution.
- Whether OneDrive, SharePoint, or another controlled file-sharing platform would be more appropriate.
- Whether access to APK files should be limited to specific users or groups.

For organizations with strict security requirements, controlled file-sharing or software distribution can be preferable to allowing application packages through email.

---

# Recommended Change Procedure

Use the following process when implementing the change in production:

```text
Identify the rejection
        ↓
Confirm the recipient tenant
        ↓
Check Message Trace
        ↓
Identify the applicable anti-malware policy
        ↓
Check the Common Attachment Types Filter
        ↓
Confirm APK is blocked
        ↓
Remove only APK
        ↓
Save the policy
        ↓
Allow time for policy propagation
        ↓
Send a controlled test
        ↓
Verify Message Trace
        ↓
Confirm successful delivery
```

---

# Useful PowerShell Commands

## Connect to Exchange Online

```powershell
Connect-ExchangeOnline
```

## View the Default Malware Filter Policy

```powershell
Get-MalwareFilterPolicy -Identity Default |
Format-List EnableFileFilter,FileTypeAction,FileTypes
```

## View All Malware Filter Policies

```powershell
Get-MalwareFilterPolicy |
Select-Object Name,EnableFileFilter,FileTypeAction,FileTypes
```

## View Malware Filter Rules

```powershell
Get-MalwareFilterRule |
Format-Table Name,Priority,State,MalwareFilterPolicy
```

## Remove APK From the Default Policy

```powershell
$policy = Get-MalwareFilterPolicy -Identity Default

$fileTypes = [System.Collections.ArrayList]$policy.FileTypes

$fileTypes.Remove("apk")

Set-MalwareFilterPolicy -Identity Default -FileTypes $fileTypes
```

## Verify the Configuration

```powershell
Get-MalwareFilterPolicy -Identity Default |
Format-List EnableFileFilter,FileTypeAction,FileTypes
```

---

# Conclusion

Exchange Online can block `.apk` attachments through its attachment filtering and malware protection mechanisms.

Administrators can investigate and manage the configuration through either:

### GUI

```text
Microsoft Defender
→ Email & collaboration
→ Policies & rules
→ Threat policies
→ Anti-malware
→ Applicable policy
→ Common Attachment Types Filter
```

### PowerShell

```powershell
Connect-ExchangeOnline
```

followed by inspection and modification of the applicable malware filter policy.

The preferred approach is to **allow only the required file type rather than disabling attachment filtering completely**.

Finally, always verify which Microsoft 365 tenant is rejecting the message. If the NDR states that the attachment is not allowed by the **recipient's organization**, the recipient's Microsoft 365 administrator needs to make the required change.
