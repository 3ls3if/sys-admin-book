---
icon: envelope-open
---

# Migrate Google Workspace to SmarterMail

### How to Migrate Email From Google Workspace to SmarterMail Manually?      &#x20;

When moving from one SmarterMail server to another, make sure MAPI/EWS is turned on in the source server. It ensures that all key folders, such as Calendars, Contacts, Tasks, and Notes, are transferred. If MAPI/EWS is not available, IMAP can be used, but it will only migrate email data.&#x20;

### Prerequisties

{% hint style="warning" %}
## Create an App Password for Gmail



You must have [2-Step-Verification](https://itsupport.umd.edu/itsupport?id=kb_article_view\&sysparm_article=KB0012064) enabled before setting up an application password.

1. Visit your [App passwords](https://myaccount.google.com/apppasswords) page. You may be asked to sign in to your Google Account.
2. At the bottom, click **Select app** and choose the app you're using. You can also select **Other** and enter you own custom app name.
3. Click **Select device** and choose the device you're using. You can also select **Other** and enter you own custom device name.
4.  Click **Generate**.\


    <figure><img src="https://itsupport.umd.edu/create-app-password-gmail-google-account.pngx" alt=""><figcaption></figcaption></figure>
5.  Be sure to copy the password that was generated. When using the password, do not use spaces.\


    <figure><img src="https://itsupport.umd.edu/Yourapppassword.pngx" alt=""><figcaption></figcaption></figure>
{% endhint %}

#### Steps to Migrate Google Workspace to SmarterMail:

1. Log in to **SmarterMail** as a user and click the **Settings** icon. &#x20;
2. Click on **Connectivity** from the panel.
3. Under the **Mailbox Migration card**, select the **Migrate** option.
4. Select the **Mail Server/Service** you are migrating from and click its **icon**.
5. Write some details, including **Items to Import, Server Address, Type (POP or IMAP), Port, Email Address,** and **Password (App Password).**
6. Enable **SSL** for secure login (enabled by default).
7. Optionally, enable **Delete existing SmarterMail mailbox** items to overwrite current data.
8. Once all information is entered, the migration will begin, and you can track its progress.

{% hint style="danger" %}
#### Issues with Manual Google Workspace to SmarterMail Migration:

* **Complex Setup:** Configuring IMAP/POP settings and authentication can be time-consuming.
* **Limited Data Transfer:** Only email data is migrated unless MAPI/EWS is enabled.
* **Slow Migration:** Large data volumes can lead to slow migration speeds.
* **Risk of Data Loss:** Incorrect settings or errors may cause data loss.
* **Multiple Account Challenges:** Migrating several accounts is repetitive and error-prone.
{% endhint %}



***

## REFERENCES

* [https://www.drssoftech.com/blog/migrate-google-workspace-mailboxes-to-smartermail/](https://www.drssoftech.com/blog/migrate-google-workspace-mailboxes-to-smartermail/)
* [https://itsupport.umd.edu/itsupport?id=kb\_article\_view\&sysparm\_article=KB0015112](https://itsupport.umd.edu/itsupport?id=kb_article_view\&sysparm_article=KB0015112)
