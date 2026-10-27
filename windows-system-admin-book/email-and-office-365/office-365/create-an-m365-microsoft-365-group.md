---
icon: people-group
---

# Create an M365 (Microsoft 365) group

C**reate an M365 (Microsoft 365) group**, **add members**, and **ensure replies to group emails are sent from the&#x20;**_**group email address**_**&#x20;instead of the individual user’s address**.

## **Step 1: Create a Microsoft 365 Group**

You can create the group either from the **Microsoft 365 admin center** or **Outlook**.

#### **Option A — M365 Admin Center**

1. Go to [https://admin.microsoft.com](https://admin.microsoft.com)
2. In the left menu, select **Teams & groups → Active teams and groups**
3. Click **Add a group**
4. Choose **Microsoft 365 group**
5. Fill in:
   * **Name** (group email alias is auto-generated)
   * **Description** (optional)
   * **Privacy** (Public/Private)
6. Choose **Create**

***

## **Step 2: Add Members to the Group**

After creating the group:

1. In **Admin Center → Teams & groups → Active teams and groups**
2. Click your newly created group
3. Select **Members**
4. Click **View all and manage members**
5. Click **Add members** and add users

***

## **Step 3: Ensure the Group Email Inbox Receives Mail**

Make sure group settings allow external/internal emails:

1. In the group properties, select **Settings**
2. Enable:
   * **Let people outside the organization email the group** (optional)
   * **Send copies of group messages to members’ inboxes** (optional but recommended)

***

## **Step 4: Enable “Send As” so users can reply using the group email address**

This part is critical — by default, members reply _as themselves_.\
To allow replying **as the group**, you must enable _Send As_ permission in Exchange Admin Center.

#### **Steps:**

1. Go to **Exchange Admin Center**\
   [https://admin.exchange.microsoft.com](https://admin.exchange.microsoft.com)
2. In the left menu, select **Groups → Active groups**
3. Select your Microsoft 365 Group
4. Go to **Settings → Permissions**
5. Under **Send as**, click **Edit**
6. Add the users who should be able to **send mail as the group**

***

## **Step 5: How users send/reply FROM the group email**

After _Send As_ is enabled:

#### **In Outlook (Desktop/Web):**

1. Open the email sent to the group
2. Click **Reply / Reply all**
3. In the _From:_ field, choose the **Group email address**
   * If _From_ is hidden, enable it via **Options → From**

Outlook will now send the message **FROM the group mailbox**, not the user’s mailbox.
