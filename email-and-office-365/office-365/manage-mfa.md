---
icon: key
---

# Manage MFA

## Manage multi-factor authentication for users in Office 365

[Suggest Edits](https://docs.rackspace.com/edit/manage-multi-factor-authentication-for-users-in-office-365)

This article describes how administrators can manage multi-factor authentication for Office 365® users.

#### Prerequisites

* **Applies to:** Administrator
* **Difficulty:** Easy
* **Time Needed:** Approximately 15 minutes
* **Tools Needed:** Administrators need access to the Office 365 Control Panel

For more information about prerequisite terminology, see [Cloud Office support terminology](https://docs.rackspace.com/support/how-to/cloud-office-support-terminology).

Requiring multi-factor authentication for all users safeguards access to your organization's data and applications. Multi-factor authentication requires users to provide a second form of authentication when accessing their account. This second form of authentication is an additional layer of security and minimizes the chances of account compromise.

#### Enable multi-factor authentication for a user

Use the following steps to enable multi-factor authentication for a user:

1. <mark style="color:green;">Log in to your</mark> [<mark style="color:green;">Office 365 Control Panel</mark>](https://manage365.rackspace.com/)<mark style="color:green;">.</mark>
2. <mark style="color:green;">From the left menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Office 365 Admin Center**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">From the top menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Multi-factor authentication**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Select the check box next to the user you need to enable multi-factor authentication for.</mark>
5. <mark style="color:green;">Under quick steps, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enable**</mark><mark style="color:green;">.</mark>
6. <mark style="color:green;">When you are prompted, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**enable multi-factor auth**</mark><mark style="color:green;">.</mark>
7. <mark style="color:green;">The selected user is now able to configure multi-factor authentication for their account.</mark>

**Require a user to use multi-factor authentication**

To require a user to use multi-factor authentication, you must enforce multi-factor authentication for their account.

Use the following steps to enforce multi-factor authentication for a user:

1. <mark style="color:green;">Log in to your</mark> [<mark style="color:green;">Office 365 Control Panel</mark>](https://manage365.rackspace.com/)<mark style="color:green;">.</mark>
2. <mark style="color:green;">From the left menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Office 365 Admin Center**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">From the top menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Multi-factor authentication**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Select the check box next to the user you need to enforce multi-factor authentication for.</mark>
5. <mark style="color:green;">Under quick steps, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enforce**</mark><mark style="color:green;">.</mark>
6. <mark style="color:green;">When you are prompted, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**enforce multi-factor auth**</mark><mark style="color:green;">, then</mark> <mark style="color:green;"></mark><mark style="color:green;">**close**</mark><mark style="color:green;">.</mark>
7. <mark style="color:green;">The selected user is now required to configure and use multi-factor authentication for their account.</mark>

#### Reset existing multi-factor authentication configuration for a user

Your user may lose access to the device that they used to register with multi-factor authentication. When this occurs, you need to reset their multi-factor settings so that they can re-register.

Use the following steps to reset the existing multi-factor authentication configuration for a user:

1. <mark style="color:green;">Log in to your</mark> [<mark style="color:green;">Office 365 Control Panel</mark>](https://manage365.rackspace.com/)<mark style="color:green;">.</mark>
2. <mark style="color:green;">From the left menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Office 365 Admin Center**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">From the top menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Multi-factor authentication**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Select the check box next to the user you need to enforce multi-factor authentication for.</mark>
5. <mark style="color:green;">Under quick steps, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manage user settings**</mark><mark style="color:green;">.</mark>
6. <mark style="color:green;">Select the check box next to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Require selected users to provide contact methods again**</mark><mark style="color:green;">.</mark>
7. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**save**</mark> <mark style="color:green;"></mark><mark style="color:green;">then</mark> <mark style="color:green;"></mark><mark style="color:green;">**close**</mark><mark style="color:green;">.</mark>
8. <mark style="color:green;">The selected user can now log in to their Office 365 account and re-register with multi-factor authentication.</mark>

#### Disable multi-factor authentication for a user

Use the following steps to disable multi-factor authentication for a user:

1. <mark style="color:green;">Log in to your</mark> [<mark style="color:green;">Office 365 Control Panel</mark>](https://manage365.rackspace.com/)<mark style="color:green;">.</mark>
2. <mark style="color:green;">From the left menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Office 365 Admin Center**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">From the top menu, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Multi-factor authentication**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Select the check box next to the user you need to disable multi-factor authentication for.</mark>
5. <mark style="color:green;">Under quick steps, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disable**</mark><mark style="color:green;">.</mark>
6. <mark style="color:green;">When you are prompted, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**yes**</mark><mark style="color:green;">, then</mark> <mark style="color:green;"></mark><mark style="color:green;">**close**</mark><mark style="color:green;">.</mark>
7. <mark style="color:green;">The selected user is now no longer be able to use multi-factor authentication with their account.</mark>

#### Additional information

Microsoft® also provides a guide for deploying multi-factor authentication for your Office 365 tenant. See [Planning a cloud-based Azure Multi-Factor Authentication deployment](https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-getstarted).

Administrators can configure organization-wide multi-factor authentication requirements by creating a Conditional Access policy in their Azure® Active Directory® from the [Azure Portal](https://portal.azure.com/). See [Conditional Access: Require MFA for all users](https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/howto-conditional-access-policy-all-users-mfa) for instructions.

***

## Disable Multi Factor Authentication to all users in Office 365

You may disable security defaults in your directory:

1. <mark style="color:green;">Sign in to the</mark> [<mark style="color:green;">Azure portal</mark>](https://portal.azure.com/) <mark style="color:green;">as a security administrator, Conditional Access administrator, or global administrator.</mark>
2. <mark style="color:green;">Browse to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Azure Active Directory**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Properties**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manage security defaults**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Set</mark> <mark style="color:green;"></mark><mark style="color:green;">**Security defaults**</mark> <mark style="color:green;"></mark><mark style="color:green;">to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disabled**</mark> <mark style="color:green;"></mark>_<mark style="color:green;">(not recommended)</mark>_<mark style="color:green;">.</mark>
5. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Save**</mark><mark style="color:green;">.</mark>

***

## Disable MFA for all non-admin users

1. <mark style="color:green;">Create a security group for exclusion. You can call it "MFA Excluded users" for example.</mark>
2. <mark style="color:green;">Configure Conditional Access Policy:</mark>
   1. <mark style="color:green;">Navigate to the Azure Active Directory admin center.</mark>
   2. <mark style="color:green;">Go to Security > Conditional Access.</mark>
   3. <mark style="color:green;">Select New policy.</mark>
   4. <mark style="color:green;">Name your policy (e.g., "Disable MFA for Volunteers").</mark>
   5. <mark style="color:green;">Under Assignments, select Users and Groups. Then, under Include, select All users. Under Exclude, choose the group "MFA Excluded Users" you created for shared accounts.</mark>
   6. <mark style="color:green;">Under Cloud apps or actions, you can select All Cloud apps or specify only Microsoft 365 apps as required.</mark>
   7. <mark style="color:green;">In the Conditions section, you can leave the default settings or adjust them as needed for your organization.</mark>
   8. <mark style="color:green;">Under Grant, select Grant access and ensure that Require multi-factor authentication is unchecked.</mark>
   9. <mark style="color:green;">Enable the policy by setting Enable policy to On.</mark>
   10. <mark style="color:green;">Click Create to apply the policy.</mark>

{% hint style="warning" %}
Notes: Make sure you have a break-glass account when enabling MFA. Also, you should look into Guest accounts as an alternative to this issue.
{% endhint %}



***

## REFERENCES

* [https://youtu.be/ho2iuyAFiLg](https://youtu.be/ho2iuyAFiLg)
* [https://answers.microsoft.com/en-us/msoffice/forum/all/how-can-we-disable-multi-factor-authentication-to/703fffbd-b8d4-4ffd-a8db-c053282265ff](https://answers.microsoft.com/en-us/msoffice/forum/all/how-can-we-disable-multi-factor-authentication-to/703fffbd-b8d4-4ffd-a8db-c053282265ff)
* [https://learn.microsoft.com/en-us/answers/questions/1571467/how-to-disable-mfa-for-all-non-admin-users](https://learn.microsoft.com/en-us/answers/questions/1571467/how-to-disable-mfa-for-all-non-admin-users)
