---
icon: g
---

# G-Suite to SmarterMail Migration

{% hint style="warning" %}
Migrating from **Google Workspace (G Suite)** to **SmarterMail** involves several steps to ensure that emails, contacts, calendars, and other data are moved safely without data loss or downtime. Below is a **step-by-step guide** for G Suite to SmarterMail migration:
{% endhint %}

### **1. Pre-Migration Planning**

Before starting the migration, make sure to:

* **Take a full backup** of all emails, contacts, and calendars from G Suite using **Google Takeout** or another backup tool.
* **Set up all user accounts** in SmarterMail that exist in G Suite.
* Check the **domain and DNS settings** to ensure proper routing after migration.
* Decide on the **migration tool/method** (SmarterMail's built-in migration tool or IMAP-based migration).

***

### **2. SmarterMail Setup**

* Install and configure **SmarterMail** on your server.
* Create **user accounts, mailboxes, and aliases** that match your G Suite users.
* Set up **SSL certificates** if needed for secure communication.
* Verify that **SMTP, IMAP, and POP3** are properly configured.

***

### **3. Data Migration Approaches**

#### **Option 1: SmarterMail Mailbox Migration Tool**

SmarterMail has a built-in **"Mailbox Migration" tool**:

1. Log in to SmarterMail as the user (or as admin).
2. Go to **Settings → Connectivity → Mailbox Migration**.
3. Choose **Gmail/G Suite** as the source.
4. Enter the user's **Gmail login credentials** (use an app password if 2FA is enabled).
5. Select what you want to migrate (**emails, contacts, calendars**).
6. Start migration.

_This is user-based; each user has to migrate their data individually or with admin assistance._

***

#### **Option 2: IMAP Migration**

1. Enable **IMAP** in Gmail for each user:
   * Go to **Settings → Forwarding and POP/IMAP → Enable IMAP**.
2. In SmarterMail, go to:
   * **Settings → Domain Settings → Accounts → Import Mailbox**.
3. Provide Gmail server details:
   * **IMAP Server**: `imap.gmail.com`
   * **Port**: 993 (SSL enabled)
4. Enter the Gmail username and password.
5. Begin the migration.

***

#### **Option 3: Third-Party Migration Tools**

If you need a **bulk migration for multiple accounts**, use tools like:

* **IMAPSync** (open-source)
* **Transend Migrator**
* **MigrationWiz** (paid)\
  These allow admin-level bulk migration, which is faster and easier for many users.

***

### **4. DNS & MX Records Update**

* Once emails are migrated, change the **MX records** from Google to point to the SmarterMail server.
* Add **SPF, DKIM, and DMARC** records for email authentication.

**Example MX record for SmarterMail:**

```
Priority: 10
Mail server: mail.yourdomain.com
```

***

### **5. Post-Migration Tasks**

* Test incoming/outgoing mail.
* Verify migrated emails, contacts, and calendar entries.
* Decommission G Suite mail services after confirming migration.
* Inform users about the new login credentials and email client setup.

***

### **6. Email Client Configuration**

Provide users with the **IMAP/SMTP settings** for SmarterMail:

* **IMAP Server**: `mail.yourdomain.com` (Port 993 SSL)
* **SMTP Server**: `mail.yourdomain.com` (Port 465 SSL)



***

## REFERENCES

* [https://help.smartertools.com/smartermail/current/topics/user/settings/mysettings/advanced/mailboxmigration](https://help.smartertools.com/smartermail/current/topics/user/settings/mysettings/advanced/mailboxmigration)
