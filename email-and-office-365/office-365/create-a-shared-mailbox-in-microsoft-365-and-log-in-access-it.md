---
icon: mailbox-flag-up
---

# Create a shared mailbox in Microsoft 365 and log in / access it

## **How to Create a Shared Mailbox in Microsoft 365**

#### **Step 1: Sign in to Microsoft 365 Admin Center**

Go to: [**https://admin.microsoft.com**](https://admin.microsoft.com)\
Use an account with **Global Admin** or **Exchange Admin** privileges.

***

#### **Step 2: Create the Shared Mailbox**

1. In the left menu, go to:\
   **Teams & groups → Active teams & groups**
2. Click **Add a group**.
3. Under _Choose a group type_, select **Shared mailbox**.
4. Enter:
   * **Name** of the shared mailbox
   * **Email address** (e.g., support@yourdomain.com)
5. Click **Create**.

***

#### **Step 3: Assign Members (Full Access & Send as Permissions)**

After the mailbox is created:

1. Open the shared mailbox from the list.
2. Under **Members**, click **Edit**.
3. Add the users who should access the mailbox.

By default, this gives:

* **Full Access** – open and read email.
* **Send As** – send emails as the shared mailbox address.

If needed, verify permissions in:\
**Exchange admin center → Recipients → Shared**

***

## **How Users Can Access / Log In to a Shared Mailbox**

Shared mailboxes **do not have passwords** and **cannot be logged into directly** like a user mailbox.

Users access them through their own mailboxes.

***

### **Option 1: Using Outlook Desktop**

Once permissions propagate (can take 5–30 minutes):

1. Restart Outlook.
2. The shared mailbox should **automatically appear** in the user’s folder list on the left side.
   * It appears as:\
     **Shared Mailbox Name**\
     (with Inbox, Sent Items, etc.)

If it doesn't appear automatically:

* Go to **File → Account Settings → Account Settings**
* Select your mailbox → **Change**
* **More Settings → Advanced → Add**
* Enter the shared mailbox name and click **OK**

***

### **Option 2: Using Outlook Web (OWA)**

#### **Method A: Open shared mailbox directly**

1. Go to: [**https://outlook.office.com**](https://outlook.office.com)
2. Click your profile photo (top right) → **Open another mailbox**
3. Enter the shared mailbox email → **Open**

#### **Method B: Add it to your OWA sidebar**

1. Right-click **Folders**
2. Choose **Add shared folder**
3. Type the shared mailbox name
4. Click **Add**

***

### **Option 3: Access via Mobile (Outlook App)**

You cannot "log in" directly, but you can **add it as a shared mailbox**:

1. In the Outlook mobile app, go to **Settings**
2. Tap the main account
3. Select **Add Shared Mailbox**
4. Enter the shared mailbox email
