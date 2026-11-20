---
icon: users
---

# How to Convert a Microsoft 365 Guest User to a Member in Microsoft Entra ID

### 1. Introduction

Microsoft Entra ID supports external collaboration through its Business-to-Business (B2B) feature. This allows organizations to invite external users as Guest accounts so they can access shared resources such as Microsoft Teams, SharePoint Online, and other Microsoft 365 services.

However, there are scenarios where an organization needs to convert an existing Guest account into an internal Member account.

For example:

* An external collaborator becomes a permanent employee.
* A guest user needs to access internal organizational resources.
* An organization wants to manage authentication through its own Microsoft Entra ID tenant.
* A user requires a permanent organizational identity instead of external B2B authentication.

Microsoft Entra ID provides a built-in option to convert an external Guest user into an internal Member user without having to delete and recreate the account.

This article explains how to perform this conversion using the Microsoft Entra admin center and Microsoft Graph PowerShell.

### 2. Prerequisites

Before performing the conversion, ensure the following requirements are met:

| Requirement                | Description                                                     |
| -------------------------- | --------------------------------------------------------------- |
| Administrative permissions | User Administrator or an appropriate higher-privileged role     |
| Microsoft Entra ID access  | Access to the Microsoft Entra admin center                      |
| Guest account status       | The B2B invitation should have been accepted                    |
| Domain                     | A verified custom domain or the tenant's onmicrosoft.com domain |
| PowerShell                 | Microsoft Graph PowerShell modules for scripted conversions     |

**Important:** If the account is synchronized from an on-premises Active Directory environment, review the identity source and synchronization configuration before proceeding.

### 3. Method 1: Convert Guest User Using Microsoft Entra Admin Center

This method is recommended when converting an individual Guest account.

#### Step 1: Sign in to Microsoft Entra Admin Center

