---
icon: windows
---

# Powershell: Deleting Users in Microsoft 365

## Intro

In large Microsoft 365 environments, administrators often need to **bulk delete users**—whether due to offboarding, tenant cleanup, or automation. **Microsoft Graph PowerShell SDK** enables safe and controlled user deletion directly from the command line.

In this article, we'll walk through how to **delete users individually, in bulk, and with filters**, while preserving admin accounts and providing optional CSV logging.

## Prerequisites

Ensure you have the following:

* <mark style="color:green;">**Microsoft Graph PowerShell SDK**</mark> <mark style="color:green;"></mark><mark style="color:green;">installed</mark>
* <mark style="color:green;">**Global Administrator**</mark> <mark style="color:green;"></mark><mark style="color:green;">or appropriate role</mark>
* <mark style="color:green;">Permission scopes:</mark> <mark style="color:green;"></mark><mark style="color:green;">`User.ReadWrite.All`</mark><mark style="color:green;">,</mark> <mark style="color:green;"></mark><mark style="color:green;">`Directory.ReadWrite.All`</mark>

To install and connect to Microsoft Graph:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"
```

## Delete a Single User by Email or ID

#### By UserPrincipalName:

```powershell
Remove-MgUser -UserId "user@example.com"
```

#### By Object ID:

```powershell
Remove-MgUser -UserId "a12b34cd-5678-ef90-gh12-3456789ijklm"
```

{% hint style="warning" %}
⚠️ This performs a **soft delete** (user is recoverable for 30 days).
{% endhint %}

## Bulk Delete Users (Except Admin)

Here’s a safe script to delete **all users except a defined admin account**:

```powershell
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Define your tenant admin's email
$adminUser = Get-MgUser -UserId "admin@yourdomain.com"
$adminId = $adminUser.Id

# Fetch all users
$allUsers = Get-MgUser -All

# Filter out the admin
$usersToDelete = $allUsers | Where-Object { $_.Id -ne $adminId }

# Optional: Export list before deletion
$usersToDelete | Select DisplayName, UserPrincipalName, Id | Export-Csv -Path "UsersToDelete.csv" -NoTypeInformation

# Confirm before deletion
Write-Host "Total users to delete: $($usersToDelete.Count)" -ForegroundColor Yellow
$confirm = Read-Host "Type YES to confirm deletion"

if ($confirm -eq "YES") {
    foreach ($user in $usersToDelete) {
        Write-Host "Deleting user: $($user.UserPrincipalName)" -ForegroundColor Red
        Remove-MgUser -UserId $user.Id -Confirm:$false
    }
    Write-Host "✅ Deletion completed." -ForegroundColor Green
} else {
    Write-Host "❌ Deletion canceled." -ForegroundColor Red
}
```

## Targeted Deletion Examples

#### Delete users from a specific domain:

```powershell
$usersToDelete = Get-MgUser -All | Where-Object {
    $_.UserPrincipalName -like "*@oldcompany.com"
}
```

#### Delete unlicensed users only:

```powershell
$usersToDelete = Get-MgUser -All | Where-Object {
    ($_.AssignedLicenses).Count -eq 0
}
```

## Optional: Hard Delete from the Recycle Bin

After 30 days, or to manually remove users from soft-delete:

```powershell
$deletedUsers = Get-MgUserDeleted
foreach ($user in $deletedUsers) {
    Remove-MgUserDeleted -UserId $user.Id
}
```

## Summary

Microsoft Graph PowerShell enables full control over M365 identity management, including safe user deletion. Whether you're removing one user or cleaning up thousands, PowerShell scripts offer automation, accuracy, and safety when used responsibly.

***

## REFERENCES

* [https://learn.microsoft.com/en-us/graph/overview](https://learn.microsoft.com/en-us/graph/overview)
* [https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide](https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide)
* [https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide](https://learn.microsoft.com/en-us/microsoft-365/enterprise/manage-microsoft-365-with-microsoft-365-powershell?view=o365-worldwide)
* [https://learn.microsoft.com/en-us/power-platform/admin/wp-task-automation-powershell](https://learn.microsoft.com/en-us/power-platform/admin/wp-task-automation-powershell)
* [https://www.syskit.com/blog/powershell-automation-for-m365-admin-tasks/](https://www.syskit.com/blog/powershell-automation-for-m365-admin-tasks/)
