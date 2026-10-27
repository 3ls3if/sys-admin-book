---
icon: question
---

# Delete all the guest users from m365 tenant

Below is a **safe and commonly used PowerShell script** to **delete all Guest users** from a Microsoft 365 (Entra ID / Azure AD) tenant.

⚠️ **Important warning**\
This action is **irreversible**. All Guest users (`UserType = Guest`) will be permanently deleted.\
It’s strongly recommended to **export the list first** or run in **WhatIf** mode.

***

### ✅ Prerequisites

* Role: **Global Administrator** or **User Administrator**
* PowerShell 7+ recommended
* Module: **Microsoft Graph PowerShell**

#### Install the module (if not installed)

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

***

### ✅ Step 1: Connect to Microsoft Graph

```powershell
Connect-MgGraph -Scopes "User.ReadWrite.All"
```

***

### ✅ Step 2 (Optional but Recommended): Export Guest Users to CSV

```powershell
Get-MgUser -Filter "userType eq 'Guest'" -All |
Select DisplayName, UserPrincipalName, Id |
Export-Csv "GuestUsers_Backup.csv" -NoTypeInformation
```

***

### ✅ Step 3: Delete All Guest Users

#### 🔹 Dry Run (Recommended first)

```powershell
Get-MgUser -Filter "userType eq 'Guest'" -All |
ForEach-Object {
    Write-Host "Would delete:" $_.UserPrincipalName
}
```

#### 🔹 Actual Deletion

```powershell
Get-MgUser -Filter "userType eq 'Guest'" -All |
ForEach-Object {
    Write-Host "Deleting:" $_.UserPrincipalName
    Remove-MgUser -UserId $_.Id -Confirm:$false
}
```

***

### ✅ Step 4: Verify

```powershell
Get-MgUser -Filter "userType eq 'Guest'" -All
```

If nothing returns, all Guest users are deleted.

***

### 🔒 Safety Enhancements (Optional)

#### Exclude specific domains

```powershell
Get-MgUser -Filter "userType eq 'Guest'" -All |
Where-Object { $_.UserPrincipalName -notlike "*trustedpartner.com*" } |
ForEach-Object {
    Remove-MgUser -UserId $_.Id -Confirm:$false
}
```

#### Exclude specific users

```powershell
$ExcludeUsers = @("guest1@domain.com","guest2@domain.com")

Get-MgUser -Filter "userType eq 'Guest'" -All |
Where-Object { $ExcludeUsers -notcontains $_.UserPrincipalName } |
ForEach-Object {
    Remove-MgUser -UserId $_.Id -Confirm:$false
}
```

***

### 📝 Notes

* Deleted users can be restored within **30 days** from **Deleted Users** in Entra ID
* This does **not** delete external users from their home tenants
* Best practice: Run during a maintenance window