1. Open [https://entra.microsoft.com](https://entra.microsoft.com).
2. Sign in using an account with the required administrative permissions.
3.  Navigate to:

    **Identity → Users → All users**

#### Step 2: Select the Guest User

1. Locate the Guest account you want to convert.
2. Select the user account.
3. Open the **Overview** section.
4.  Under the B2B collaboration section, locate the option:

    **Convert to internal user**

#### Step 3: Configure the Internal User Account

After selecting the conversion option:

1. Provide the new User Principal Name (UPN).
2. Select the appropriate tenant domain.
3. Configure a password for the internal account.
4. Review the email address and other available account details.

Example:

| Attribute      | Before Conversion                              | After Conversion                            |
| -------------- | ---------------------------------------------- | ------------------------------------------- |
| User Type      | Guest                                          | Member                                      |
| UPN            | user\_external.com#EXT#@tenant.onmicrosoft.com | [user@company.com](mailto:user@company.com) |
| Authentication | External identity provider                     | Internal tenant identity                    |
| Account        | B2B Guest                                      | Internal Member                             |

#### Step 4: Complete the Conversion

1. Review the configured account details.
2. Click **Convert**.
3. Wait for Microsoft Entra ID to complete the operation.
4. Return to the user's Overview page.
5. Verify that the User Type is now displayed as **Member**.

The account has now been converted into an internal Microsoft Entra ID user.

### 4. Method 2: Convert Guest User Using Microsoft Graph PowerShell

For administrators managing multiple users, Microsoft Graph PowerShell provides a scripting-based approach.

This method is useful for bulk operations and automation.

#### Step 1: Install Microsoft Graph PowerShell

Open PowerShell with administrative privileges and execute:

```
Install-Module Microsoft.Graph -Scope CurrentUser
```

If the module is already installed, update it when required.

#### Step 2: Connect to Microsoft Graph

Import the required module and authenticate:

```
Import-Module Microsoft.Graph

Connect-MgGraph -Scopes "User.ReadWrite.All"
```

Use an account with the required Microsoft Graph permissions and administrative consent.

#### Step 3: Identify the Guest User

Retrieve the Guest user's details:

```
Get-MgUser -Filter "userType eq 'Guest'" `
-Property Id,DisplayName,UserPrincipalName,UserType
```

Identify the user you want to convert and copy their Object ID.

#### Step 4: Convert the Guest User

Microsoft Graph provides the beta conversion operation through the `convertExternalToInternalMemberUser` endpoint.

The following example demonstrates the request structure:

```
$userId = "GUEST-USER-OBJECT-ID"

$body = @{
    newUserPrincipalName = "user@company.com"
    passwordProfile = @{
        password = "Replace-With-A-Strong-Password"
        forceChangePasswordNextSignIn = $true
    }
}

Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/users/$userId/convertExternalToInternalMemberUser" `
    -Body $body `
    -ContentType "application/json"
```

**Security note:** Do not hardcode production passwords in scripts. Use a secure credential-management solution and follow your organization's password policies.

The beta API is subject to change. Validate the current Microsoft Graph API requirements before using it in production.

#### Step 5: Verify the Conversion

After the operation completes, verify the account:

```
Get-MgUser -UserId $userId `
-Property Id,DisplayName,UserPrincipalName,UserType
```

Expected result:

```
DisplayName       : User Name
UserPrincipalName : user@company.com
UserType          : Member
```

### 5. What Happens After Conversion?

Once the Guest account is converted into a Member account, its identity and authentication model change.

The following points should be considered:

* **User Type:** The account changes from Guest to Member.
* **Authentication:** The user transitions from external B2B authentication to an internal tenant identity.
* **UPN:** The account receives the newly configured internal User Principal Name.
* **Existing resources:** Review existing group memberships, application assignments, and resource permissions after conversion.
* **Licensing:** Assign the appropriate Microsoft 365 license if the user requires licensed services.
* **Usage Location:** Configure the user's Usage Location before assigning Microsoft 365 licenses.
* **MFA:** Review authentication methods and ensure the user completes the organization's MFA registration process.

**Important:** Do not assume that every existing permission, application assignment, or external identity relationship will behave identically after conversion. Validate access to Teams, SharePoint, OneDrive, and other business-critical resources.

### 6. Post-Conversion Validation Checklist

After completing the conversion, perform the following checks:

* Verify the user's User Type is Member.
* Verify the new User Principal Name.
* Confirm the user can authenticate using the internal account.
* Configure the required MFA methods.
* Set the correct Usage Location.
* Assign the required Microsoft 365 licenses.
* Verify Microsoft Teams access.
* Verify SharePoint and OneDrive access.
* Review existing group memberships and application assignments.
* Confirm the user can access the required organizational resources.

### 7. Common Issues and Troubleshooting

| Issue                                  | Possible Cause                                          | Recommended Action                                  |
| -------------------------------------- | ------------------------------------------------------- | --------------------------------------------------- |
| Conversion option unavailable          | Insufficient permissions or unsupported account state   | Verify administrative roles and account eligibility |
| UPN already exists                     | Another account is using the requested UPN              | Select an available UPN                             |
| Conversion fails                       | Graph permissions or API requirements are not satisfied | Review Graph scopes, consent, and API response      |
| User cannot sign in                    | Authentication configuration is incomplete              | Verify credentials and authentication methods       |
| Microsoft 365 applications unavailable | License or Usage Location not configured                | Configure Usage Location and assign licenses        |
| Existing resource access unavailable   | Permissions or application assignments require review   | Validate group memberships and resource access      |

### 8. Best Practices

1. Always verify the identity of the Guest account before conversion.
2. Record the existing UPN and Object ID for administrative reference.
3. Confirm the desired internal UPN is available.
4. Avoid deleting and recreating the account when the conversion feature is appropriate.
5. Review existing permissions and application assignments after conversion.
6. Use Microsoft Graph PowerShell for repeatable administrative operations.
7. Securely manage passwords and avoid storing credentials in scripts.
8. Test the process with a non-production account before performing bulk conversions.

### 9. Conclusion

Converting a Microsoft 365 Guest user into an internal Member account is a useful identity-management operation when an external collaborator becomes part of an organization.

Microsoft Entra admin center provides a straightforward graphical approach for individual conversions, while Microsoft Graph PowerShell enables administrators to automate the process.

Following the correct prerequisites, conversion procedure, and post-conversion validation steps helps ensure a smooth transition from external B2B collaboration to internal organizational identity.

### 10. Microsoft Documentation and References

* [Microsoft Learn – Convert external users to internal users](https://learn.microsoft.com/en-us/entra/identity/users/convert-external-users-internal)
* [Microsoft Graph PowerShell SDK](https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation)
* [Microsoft Graph API Documentation](https://learn.microsoft.com/en-us/graph/api/user-convertexternaltointernalmemberuser?view=graph-rest-beta)

***

**Document Category:** Microsoft 365 Administration\
**Technology:** Microsoft Entra ID / Microsoft Graph PowerShell\
**Skill Area:** Identity and Access Management (IAM)\
**Difficulty:** Intermediate\
**Operation Type:** User Identity Conversion
