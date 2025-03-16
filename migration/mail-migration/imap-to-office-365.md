---
icon: envelope
---

# IMAP to Office 365

## Migrating IMAP Migration to Office 365

### Overview of IMAP Migration to Office 365 for Seamless Transition

This guide will demonstrate how to set up Internet Message Access Protocol (IMAP) for Office 365 as part of your email migration. The IMAP protocol enables email clients to access messages from a mail server. By ensuring optimal IMAP settings, you can facilitate a seamless migration of emails to Office 365.

Discover the crucial IMAP migration process to streamline your transition to Office 365. [IMAP migration process](https://www.epcgroup.net/exchange-to-office-365-migration/)

Whether transitioning from another email service or upgrading to Office 365, this guide will present step-by-step instructions. We’ll explore every part of the migration process, from enabling IMAP on your existing email service to setting up the correct configurations in Office 365, ensuring your confidence in the IMAP migration.

<figure><img src="https://cdn-ildcajp.nitrocdn.com/mperidbpvreoLetJzrcBGnjHBIWyLqtg/assets/images/optimized/rev-f7fa1fc/www.epcgroup.net/wp-content/uploads/2023/07/1.png" alt="imap-to-office-365-migration-steps" height="512" width="484"><figcaption></figcaption></figure>

#### Step 1: IMAP Migration Pre-Migration Assessment and Preparation

* Identify the source IMAP server (e.g., Gmail, Yahoo, custom IMAP) and collect all necessary login credentials for each account requiring IMAP migration.
* Calculate the data volume for each mailbox that needs to be migrated. This will aid you in estimating the time needed for the IMAP migration.
* Verify the data for any potential problems (such as attachment size and format, folder structure, etc.) that could impact the IMAP migration.
* Set up the Office 365 environment: Create accounts and assign licenses. Ensure usernames align with email addresses from the IMAP server to facilitate the migration process.
* Make sure your network bandwidth can accommodate the migration, particularly if you're considering an extensive IMAP migration of data at once.

<figure><img src="https://cdn-ildcajp.nitrocdn.com/mperidbpvreoLetJzrcBGnjHBIWyLqtg/assets/images/optimized/rev-f7fa1fc/www.epcgroup.net/wp-content/uploads/2023/07/2.png" alt="imap-account-settings" height="356" width="500"><figcaption></figcaption></figure>

#### Step 2: Setting Up Office 365 for IMAP Migration

1. **Create users in Office 365 and assign licenses for effective IMAP migration.**

* Access the Microsoft 365 admin center to add users, either individually or in bulk, while assigning the required licenses for effective migration to Office 365.
* For every user, make sure the primary email address corresponds with the one on the IMAP server. This will facilitate the correct migration of emails.

2. **Configure Exchange Online**

* Access the Exchange Admin Center. by selecting “Exchange” under “Admin Centers” in the Microsoft 365 admin center.
* Here, you can set up migration endpoints, which are configurations that point to the IMAP server. This is essential for Office 365 to establish a connection and retrieve data from the IMAP server.

3. **Establish IMAP Migration Endpoint**

* In the Exchange Admin Center, under “Recipients” > “Migration,” click on “More” (…) > “Migration endpoints.”
* Click on “+” to create a new endpoint, choose “IMAP,” and input the settings for the IMAP server.

<figure><img src="https://cdn-ildcajp.nitrocdn.com/mperidbpvreoLetJzrcBGnjHBIWyLqtg/assets/images/optimized/rev-f7fa1fc/www.epcgroup.net/wp-content/uploads/2023/07/3.png" alt="migration-endpoint-settings" height="351" width="512"><figcaption></figcaption></figure>

\
**Step 3: Configuring the IMAP Migration Endpoint**

1. **Access the Exchange Admin Center.**

* Log in to Microsoft 365 with your administrator account.
* Select "Admin" from the app launcher (or directly visit the Microsoft 365 admin center), and then navigate to "Exchange" under "Admin Centers."

2. **Access the Migration Dashboard.**

* In the Exchange Admin Center, select "Recipients" on the left, then navigate to the "Migration" tab.

3. **Establish a New IMAP Migration Endpoint**

* Select "More" (…) at the top of the page, then choose "Migration endpoints."
* Select the “+” sign on the new page to create a new endpoint.
* Select "IMAP" to set up an IMAP migration endpoint.

4. **Input the IMAP Server Configuration.**

You will be asked to provide your IMAP server details, which include:

* The IMAP server’s fully qualified domain name (FQDN) or IP address. For Gmail, this would be “[imap.gmail.com](http://imap.gmail.com/).”
* The port utilized for connecting to the IMAP server. The standard port for IMAP is 143, while the SSL port standard is 993.
* Deciding whether to utilize SSL for an IMAP server connection is essential, as most servers mandate an SSL connection.
* After entering the settings, proceed by clicking "Next."

5. **Confirm the IMAP Migration Endpoint Settings.**

* Exchange Online will test the connection to the IMAP server, and upon a successful test, you’ll receive a configuration summary of the IMAP migration endpoint.
* Click “New” to create the migration endpoint.

6. **Final Check**

* After creating the endpoint, it should be displayed in the migration endpoint dashboard within the Exchange Admin Center. Ensure it appears with the appropriate settings.

<figure><img src="https://cdn-ildcajp.nitrocdn.com/mperidbpvreoLetJzrcBGnjHBIWyLqtg/assets/images/optimized/rev-f7fa1fc/www.epcgroup.net/wp-content/uploads/2023/07/4.png" alt="exchange-admin-center-migration-batches" height="315" width="512"><figcaption></figcaption></figure>

\
**Step 4: Starting the IMAP Migration Process**

1. **Access the Exchange Admin Center.**

* Log in to Microsoft 365 with your administrator account.
* Select "Admin" from the app launcher (or directly visit the Microsoft 365 admin center), and then navigate to "Exchange" under "Admin Centers."

2. **Access the Migration Dashboard.**

* In the Exchange Admin Center, select "Recipients" on the left, then navigate to the "Migration" tab.

3. **Initiate a New IMAP Migration Batch**

* Click on “+” and select “Migrate to Office 365” from the dropdown menu.
* Select "imap migration" and press "Next."

4. **Select Users**

* On the "Select the users" page, click "Browse" to find and upload a CSV file containing the mailboxes for your IMAP migration.
* The CSV file must include an EmailAddress column listing the email addresses of the mailboxes for IMAP migration. If required by the IMAP server, the CSV may also have columns for Username and Password.
* After verifying your CSV file and uploading it, click "Next" to proceed.

5. **Configure IMAP**

* Verify that the IMAP settings align with the original email system.
* Then, click “Next”.

6. **Configure the Migration Settings**

* Label your migration batch and select the existing migration endpoint you've set up.
* You also have the choice to choose the target delivery domain for the mailboxes involved in the imap migration. This is the domain where Microsoft 365 will direct emails during the migration.

7. **Start the Migration**

* Select if you want the migration batch to start automatically or manually at a later time.
* Click "New" to set up the IMAP migration batch.

<figure><img src="https://cdn-ildcajp.nitrocdn.com/mperidbpvreoLetJzrcBGnjHBIWyLqtg/assets/images/optimized/rev-f7fa1fc/www.epcgroup.net/wp-content/uploads/2023/07/5.jpeg" alt="migration-endpoint-final-steps" height="410" width="512"><figcaption></figcaption></figure>

**Step 5: Post-Migration Tasks for IMAP Migration**

1. **Verify Migration**

* Verify that all email data has been successfully migrated to the new mailboxes, which may involve checking various folders, including the inbox, sent items, and any custom folders during the IMAP migration.

2. **Resolve any Issues**

* Resolve any issues or errors that may arise during the imap migration. These may be reflected in the migration dashboard of the Exchange Admin Center. Common problems include exceeding mailbox quotas or handling items that are too large to migrate.

3. **Reconfigure Mail Clients**

* Users need to reconfigure their email clients (like Outlook, Apple Mail, or mobile email apps) to connect to their new Microsoft 365 mailbox instead of the previous IMAP server. Guidance for this can be found in Microsoft's documentation or within the assistance resources of the specific email client.

4. **Import any IMAP PST files.**

* If users possess PST (Outlook data files) that were excluded from the IMAP migration, they might need to import them into their new Office 365 mailbox.

5. **Update MX Records**

* To guarantee that all new emails are directed to the Microsoft 365 mailboxes instead of the previous IMAP server, you must modify your domain’s MX (Mail Exchange) records. These updates may take up to 72 hours to propagate across the internet, so plan for it.

7. **Decommission Old Mailboxes**

* Once you confirm that all essential data has been migrated and all new emails direct to the new mailboxes, you can begin decommissioning the old IMAP mailboxes.

7. **Train Users**

* Educate and prepare your users to access their email, contacts, and calendar items via Microsoft 365. This may involve using Outlook, the online web app, or mobile applications.

<figure><img src="https://cdn-ildcajp.nitrocdn.com/mperidbpvreoLetJzrcBGnjHBIWyLqtg/assets/images/optimized/rev-f7fa1fc/www.epcgroup.net/wp-content/uploads/2023/07/6.jpeg" alt="office-365-admin-migration-endpoints" height="203" width="512"><figcaption></figcaption></figure>



\


***

## REFERENCES

* [https://www.epcgroup.net/imap-to-office-365-migration/](https://www.epcgroup.net/imap-to-office-365-migration/)

