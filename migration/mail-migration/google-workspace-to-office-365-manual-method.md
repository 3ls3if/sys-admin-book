---
icon: g
---

# Google Workspace to Office 365 (Manual Method)

{% embed url="https://www.youtube.com/watch?v=LjxJo7fEwEM&ab_channel=SpecSpace" %}

***

### Prerequisites <a href="#prerequisites" id="prerequisites"></a>

Before you begin Google Workspace migration:

1. Ensure you're signed into Google Workspace as a project creator.
2. You have completed the following procedures:
   * Create a subdomain for mail routing to Microsoft 365 or Office 365
   * Create a subdomain for mail routing to your Google Workspace domain
   * Provision users in Microsoft 365 or Office 365

[Learn more at Google Workspace Mail Migration Prerequisites](https://learn.microsoft.com/en-us/exchange/mailbox-migration/google-workspace-migration-prerequisites).

### Start a Google Workspace migration batch with the Exchange admin center <a href="#start-a-google-workspace-migration-batch-with-the-exchange-admin-center" id="start-a-google-workspace-migration-batch-with-the-exchange-admin-center"></a>

{% hint style="warning" %}
I**mportant**

Microsoft's data migration tool is currently unaware of tools enforcing messaging records management (MRM) or archival policies. Because of this, any messages that are deleted or moved to archive by these policies will result in the migration process flagging these items as "missing". The result is perceived data loss rather than actual data loss, which makes it much harder to identify actual data loss during any content verification checks.

Therefore, Microsoft strongly recommends disabling all MRM and archival policies before attempting any data migration to mailboxes.
{% endhint %}

1.  In the [Exchange Admin center](https://admin.exchange.microsoft.com/), go to **Migration** and then click **Add migration batch**.



    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration1.png" alt=""><figcaption></figcaption></figure>
2.  On the **Add migration batch** page, configure the following settings:

    * **Give the migration batch a unique name**: Enter a unique name.
    * **Select the mailbox migration path**: Verify that **Migration to Exchange Online** is selected.

    When you're finished, click **Next**.&#x20;

    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration2.png" alt=""><figcaption></figcaption></figure>
3.  On the **Select the migration type** page, select **Google Workspace (Gmail) migration**, and then click **Next**



    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration-manual.png" alt=""><figcaption></figcaption></figure>
4.  On the **Prerequisites for Google Workspace migration** page, expand the **Manually configure your Google Workspace for migration**. As described in the section, configure the following steps:

    1. [Create a Google Service Account](https://learn.microsoft.com/en-us/exchange/mailbox-migration/manually-configuring-gsuite-for-migration#create-a-google-service-account)
    2. [Enable API Usage in your project](https://learn.microsoft.com/en-us/exchange/mailbox-migration/manually-configuring-gsuite-for-migration#enable-api-usage-in-your-project)
    3. [Grant access to the service account for your Google tenant](https://learn.microsoft.com/en-us/exchange/mailbox-migration/manually-configuring-gsuite-for-migration#grant-access-to-the-service-account-for-your-google-tenant)

    When you're finished, click **Next**.



    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration4.png" alt=""><figcaption></figcaption></figure>
5.  On the **Set a migration endpoint** page of the wizard, select one of the following options:

    * **Select the migration endpoint**: Select the existing migration endpoint from the drop-down list.
    * **Create a new migration endpoint**: Select this option if you're a first-time user.



{% hint style="warning" %}
**Note**

To migrate Gmail mailboxes successfully, Microsoft 365 or Office 365 needs to connect and communicate with Gmail. To do this, Microsoft 365 or Office 365 uses a migration endpoint. Migration endpoint is a technical term that describes the settings that are used to create the connection so you can migrate the mailboxes.
{% endhint %}

1.  If you selected **Create a new migration endpoint**, do the following steps:

    1.  On the **General Information** page, configure the following settings:

        * **Migration Endpoint Name**: Enter a value.
        * **Maximum concurrent migrations**: Leave the default value 20 or change the value as required.
        * **Maximum concurrent incremental syncs**: Leave the default value 10 or change the value as required.

        When you're finished, click **Next**.
    2.  On the **Gmail migration configuration** page, configure the following settings:

        * **Email address**: Enter the email address that you use to sign in to the Google Workspace.
        * **JSON key**: Click **Import JSON**. In the dialog that appears, find and select the downloaded JSON file, and then click **Open**.

        Once the endpoint is successfully created, it will be listed under **Select migration endpoint** drop-down.

        Select the endpoint from the drop-down list, and click **Next**.



    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration5.png" alt=""><figcaption></figcaption></figure>
2.  On the **Add user mailboxes** page, click **Import CSV file** and navigate to the folder where you have saved the CSV file.

    If you haven't already, create a CSV file containing the set of all of the users you want to migrate. You'll need its filename below. The allowed headers are:

    * **EmailAddress** (required): Contains the primary email address for an existing Microsoft 365 or Office 365 mailbox.
    * **Username** (optional). Contains the Gmail primary email address, if it differs from EmailAddress.

    **CSV**

    ```csv
    EmailAddress
    will@fabrikaminc.net
    user123@fabrikaminc.net
    ```

    When you're finished, click **Next**.



    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration6.png" alt=""><figcaption></figcaption></figure>
3. On the **Move configuration** page, select the **Target delivery domain** from the drop down, verify other details and click **Next**.
4. On the **Schedule batch migration** page, verify all the details, click **Save** and click **Done**.

Once the batch status changes from **Syncing** to **Synced**, you need to complete the batch.



***

## REFERENCES

* [https://www.linkedin.com/pulse/how-migrate-google-workspace-office-365-easy-steps-lovely-baghel-sfijf/](https://www.linkedin.com/pulse/how-migrate-google-workspace-office-365-easy-steps-lovely-baghel-sfijf/)
* [https://support.google.com/a/answer/7378726?hl=en](https://support.google.com/a/answer/7378726?hl=en)
* [https://learn.microsoft.com/en-us/exchange/mailbox-migration/manual-gspace-migration-neweac](https://learn.microsoft.com/en-us/exchange/mailbox-migration/manual-gspace-migration-neweac)
