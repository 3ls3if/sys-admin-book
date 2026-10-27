---
icon: exclamation
---

# Understanding and Resolving Microsoft Entra ID Error AADSTS700016

## Understanding and Resolving Microsoft Entra ID Error AADSTS700016

### Introduction

Microsoft Entra ID (formerly Azure Active Directory) is widely used to authenticate users and applications accessing Microsoft cloud services. One of the common authentication errors administrators encounter is **AADSTS700016**, which indicates that the application being used for authentication cannot be found in the specified Microsoft Entra tenant.

This article explains the causes of the error, how to troubleshoot it, and the steps required to resolve it.

***

### Error Message

A typical error appears as follows:

> **AADSTS700016:** Application with identifier '' was not found in the directory ''. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant. You may have sent your authentication request to the wrong tenant.

***

### What Does the Error Mean?

This error indicates that Microsoft Entra ID cannot locate the application registration in the tenant specified during the authentication request. As a result, the authentication process fails before user credentials are validated.

***

### Common Causes

#### 1. Incorrect Client ID

One of the most common causes is an incorrect **Application (Client) ID**.

In many cases, administrators mistakenly configure the **Client Secret** in place of the **Client ID**. The Client ID should always be a GUID similar to:

```
12345678-abcd-1234-abcd-1234567890ab
```

whereas a Client Secret is a randomly generated string.

***

#### 2. Wrong Tenant

The application may be attempting to authenticate against an incorrect Microsoft Entra tenant.

For example:

* The application is registered in **Tenant A**.
* The authentication request is sent to **Tenant B**.

Since the application does not exist in the target tenant, Microsoft returns the AADSTS700016 error.

***

#### 3. Application Registration Does Not Exist

The application may have:

* Never been registered.
* Been accidentally deleted.
* Been recreated with a new Client ID.

***

#### 4. Missing Admin Consent

For multi-tenant applications, the administrator of the target tenant must grant the required permissions before users can authenticate.

***

#### 5. Incorrect Authentication Configuration

Incorrect values in the application's configuration file or environment variables can also trigger this error.

Typical configuration parameters include:

* Tenant ID
* Client ID
* Client Secret
* Authority URL

***

### How to Troubleshoot

#### Step 1: Verify the Client ID

Navigate to:

**Microsoft Entra Admin Center → Identity → Applications → App registrations**

Locate your application and verify the **Application (Client) ID**.

Ensure that your application configuration uses this value as the Client ID.

***

#### Step 2: Verify the Tenant

Go to:

**Microsoft Entra ID → Overview**

Confirm the Tenant ID and compare it with the one configured in your application.

***

#### Step 3: Check the App Registration

Search for the application in **App registrations**.

If it cannot be found:

* Recreate the application.
* Obtain the correct Client ID from the application owner.
* Update your application configuration.

***

#### Step 4: Verify the Client Secret

Open the application registration and navigate to:

**Certificates & Secrets**

Verify that:

* The secret exists.
* It has not expired.
* The application is using the latest secret value.

If necessary, create a new secret and update the application configuration.

***

#### Step 5: Verify the Authority URL

Ensure that the authentication endpoint references the correct tenant.

For example:

```
https://login.microsoftonline.com/<Tenant-ID>
```

or

```
https://login.microsoftonline.com/<Tenant-Domain>
```

Using an incorrect tenant endpoint will prevent Microsoft Entra ID from locating the application.

***

#### Step 6: Grant Admin Consent

If the application is multi-tenant:

1. Open the App Registration.
2. Navigate to **API Permissions**.
3. Click **Grant admin consent**.
4. Retry the authentication.

***

### Example of Correct Configuration

A properly configured application should contain:

* **Tenant ID:** Your Microsoft Entra Tenant ID
* **Client ID:** Application (Client) ID
* **Client Secret:** Secret Value generated under Certificates & Secrets

Avoid placing the Client Secret in the Client ID field, as this is one of the most common configuration mistakes.

***

### Best Practices

* Store Client Secrets securely using Azure Key Vault or another secrets management solution.
* Rotate Client Secrets before they expire.
* Document Tenant IDs and Client IDs for each application.
* Use Managed Identities where possible to eliminate the need for Client Secrets.
* Regularly review application registrations and remove unused applications.

***

### Conclusion

The **AADSTS700016** error typically occurs when Microsoft Entra ID cannot locate the specified application within the target tenant. In most cases, the issue is caused by an incorrect Client ID, an incorrect tenant configuration, or a missing application registration.

By verifying the Client ID, Tenant ID, application registration, Client Secret, and authentication endpoint, administrators can quickly identify and resolve the issue. Following configuration best practices and maintaining accurate application records can also help prevent similar authentication errors in the future.&#x20;
