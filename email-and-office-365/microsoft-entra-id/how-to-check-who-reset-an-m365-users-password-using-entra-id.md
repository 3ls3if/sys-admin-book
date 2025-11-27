---
icon: key
---

# How to Check Who Reset an M365 User’s Password Using Entra ID

Microsoft 365 administrators often need to verify who performed a password reset for a specific user—whether it was self-service, an administrator, or an automated process. Microsoft Entra ID (formerly Azure Active Directory) records all password reset activities, making it easy to review these details through the Audit Logs, the Microsoft 365 Admin Center, or PowerShell.

This article walks you through all available methods.

***

### **Why Check Password Reset Logs?**

Password reset logs help administrators:

* Track unauthorized or unexpected password changes
* Monitor user activity for security compliance
* Troubleshoot login-related issues
* Verify helpdesk actions

Microsoft logs essential details—including the actor, timestamp, IP address, and target user—making the audit process straightforward.

***

### **Method 1: Using Entra ID (Azure Portal)**

The Entra ID portal offers the most detailed and reliable audit logs for password resets.

#### **Step-by-Step Guide**

#### **1. Go to Microsoft Entra ID**

Visit:\
[**https://entra.microsoft.com**](https://entra.microsoft.com)\
or navigate via Azure Portal → **Microsoft Entra ID**.

***

#### **2. Open Audit Logs**

In the left navigation pane, go to:\
**Monitoring → Audit logs**

***

#### **3. Filter for Password Reset Events**

Use the filters at the top:

* **Activity:**
  * _Reset password_
  * _Change password_
* **Category:**
  * _User management_
* **Date range:** (optional)

This will narrow the list to password reset events only.

***

#### **4. Review the “Initiated by (Actor)” Column**

This column identifies **who performed the password reset**.\
It may show:

* An admin account
* The same user (if self-service password reset is enabled)
* A system process (rare)

***

#### **5. Open Event Details for More Information**

Click the event to view:

* **Target:** The user whose password was reset
* **Actor:** Who initiated the action
* **Timestamp**
* **IP address**
* Additional audit data

***

### **Method 2: Microsoft 365 Admin Center**

You can also check password resets in the Microsoft 365 Compliance portal.

#### **Steps:**

1. Go to: [**https://admin.microsoft.com**](https://admin.microsoft.com)
2. Navigate to **Audit Search** (under Compliance or Audit)
3. Search for these activities:
   * _Reset user password_
   * _Change user password_
4. Check the **User** field to identify the actor

This method is easy but may show fewer details than Entra ID.

***

### **Method 3: Using PowerShell**

PowerShell is ideal for automation or bulk log reviews.

#### **Azure AD PowerShell Module**

```powershell
Connect-AzureAD

Get-AzureADAuditDirectoryLogs `
  -Filter "activityDisplayName eq 'Reset password'"
```

#### **Microsoft Graph PowerShell Module**

```powershell
Get-MgAuditLogDirectoryAudit -Filter "activityDisplayName eq 'Reset password'"
```

This returns password reset audit entries with full event metadata.

***

### **Important Notes**

* If **Self-Service Password Reset (SSPR)** is enabled, the event will list the **same user** as the actor.
* If an **administrator** reset the password, their account will appear as the actor.
* All password reset events are logged automatically—no configuration needed.

***

### **Conclusion**

Tracking who reset an M365 user’s password is simple with Entra ID’s built-in audit capabilities. Whether you prefer the Azure Portal, Microsoft 365 Admin Center, or PowerShell, the logs provide complete visibility into password-related activities. This helps maintain security, troubleshoot issues, and ensure compliance across your Microsoft 365 environment.

