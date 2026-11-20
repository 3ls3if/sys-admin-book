---
icon: share
---

# Sharing Microsoft Teams Files and Folders with External Users by Converting Guest Users to Members

### 1. Overview

Microsoft Teams allows organizations to collaborate and share files and folders with external users. These users are generally invited into the organization's Microsoft 365 tenant as Guest users through Microsoft Entra ID B2B collaboration.

In certain scenarios, external users may encounter collaboration or access limitations due to the existing Guest user configuration or organizational policies.

One approach, where supported by the organization's identity and security requirements, is to convert the existing external Guest user to a Member in Microsoft Entra ID and update the necessary user properties.

This article explains how to:

* Identify an existing external Guest user.
* Convert the Guest user to a Member.
* Edit the user's properties in Microsoft Entra ID.
* Verify the updated user configuration.
* Share files and folders with the external user through Microsoft Teams.

**Note:** Guest-to-Member conversion is not a general requirement for external file sharing. Standard Teams and SharePoint external sharing should normally be evaluated first. Conversion changes the user's directory classification; it does not automatically resolve sharing-policy restrictions or grant resource permissions.

### 2. Prerequisites

Before proceeding, ensure that:

* The external user has already been invited to the Microsoft 365 tenant.
* The external user account is visible in Microsoft Entra ID.
* An administrator has the required User Administrator or Global Administrator permissions.
* External collaboration and SharePoint sharing are configured appropriately.
* The required Teams and SharePoint permissions are available.

### 3. Convert External Guest User to Member

#### Step 1: Log in to Microsoft Entra Admin Center

1. Open [https://entra.microsoft.com/](https://entra.microsoft.com/).
2. Sign in using an authorized administrator account.
3. Navigate to **Identity → Users → All users**.
4. Search for the external user's email address.
5. Open the corresponding user account.

#### Step 2: Change the User Type

1. Navigate to the **Properties** section.
2. Locate the **Identity** section.
3. Find the **User type** property.
4. Click **Edit**.
5. Change the User Type from **Guest** to **Member**.
6. Save the changes.

The existing external user will now be classified as a Member in the Microsoft Entra ID tenant.

### 4. Edit External User Properties

After converting the user, update the required profile properties.

1. Open the converted user's profile.
2. Navigate to **Properties**.
3. Review the available user information.
4. Update the required details according to organizational requirements.

Examples of properties that may be updated:

* Display Name
* First Name
* Last Name
* Job Title
* Department
* Company Name
* Usage Location
* Contact Information

Save the changes after updating the required information.

**Important:** Updating profile properties does not change the external user's home identity provider or automatically create an internal password.

### 5. Verify User Conversion

After completing the changes:

1. Return to the user's profile.
2. Open the Properties section.
3. Verify that the User Type is now displayed as **Member**.
4. Confirm that the updated profile information has been saved.

Allow sufficient time for changes to propagate across Microsoft 365 services.

### 6. Share Files and Folders Through Microsoft Teams

Once the required identity and resource permissions are configured, proceed with file-sharing validation.

#### Method 1: Share Files Through a Teams Channel

1. Open Microsoft Teams.
2. Navigate to the required Team and Channel.
3. Open the Files or Shared section.
4. Select the file or folder that needs to be shared.
5. Click **Share** or **Copy link**.
6. Configure the appropriate access permissions.
7. Share the generated link with the external user.

#### Method 2: Share Files Through Teams Chat

1. Open Microsoft Teams.
2. Search for the external user's account.
3. Open the conversation.
4. Select the attachment option.
5. Upload the required file or folder.
6. Send the attachment.

For chat-based file sharing, verify that the required external collaboration and SharePoint/OneDrive sharing policies are enabled.

### 7. Validate External User Access

After sharing the files or folders, ask the external user to:

1. Sign in to Microsoft Teams using their external account.
2. Open the shared conversation or channel.
3. Access the shared file or folder.
4. Verify that the assigned permissions allow the required operations, such as viewing, downloading, or editing.

If access is unsuccessful, review the SharePoint permissions, sharing links, Teams policies, Conditional Access policies, and external identity configuration.

### 8. Important Considerations

* Converting Guest to Member changes the directory classification, not necessarily the authentication method.
* Member classification may provide broader default directory visibility.
* Microsoft 365 licensing is not automatically assigned during conversion.
* Teams and SharePoint resource permissions must still be configured.
* External sharing policies can continue to restrict file and folder access.
* Review security and Conditional Access requirements before converting external identities.

### 9. Conclusion

Converting an existing external Guest user to a Member in Microsoft Entra ID and updating their properties is one possible approach when an organization's collaboration requirements call for Member classification.

After updating the account, administrators should verify the user's identity configuration and explicitly configure the required Microsoft Teams and SharePoint permissions.

This ensures that external collaboration is managed through the organization's identity and access management policies.

### References

1. [Microsoft Learn – Convert external users to internal users](https://learn.microsoft.com/en-us/entra/identity/users/convert-external-users-internal)
2. [Microsoft Learn – Configure external collaboration settings](https://learn.microsoft.com/en-us/entra/external-id/external-collaboration-settings-configure)
3. [Microsoft Learn – External access in Microsoft Teams](https://learn.microsoft.com/en-us/microsoftteams/communicate-with-users-from-other-organizations)
4. [Microsoft Learn – Share SharePoint files and folders](https://learn.microsoft.com/en-us/sharepoint/external-sharing-overview)

**Category:** Microsoft 365 Administration\
**Technology:** Microsoft Entra ID, Microsoft Teams, SharePoint Online\
**Use Case:** External User Collaboration and File Sharing\
**Level:** Intermediate
