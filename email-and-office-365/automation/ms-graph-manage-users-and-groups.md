---
icon: user-magnifying-glass
---

# MS-Graph: Manage Users and Groups

## Commands

```powershell
Get-ExecutionPolicy
EXPLANATION: Displays the current PowerShell script execution policy (e.g., Restricted, RemoteSigned, Bypass). This determines what types of scripts are allowed to run.

Set-ExecutionPolicy -ExecutionPolicy Bypass
EXPLANATION: Temporarily sets the script execution policy to Bypass, allowing all scripts to run without prompts or warnings.

Connect-MgGraph -Scopes "Group.ReadWrite.All", "User.ReadWrite.All"
EXPLANATION: Connects to Microsoft Graph with delegated permissions to read/write both users and groups.

Get-MgUser -All
EXPLANATION: Retrieves a list of all user accounts in Microsoft Entra ID (formerly Azure AD).

New-MgUser -AccountEnabled:$true -DisplayName "Justin Blakely" -MailNickname "justinblakely" -UserPrincipalName "justinblakely@examlabpractice.com" -PasswordProfile @{ ForceChangePasswordNextSignIn = $true; Password = "P@ssword123!" }
EXPLANATION: Creates a new Entra ID user with the specified display name, login details, and a temporary password that must be changed at first sign-in.

Remove-MgUser -UserId (Get-MgUser -Filter "userPrincipalName eq 'justinblakely@examlabpractice.com'").Id -Confirm:$false
EXPLANATION: Delete the user name Justin Blakeyly

Create a users.csv file:

DisplayName,MailNickname,UserPrincipalName
Justin Blakely,justinblakely,justinblakely@examlabpractice.com
Sarah Lee,sarahlee,sarah.lee@examlabpractice.com
Robert Kim,robertkim,robert.kim@examlabpractice.com
EXPLANATION: Creates a CSV file with user info to be used in bulk user creation.

$PasswordProfile = @{ Password = "P@ssword123!"; ForceChangePasswordNextSignIn = $true }
EXPLANATION: Defines a password profile for new users, requiring them to change their password at next sign-in.

Import-Csv -Path ".\users.csv" | ForEach-Object { New-MgUser -AccountEnabled:$true -DisplayName $_.DisplayName -MailNickname $_.MailNickname -UserPrincipalName $_.UserPrincipalName -PasswordProfile $PasswordProfile }
EXPLANATION: Reads the users.csv file and creates a new user for each row using the shared password profile.

Import-Csv -Path ".\users.csv" | ForEach-Object { $user = Get-MgUser -Filter "userPrincipalName eq '$($_.UserPrincipalName)'"; if ($user) { Remove-MgUser -UserId $user.Id -Confirm:$false } }
EXPLANATION: Reads the users.csv file and deletes each user listed if they exist, skipping confirmation prompts.

Get-MgSubscribedSku
EXPLANATION: Lists all the license SKUs available in your tenant, including ID and usage data.

Get-MgSubscribedSku | Select-Object SkuPartNumber, SkuId, ConsumedUnits, PrepaidUnits
EXPLANATION: Displays only key fields (SKU name, ID, number used, and number purchased) from the license list.

Set-MgUserLicense -UserId "justinblakely@examlabpractice.com" -AddLicenses @{SkuId = "06ebc4ee-1bb5-47dd-8120-11324bc54e06"} -RemoveLicenses @()
EXPLANATION: Assigns a Microsoft 365 license to the specified user using the license’s SKU ID.

Set-MgUserLicense -UserId "jc@examlabpractice.com" -AddLicenses @{SkuId = "06ebc4ee-1bb5-47dd-8120-11324bc54e06"} -RemoveLicenses @()
EXPLANATION: Same as above, but for a different user (jc@examlabpractice.com).

New-MgGroup -DisplayName "Test Group" -MailEnabled:$true -MailNickname "testgroup" -SecurityEnabled:$false -GroupTypes @("Unified")
EXPLANATION: Creates a Microsoft 365 Group (not a security group) with mail capabilities and Teams/SharePoint integration.

New-MgGroupMemberByRef
EXPLANATION: Adds a member to a group using a reference to the user's object ID (requires more parameters in practice).
```



## REFERENCES

* [https://m365scripts.com/microsoft365/manage-microsoft-365-users-microsoft-graph-powershell/](https://m365scripts.com/microsoft365/manage-microsoft-365-users-microsoft-graph-powershell/)
