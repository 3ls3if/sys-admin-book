---
icon: people-roof
---

# Creating & Managing Roles

## Creating and managing admins through roles

Now let's take a look at assigning admin roles. There are a lot of different models and strategies to manage administrative rights but the one Microsoft chose to implement in Microsoft 365 is Role-Based Access Control (RBAC). The way RBAC works is the administrative rights or permissions you're given in the organization are based on your role. In short, Microsoft has implemented several roles that can be assigned to users that will grant user-specific rights.

One of the best things about roles is roles will allow us to see exactly what rights a user has. It isn't so obvious with groups. You probably work with groups in your on-premise environment. Where you create a group, assign members to the group, and then assign permissions to the group. But here's the problem, there's nothing that documents what rights those groups had. With roles, you can see exactly what admin rights the roles have. In Microsoft 365 there are built-in roles that are assigned several permissions across your tenant but you can also create a custom role and assign it rights. Then you or another admin can review the rights that are assigned to that role.

### What's the principle of least privilege?

In short, it's a concept in cybersecurity to give out the least amount of permissions that is possible. In short, you don't want everyone being global admins because then someone that's upset with your organization or accidentally may screw up your Microsoft 365 tenant. For example, someone that manages your email environment doesn't need to be a SharePoint admin. Microsoft will always recommend the principle of least privilege. So if you see a question regarding what role does user X need to do Y? Always select the role that gives the least amount of permissions

### How to assign roles to users

