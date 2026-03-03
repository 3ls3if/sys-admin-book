---
icon: apartment
---

# How to Convert a Federated Domain to Managed Authentication Using Microsoft Graph PowerShell

## How to Convert a Federated Domain to Managed Authentication Using Microsoft Graph PowerShell

Microsoft has officially deprecated the legacy **MSOnline** and **AzureAD** PowerShell modules in favor of the modern **Microsoft Graph PowerShell SDK**. If you're managing domains in **Microsoft Entra ID**, the Microsoft Graph module is now the recommended and fully supported approach.

This guide walks through converting a **federated domain** to **managed authentication** (also known as defederation) using the Microsoft Graph PowerShell module.

***

### Why Defederate a Domain?

Organizations typically federate a domain when using an on-premises identity provider such as Active Directory Federation Services (AD FS). However, many organizations later move to cloud-only authentication for:

* Simpler infrastructure
* Reduced maintenance
* Improved reliability
* Better alignment with cloud-first strategies

When you convert a domain from **Federated** to **Managed**, authentication is handled directly by Microsoft 365 rather than redirecting to an external identity provider.

***

## Step-by-Step Guide

***

### Step 1: Install the Microsoft Graph PowerShell Module

If you haven’t already installed the Microsoft Graph module, open PowerShell as Administrator and run:

```
Install-Module Microsoft.Graph -Scope CurrentUser
```

This installs the Microsoft Graph SDK for PowerShell in your current user profile.

***

### Step 2: Connect to Microsoft Graph

To make changes to domain authentication settings, you must connect with sufficient permissions.

```
Connect-MgGraph -Scopes "Domain.ReadWrite.All", "Directory.AccessAsUser.All"
```

You will be prompted to sign in. Use a **Global Administrator** account.

Required scopes:

* `Domain.ReadWrite.All`
* `Directory.AccessAsUser.All`

These permissions allow you to view and modify domain configuration settings.

***

### Step 3: Verify the Domain’s Current Authentication Status

Before making changes, confirm the domain is currently federated.

Replace `yourdomain.com` with your actual domain:

```
Get-MgDomain -DomainId "yourdomain.com"
```

Look for:

```
AuthenticationType : Federated
```

If the domain is already **Managed**, no further action is required.

***

### Step 4: Convert the Domain to Managed Authentication

To defederate the domain, run:

```
Update-MgDomain -DomainId "yourdomain.com" -AuthenticationType "Managed"
```

This command changes the domain’s authentication type from **Federated** to **Managed**.

***

### Step 5: Verify the Change

Wait a few minutes, then run:

```
Get-MgDomain -DomainId "yourdomain.com"
```

You should now see:

```
AuthenticationType : Managed
```

This confirms the domain is no longer federated.

***

### Step 6: Disconnect Your Session

After completing your changes, disconnect from Microsoft Graph:

```
Disconnect-MgGraph
```

This closes your session and removes your access token.

***

## What Happens After Defederation?

Understanding the impact of this change is critical before performing it in production.

***

### 1. User Authentication Behavior

Users from the affected domain will:

* No longer be redirected to your on-premises identity provider (e.g., AD FS).
* Authenticate directly against Microsoft 365.
* See a Microsoft-hosted sign-in page.

If password synchronization was previously enabled via Azure AD Connect, users can immediately authenticate using their synchronized passwords.

If password sync was **not** enabled, users may need to reset their passwords.

***

### 2. Propagation Time

The authentication change can take:

* 15–30 minutes in most cases
* Occasionally longer depending on service caching

Avoid testing immediately after running the command. Allow time for propagation across Microsoft 365 services.

***

### 3. Testing the Change

After waiting for propagation:

1. Open a private/incognito browser session.
2. Navigate to the Microsoft 365 sign-in page.
3. Enter a user account from the converted domain.

Users should:

* See a Microsoft-hosted password prompt.
* No longer be redirected to a third-party or on-premises login page.

***

## Best Practices Before Defederating

Before converting a domain, ensure:

* Password Hash Sync or Pass-Through Authentication is configured.
* At least one Global Admin account uses a different (cloud-only) domain.
* You have tested login scenarios in a staging or pilot group.
* Your organization is informed about the authentication change.

***

## Final Thoughts

Migrating from federation to managed authentication simplifies identity infrastructure and aligns your tenant with Microsoft's modern cloud-first architecture. By using the Microsoft Graph PowerShell SDK, administrators can securely and efficiently manage domain authentication settings within **Microsoft 365**.

If you're modernizing your identity environment, defederation is often a key milestone toward a fully cloud-managed identity strategy.





***

## REFERENCES

* [https://community.spiceworks.com/t/move-microsoft-365-email-away-from-godaddy/1077009/11](https://community.spiceworks.com/t/move-microsoft-365-email-away-from-godaddy/1077009/11)
