---
icon: g
---

# Google Workspace to Office 365 (Automatic Method)

## Prerequisites

### Check Google Cloud platform permissions <a href="#check-google-cloud-platform-permissions" id="check-google-cloud-platform-permissions"></a>

An [automated scenario](https://learn.microsoft.com/en-us/exchange/mailbox-migration/automated-migration-neweac) requires the Google Migration administrator to be able to perform the following steps in the [Google admin console](https://admin.google.com/AdminHome):

1. <mark style="color:green;">Create a Google Workspace project.</mark>
2. <mark style="color:green;">Create a Google Workspace service account in the project.</mark>
3. <mark style="color:green;">Create a service key.</mark>
4. <mark style="color:green;">Enable all APIs - Gmail, Calendar, and Contacts.</mark>

The Google Migration administrator needs the following permissions to complete these steps:

* <mark style="color:green;">resourcemanager.projects.create</mark>
* <mark style="color:green;">iam.ServiceAccounts.create</mark>

The most secure way to achieve completion of these four steps is to assign the following roles to the Google Migration administrator:

* <mark style="color:green;">Projector Creator</mark>
* <mark style="color:green;">Service Accounts Creator</mark>

Here's how you do it:

1. <mark style="color:green;">Navigate to</mark> [<mark style="color:green;">https://console.developers.google.com</mark>](https://console.developers.google.com/)<mark style="color:green;">.</mark>
2.  <mark style="color:green;">Expand the hamburger menu in the upper right-hand corner.</mark>

    ![image](https://user-images.githubusercontent.com/5260172/152607089-76d8f272-3bd5-4f19-9e23-4fca882a789d.png)
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**IAM & Admin**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manage Resources**</mark><mark style="color:green;">.</mark>
5. <mark style="color:green;">Select the appropriate resource and in the right-hand pane under the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Permissions**</mark> <mark style="color:green;"></mark><mark style="color:green;">tab, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add Principal**</mark><mark style="color:green;">.</mark>
6. <mark style="color:green;">Enter your Google Migration administrator credentials, enter</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Project Creator</mark>_ <mark style="color:green;"></mark><mark style="color:green;">in the filter, and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Project Creator**</mark><mark style="color:green;">.</mark>
7. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add Another Role**</mark><mark style="color:green;">, enter</mark> <mark style="color:green;"></mark>_<mark style="color:green;">Create Service Accounts</mark>_ <mark style="color:green;"></mark><mark style="color:green;">in the filter, and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Create Service Accounts**</mark><mark style="color:green;">.</mark>
8. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Save**</mark><mark style="color:green;">.</mark>

{% hint style="warning" %}
**Note**

It might take up to 15 minutes to propagate role assignment changes across the globe.
{% endhint %}



***

{% hint style="danger" %}
## ISSUES

* **Problem:** The Google Cloud service account used for the migration might not have the required permissions to create and manage keys, leading to the JSON file not being downloaded automatically.&#x20;
* **Solution:**
  * Navigate to Google Cloud's IAM & Admin console and ensure the service account has the **Organization Policy Administrator** role.&#x20;
  * In **Organization Policies**, locate **"Disable service account key creation"** and set it to **OFF.**&#x20;
{% endhint %}

{% hint style="danger" %}
## Additional Settings

I had the same problem after completing the EOP wizard for Workspace migration. Took me a couple of hours to figure out 8-/

With a Workspace super admin, login to [https://console.cloud.google.com](https://console.cloud.google.com). Make sure you're working in the root org.

* Select IAM and admin.
* In IAM on left-hand menu, edit permissions for organisation.
* Add Organisation Policy Administrator and save.
* Go to Organisation policies in left-hand menu.
* Search for 'Disable service account key creation'.
* Edit policy, set Enforcement to Off and save.
* Change workspace from root org to the project the 365 wizard created. Mine was called projectnamempij.
* In IAM and admin, go to Service accounts in left-hand menu.
* In the 3 dots menu besides the service account, select Manage keys.
* When in service account, Add key -> Create new key.
* The json file is created and downloaded.
* Create a new endpoint in Exchange Online and use the downloaded json
{% endhint %}

***

## Start an automated Google Workspace migration batch in EAC

1.  In the [Exchange Admin center](https://admin.exchange.microsoft.com/), go to **Migration**, and then select **Add migration batch**.



    The **Add migration batch** page appears.

    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/add-migration-batch-option.png" alt=""><figcaption></figcaption></figure>
2.  Configure the following settings:

    * **Give migration batch a unique name**: Enter a unique name.
    * **Select the mailbox migration path**: Verify that **Migration to Exchange Online** is selected.



    When you're finished, click **Next**.

    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration1.png" alt=""><figcaption></figcaption></figure>
3.  On the **Select the migration type** page, select **Google Workspace (Gmail) migration** as migration type, and click **Next**.



    The **Prerequisites for Google Workspace migration** page appears.

    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration2.png" alt=""><figcaption></figcaption></figure>
4.  Verify that the **Automate the configuration of your Google Workspace for migration** section is expanded, and then select **Start** in that section to automate the four required prerequisite steps.



    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration3.png" alt=""><figcaption></figcaption></figure>
5.  In the Google sign-in page that appears, sign in to your Google account to validate your APIs.

    \
    Once the APIs are successfully validated, the following things happen:

    * A JSON file (projectid-\*.json) is downloaded to your local system.
    * The link to add the ClientID and the Scope is provided. The ClientID and Scope are also listed for your reference.

    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration3a.png" alt=""><figcaption></figcaption></figure>
6. Select the API access link. You'll be redirected to Google Admin API Controls page.
7. Select **Add new**. Copy the ClientID and Scope from the EAC, paste it here, and then select **Authorize**.
8. Once the four prerequisites-related steps are completed, select **Next**. The **Set a migration endpoint** page appears.
9.  Select one of the following options:

    * **Select the migration endpoint**: Select an existing migration endpoint from the drop-down list.
    * **Create a new migration endpoint**: Select this option if you're a first-time user.



    &#x20;

    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration4.png" alt=""><figcaption></figcaption></figure>





{% hint style="warning" %}
**Note**

To migrate Gmail mailboxes successfully, Microsoft 365 or Office 365 needs to connect and communicate with Gmail. To do this connection-communication, Microsoft 365 or Office 365 uses a migration endpoint. Migration endpoint is a technical term that describes the settings that are used to create the connection so you can migrate the mailboxes.
{% endhint %}

If you've selected **Create a new migration endpoint**, do the following steps:

1.  On the **General Information** page, configure the following settings:

    * **Migration Endpoint Name**: Enter a value.
    * **Maximum concurrent migrations**: Leave the default value **20** or change the value as required.
    * **Maximum concurrent incremental syncs**: Leave the default value **10** or change the value as required.

    When you're finished, select **Next**.
2.  On the **Gmail migration configuration** page, configure the following settings:

    * **Email address**: Enter the email address that you use to sign in to the Google Workspace.
    * **JSON key**: Select **Import JSON**. In the dialog box that appears, find and select the downloaded JSON file, and then select **Open**.

    Once the endpoint is successfully created, it will be listed in the **Select migration endpoint** drop-down list.

    * Select the endpoint from the drop-down list, and select **Next**. The **Add user mailboxes** page appears.

<figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration5.png" alt=""><figcaption></figcaption></figure>

1. Select **Import CSV file** and navigate to the folder where you've saved the CSV file.

If you haven't already saved or created the CSV file, create a CSV file containing the set of names of the users you want to migrate. You'll need its filename below. The allowed headers are:

* **EmailAddress** (required): Contains the primary email address for an existing Microsoft 365 or Office 365 mailbox.
* **Username** (optional). Contains the Gmail primary email address, if it differs from EmailAddress.

**CSV**

```csv
EmailAddress
will@fabrikaminc.net
user123@fabrikaminc.net
```

When you're finished, click **Next**. The **Move configuration** page appears.

11. From the **Target delivery domain** drop-down list, select the target delivery domain (the subdomain) that was created as part of fulfilling the [Google Workspace migration prerequisites in Exchange Online](https://learn.microsoft.com/en-us/exchange/mailbox-migration/google-workspace-migration-prerequisites), and click **Next**.

&#x20;

{% hint style="warning" %}
**Note**

The target delivery domain (the subdomain) you select in this step can be either an existing one or the one that you've created in [Google Workspace migration prerequisites in Exchange Online](https://learn.microsoft.com/en-us/exchange/mailbox-migration/google-workspace-migration-prerequisites).

If you don't see the target delivery domain that you want to select in the **Target delivery domain** drop-down list, you can manually enter the name of the target delivery domain in the text box.

The text box in which you manually enter the name of the target delivery domain is **Target delivery domain**. That is, the text box is effectively the **Target delivery domain** drop-down list, which is taking the role of a text box when you manually enter text into it.

Filtering options have been introduced for the migration of Google Workspace to Microsoft 365 or Office 365. For more information on these filtering options, see [Filtering Options for Google Workspace migration](https://learn.microsoft.com/en-us/exchange/mailbox-migration/automated-migration-neweac#filtering-options-for-google-workspace-migration).
{% endhint %}



12. On the **Schedule batch migration** page, verify all the details, click **Save**, and then click **Done**.



    <figure><img src="https://learn.microsoft.com/en-us/exchange/exchangeonline/mailbox-migration/media/gmail-workspace-migration7.png" alt=""><figcaption></figcaption></figure>

Once the batch status changes from **Syncing** to **Synced**, you need to complete the batch.



{% hint style="warning" %}
#### Filtering Options for Google Workspace migration <a href="#filtering-options-for-google-workspace-migration" id="filtering-options-for-google-workspace-migration"></a>

Filtering options enable you to determine what are the mail-related components to be migrated from the Google Workspace.

The filter options for the Google Workspace migration are:

* Mail
* Calendar
* Contacts
* Rules
{% endhint %}



***

## REFERENCES

* [https://learn.microsoft.com/en-us/exchange/mailbox-migration/google-workspace-migration-prerequisites](https://learn.microsoft.com/en-us/exchange/mailbox-migration/google-workspace-migration-prerequisites)
* [https://learn.microsoft.com/en-us/exchange/mailbox-migration/automated-migration-neweac](https://learn.microsoft.com/en-us/exchange/mailbox-migration/automated-migration-neweac)
* [https://www.c-sharpcorner.com/article/fix-google-to-office-365-migration-error-service-account-key/](https://www.c-sharpcorner.com/article/fix-google-to-office-365-migration-error-service-account-key/)
* [https://learn.microsoft.com/en-us/answers/questions/1624193/google-workspace-migration-json-download-issue](https://learn.microsoft.com/en-us/answers/questions/1624193/google-workspace-migration-json-download-issue)