1\. Go to [https://admin.microsoft.com/Adminportal/Home?source=applauncher#/users](https://admin.microsoft.com/Adminportal/Home?source=applauncher#/users).

2\. Click the user you want to assign a role to then click **Manage roles**.

![Microsoft 365 assign a role to a user](https://i.ibb.co/2g9zNSh/microsoft-365-manage-roles.png)

3\. Click **Admin center access** then select the roles you want to assign.

![Microsoft 365 assign admin role to user](https://i.ibb.co/h1hqMDC/microsoft-365-manage-admin-roles.png)

If you want to give more specific permissions click **Show all by category**.

![Microsoft 365 admin role categories](https://i.ibb.co/37PBpQf/microsoft-365-admin-role-categories.png)

### How to view the rights of admin roles

A quick overview of the admin role can be seen by highlighting the **I** next to the role.

![Microsoft 365 admin roles view description](https://i.ibb.co/984JZn2/microsoft-365-quick-view-of-admin-rights.png)

But to see the actual role permissions assigned you'll need to use Azure Active Directory

1\. Go to [https://aad.portal.azure.com/#blade/Microsoft\_AAD\_IAM/ActiveDirectoryMenuBlade/RolesAndAdministrators](https://aad.portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RolesAndAdministrators)

2\. Click the administrative role you want to view the permissions for.

From this page, you can view all the roles in your tenant.&#x20;

![Azure AD Roles](https://i.ibb.co/gVnhfmz/azure-ad-roles.png)

3\. Click **Description**. From there you can view the role permissions.

![C:\Users\john.gruber\Downloads\azure ad role permissions descriptions](https://i.ibb.co/g6MbsX9/azure-ad-role-permissions-descriptions.png)

### A few key Microsoft 365 roles

In the next section, I'll review a few key roles and what they have access to do. It's important to remember what roles can perform what permissions as part of the MS-500 test.

#### Global administrator

The global administrator has full access to everything. They can assign roles, reset passwords of other admins. Take ownership of mailboxes and OneDrive containers. You'll want to be careful to who you assign the global administrator role. They have the keys to the kingdom.

#### Password administrator

The password administrator can reset passwords for non-administrator users. The password administrators can also reset the passwords for the following roles:

* Directory readers
* Guest inviter
* Password administrator

Let's take an example, Let's say you have a user John Gruber that's a password administrator. And you have a global admin named Kendra Smith and a regular user Daniel James. Who's password can John Gruber reset? Daniel's. John can't reset Kendra's password because she's a global administrator.

#### Security Reader

Users with the security reader role have global read-only access to view the security configuration. The users with the security reader role can view the following:

* View Azure Active Directory sign-in reports
* View Azure Active Directory audit logs
* View ATP reports in the Threat management dashboard
* Read-only access to the Security & Compliance Center
* Read-only access to the Microsoft 365 compliance center
* Read the Microsoft Defender for Office 365 reports in the Threat management dashboard

#### Security administrator

The security administrator role is assigned to users that manage the security of your Microsoft 365 tenant. The security administrator users will have all the permissions that the security reader has plus the ability to edit the security settings. It gives the users the permissions to perform the following:

* View ATP reports in the Threat management dashboard
* Create and modify data loss protection policies
* Create and manage labels
* Manage email protection (anti-phishing, safe links, and anti-malware)

#### Privileged role administrator

Users with the privileged role administrator role can manage role assignments in Azure Active Directory. They can also enable, configure, and manage the Azure AD Privileged Identity Management. The privileged role administrators can assign other users with different admin roles. They cannot manage their own role permissions. For example, if John Gruber is assigned the privileged role administrator role then John Gruber can assign User1 with the reports reader role.

#### Service support administrator

The service support administrator role is used to open support requests with Microsoft. They can also view the service dashboard and message center in the admin portals.

#### Guest inviter

Members of the guest inviter role can invite guests even when the "members can invite" property is set to no. The guest inviter admin role isn't even really an admin because that's all they can do.

#### Security operator

Users with the security operator role can review the audit log but can't disable auditing. The security operator role users will also have global read-only access to the security-related features, including all information in Microsoft 365 security center, Azure Active Directory, and Privileged Identity Management. The security operator can also manage features in the identity protection center.

### Exchange Online Roles

Microsoft 365 is so vast that not all the roles are displayed in the Microsoft 365 roles. The Exchange/email-specific roles are stored in the Exchange admin center. That way you can give admins specific rights to just Exchange Online. For example, you can give someone complete admin access to Exchange Online by assigning them the Microsoft 365 Exchange administrator role or you can assign them the Organization Management Exchange Online role. One thing to note, if you're a global administrator you're already assigned the organization management role.

#### How to assign Exchange Online admin roles

1\. Go to [https://admin.exchange.microsoft.com/#/adminRoles](https://admin.exchange.microsoft.com/#/adminRoles) and sign in with your admin credentials.

2\. Click the role you want to assign to a user. Then click the **Assigned** tab. Finally, click **Add**.

![Assign Exchange Online admin roles](https://i.ibb.co/WyfXXJQ/assign-exchange-online-admin-roles.png)

3\. Type the name of the user you want to add as an admin. Click the user in the drop-down.

![Exchange Online add admin](https://i.ibb.co/GP6CfSM/exchange-online-add-admins.png)

4\. Click **Add**.

![Add user to Exchange admin role](https://i.ibb.co/LzbxPpt/add-user-to-exchange-admin-role.png)

#### How to view the rights of Exchange Online admin roles&#x20;

Just like the Microsoft 365 admin roles, you can view the description and see the permissions assigned to each role.

1\. To view the description go to [https://admin.exchange.microsoft.com/#/adminRoles](https://admin.exchange.microsoft.com/#/adminRoles) and click the role you want to view.

![View the Exchange Online admin role descrptions](https://i.ibb.co/wgMcNZd/exchange-online-admin-roles-description.png)

2\. To view the permissions assigned click the **Permissions** tab. You can review the permissions by hovering the mouse over the **I**.

![Exchange Online admin role permissions](https://i.ibb.co/7CtNXBz/Exchange-Online-admin-role-permissions.png)

#### A few key Exchange Online roles

**Organization Management**

Organization Management members can manage virtually everything in Exchange Online. It's like the global admin but for Exchange Online.

**Discovery Management**

Discovery management members can perform searches of mailboxes and manage legal holds / preserve all the mailbox content.

**Recipient Management**

Recipient Management members can create, manage, and remove recipients in Exchange Online.

### Security & Compliance Roles

Microsoft 365 and Exchange Online aren't the only places roles are set up. There are also roles in the security and compliance admin center. These roles work virtually the same as the Microsoft 365 and Exchange Online roles. Each role has a name, description, permissions assigned, and members of the role but there is a small difference. Half the security & compliance roles are stored in Azure AD. The other half are compliance center roles. So let's take a look at assigning compliance center roles.

#### How to assign roles to users

1\. Go to [https://compliance.microsoft.com/permissions](https://compliance.microsoft.com/permissions).

2\. Click **Roles** under Compliance center.

![Microsoft 365 compliance center open roles button](https://i.ibb.co/N2mM2rk/compliance-center-roles.png)

3\. Click the role you want to assign

![Compliance role edit members](https://i.ibb.co/wsFKJXB/assign-compliance-role-edit-members.png)

4\. Click **Choose members**

![C:\Users\john.gruber\Downloads\compliance center roles - choose members](https://i.ibb.co/jb73wrC/compliance-center-roles-choose-members.png)

5\. Click **Add**

![compliance center roles - add members](https://i.ibb.co/Jjvg1QG/compliance-center-roles-add-members.png)

6\. Click the checkmark next to the users you want to add to the role. Verify the number of users you select appears next to Added. Click **Add**.

![C:\Users\john.gruber\Downloads\compliance center roles - select members to add](https://i.ibb.co/TRFcysW/compliance-center-roles-select-members-to-add.png)

7\. Click **Done** then click **Save**.

![C:\Users\john.gruber\Downloads\compliance center roles - Save member change](https://i.ibb.co/ByVRjSV/compliance-center-roles-Save-member-change.png)

#### How to view the rights of compliance center admin roles

It's easy to view the assigned roles to the role groups.

1\. Go to [https://compliance.microsoft.com/compliancecenterpermissions](https://compliance.microsoft.com/compliancecenterpermissions) and sign in with your admin permissions.

2\. Click the role you want to view the permissions for.

3\. View the Assigned roles.

![Compliance center roles - view assigned roles](https://i.ibb.co/Tv9X1NY/compliance-center-roles-view-assigned-roles.png)

#### A few key compliance center admin roles

In the next section, I'll review a few key roles and what they have access to do. It's important to remember what roles can perform what permissions as part of the MS-500 test.

**Global admin**

The global admin in the Microsoft 365 tenant have access to the entire compliance center. They can add and remove roles and members from roles. They can even add themselves to compliance center roles.

**eDiscovery managers**

An eDiscovery manager can perform searches, including exporting and previewing the results. They can create, as well as, manage eDiscovery cases including adding members to the cases. They can't access or manage cases created by other eDiscovery Managers.

**eDiscovery administrators**

eDiscovery administrators can perform all the functions as an eDiscovery manager + manage other people's cases.



***

## REFERENCES

* [https://www.gitbit.org/course/ms-500/learn/creating-and-managing-admins-through-roles-7cpqfkpzu](https://www.gitbit.org/course/ms-500/learn/creating-and-managing-admins-through-roles-7cpqfkpzu)

