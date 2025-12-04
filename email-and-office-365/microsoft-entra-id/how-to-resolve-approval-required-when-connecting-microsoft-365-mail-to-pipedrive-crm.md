---
icon: thumbs-up
---

# How to Resolve “Approval Required” When Connecting Microsoft 365 Mail to Pipedrive CRM

If you see an **“Approval required”** screen while connecting Microsoft 365 mail to Pipedrive CRM, it means the application is requesting permissions that only a **Microsoft 365 Global Admin** can approve.\
In your case, the user **test@exampl.com** is not a Global Admin, which is why the consent prompt appeared and an approval request was sent to the administrator.

***

### **Why This Happens (Root Cause)**

Microsoft Entra ID (formerly Azure AD) blocks certain app connections when:

* The app requests **high-privilege permissions**
* The user trying to connect is **not an administrator**
* The app **requires admin consent** before it can access mailboxes or sensitive data

Since Pipedrive CRM requires permissions to read/send emails and access user data, Microsoft requires an administrator to review and approve the request.

Until a Global Admin approves the permissions, **Pipedrive cannot access or sync the mailbox**.

***

### **How to Fix the Issue**

To resolve this, a **Microsoft 365 Global Admin must approve the Pipedrive CRM enterprise application** in the Microsoft Entra Admin Center.

Follow the steps below:

***

### 🛠 **Step-by-Step Resolution**

#### **Step 1 — Sign in as a Global Administrator**

Go directly to the Admin Consent Portal:

🔗 [https://entra.microsoft.com/#view/Microsoft\_AAD\_IAM/StartboardApplicationsMenuBlade/\~/AdminConsentRequests](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/~/AdminConsentRequests)

Or navigate manually:

**Microsoft Entra Admin Center**\
→ **Identity**\
→ **Applications**\
→ **Admin consent requests**

***

#### **Step 2 — Locate the Pipedrive CRM Request**

You will see a pending request similar to:

* **Requested app:** Pipedrive CRM
* **Status:** Submitted
* **Requested by:** user (e.g., test@example.com)

Click on the request to review it.

***

#### **Step 3 — Approve the Permissions**

You will be presented with a list of permissions Pipedrive is requesting, such as:

* Read mail
* Send mail
* Access user profile
* Read contacts
* Maintain access

Click:

**Approve → Confirm → Save**

This grants Pipedrive the required API permissions for Microsoft 365 mail.

***

#### **Step 4 — Retry Email Sync in Pipedrive**

Once approval is complete:

1. Open **Pipedrive CRM**
2. Navigate to **Tools → Email Sync**
3. Select **Add Account**
4. Choose **Microsoft 365**
5. Retry authentication

This time, no admin approval message should appear.

***

### **Important Notes**

* **Only a Global Admin** can approve the request.
* If you are not the admin, share this guide with the tenant administrator.
* Until consent is granted, **email sync will continue to fail**.

***

### **Conclusion**

The “Approval required” screen is not an error—it’s a security feature of Microsoft Entra ID to ensure that third-party apps such as Pipedrive CRM receive explicit approval before accessing sensitive mailbox data.\
Once the Global Admin approves the app, email sync will work normally.
