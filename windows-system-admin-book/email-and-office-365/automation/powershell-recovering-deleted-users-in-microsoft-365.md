---
icon: windows
---

# Powershell: Recovering Deleted Users in Microsoft 365

## Intro

**Microsoft 365 (M365)** provides a soft-delete feature for user accounts, allowing administrators to **recover accidentally deleted users** within a **30-day retention window**. This feature can be crucial in avoiding data loss or service disruption in enterprise environments.

In this article, we'll walk through how to view, restore, and manage deleted users in M365 using **Microsoft Graph PowerShell**.

## <mark style="color:purple;">Prerequisites</mark>

Before proceeding, ensure the following:

* <mark style="color:green;">You have</mark> <mark style="color:green;"></mark><mark style="color:green;">**Microsoft Graph PowerShell SDK**</mark> <mark style="color:green;"></mark><mark style="color:green;">installed.</mark>
* <mark style="color:green;">You are signed in with sufficient privileges (typically a</mark> <mark style="color:green;"></mark><mark style="color:green;">**Global Admin**</mark><mark style="color:green;">).</mark>
* <mark style="color:green;">The deleted users are within the</mark> <mark style="color:green;"></mark><mark style="color:green;">**30-day soft-delete window**</mark><mark style="color:green;">.</mark>

To install the Microsoft Graph module (if not already installed):

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

To connect to Microsoft Graph:

```powershell
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"
```

## <mark style="color:purple;">View Deleted Users</mark>

To list all users currently in the deleted state:

```powershell
Get-MgUserDeleted
```

You can format this output to show key properties:

```powershell
Get-MgUserDeleted | Select-Object DisplayName, UserPrincipalName, Id
```

## <mark style="color:purple;">Restore a Deleted User</mark>

To restore a single user using their **UserPrincipalName** (email address):

```powershell
$deletedUser = Get-MgUserDeleted | Where-Object { $_.UserPrincipalName -eq "john.doe@yourdomain.com" }
Restore-MgUser -UserId $deletedUser.Id
```

If you already know the Object ID of the deleted user, restore them directly:

```powershell
Restore-MgUser -UserId "a12b34cd-5678-ef90-gh12-3456789ijklm"
```

## <mark style="color:purple;">Restore All Deleted Users (Use with Caution)</mark>

To restore **all soft-deleted users**, run:

```powershell
$deletedUsers = Get-MgUserDeleted

foreach ($user in $deletedUsers) {
    Write-Host "Restoring: $($user.UserPrincipalName)" -ForegroundColor Yellow
    Restore-MgUser -UserId $user.Id
}
```

{% hint style="warning" %}
⚠️ This should be used carefully in large environments to avoid restoring unintended users.
{% endhint %}

## Permanently Delete a Soft-Deleted User (Hard Delete)

If you want to **completely remove** a soft-deleted user:

```powershell
Remove-MgUserDeleted -UserId "<deleted-user-id>"
```

This action **cannot be undone**.

## Summary

Microsoft 365’s soft delete feature allows for quick recovery of users via PowerShell. By leveraging `Get-MgUserDeleted` and `Restore-MgUser`, administrators can efficiently manage accidental deletions. Understanding how to use these tools ensures resilience and continuity in your organization's identity management.

***

## REFERENCES

* [https://learn.microsoft.com/en-us/graph/overview](https://learn.microsoft.com/en-us/graph/overview)
* [https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide](https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide)
* [https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide](https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide)
* [https://learn.microsoft.com/en-us/power-platform/admin/wp-task-automation-powershell](https://learn.microsoft.com/en-us/power-platform/admin/wp-task-automation-powershell)
* [https://www.syskit.com/blog/powershell-automation-for-m365-admin-tasks/](https://www.syskit.com/blog/powershell-automation-for-m365-admin-tasks/)
