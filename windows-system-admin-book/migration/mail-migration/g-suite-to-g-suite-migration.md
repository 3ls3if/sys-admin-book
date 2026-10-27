---
icon: g
---

# G-Suite to G-Suite Migration

## Intro

Transferring data between Google Workspace tenants is often required during use cases like mergers, acquisitions, restructurings or other organizational changes. But transferring emails, Drive files, shared drives, and calendars while preserving permissions and avoiding duplicates and downtime is challenging.

## **Reasons for Migration**

* Company rebranding or domain name change
* Mergers and acquisitions
* Departmental split or restructuring
* Consolidation of multiple domains
* Migration from a reseller to direct billing

## **Pre-Migration Considerations**

* **Data to migrate**: Emails, calendars, contacts, Drive files, sites, groups, etc.
* **Licensing**: Ensure both source and destination accounts have appropriate licenses.
* **Third-party tools**: Consider using tools like Google Workspace Migration for Microsoft Exchange (GWMME), Google Data Migration Service, or third-party solutions like CloudM, BitTitan, or SysCloud.
* **Admin roles**: Assign super admin rights for both source and destination tenants.
* **Domain verification**: The destination domain must be verified in Google Admin Console.

## **Data Migration Methods**

1. **Google Data Migration Service (DMS)**
   * Built-in tool in Google Admin Console
   * Migrates emails, calendars, and contacts
   * Supports IMAP and G-Suite as sources
2. **Third-Party Tools**
   * Provide advanced features like delta migration, user mapping, scheduling, and audit logging
   * Examples: CloudM, BitTitan MigrationWiz, SysCloud, etc.
3. **Manual Migration**
   * Users manually transfer data via Google Takeout, file sharing, or email forwarding
   * Not scalable for large organizations

## **Typical Migration Steps**

1. **Assessment & Planning**
   * Inventory users and data
   * Define scope and timeline
   * Choose migration tool
2. **Pre-Migration Setup**
   * Create user accounts in destination domain
   * Assign necessary licenses
   * Verify domains
   * Enable APIs (Admin SDK, Drive, Gmail, etc.)
3. **Migration Execution**
   * Configure and initiate migration tool
   * Monitor for errors and retry failures
   * Perform batch or phased migration
4. **Post-Migration**
   * Verify data integrity
   * Update DNS (MX, SPF, DKIM, DMARC)
   * Reassign file ownerships and permissions
   * Notify users and provide support



***

## Practical

## **Pre-Requisites**

1. **Admin access** to both source and destination Google Workspace accounts.
2. Ensure the **Admin SDK, Gmail API, and Data Migration API** are enabled on both tenants via the Google Cloud Console.
3. Users are created and licensed on the **destination** domain.
4. **Domain verification** is completed for both environments.

## Step-by-Step Migration Guide

### **Step 1: Prepare Source Environment**

1. Sign in to the **Google Admin Console** of the **source** account.
2. Go to **Security > API controls > Domain-wide delegation**.
3. Add a new client ID (to allow API access) if you're using a migration tool.
4. Make sure IMAP is enabled for all users (if using IMAP-based tools).

{% hint style="warning" %}
> For native DMS, ensure the source Gmail accounts are active and accessible.
{% endhint %}

### **Step 2: Prepare Destination Environment**

1. Sign in to the **destination Admin Console**.
2. Create all the **user accounts** (manually or via CSV/bulk upload).
3. Ensure all destination users have **Gmail enabled**.
4. Verify that necessary **licenses** are assigned.

### **Step 3: Start Data Migration (Using DMS)**

* Go to the destination **Admin Console** → **Data migration**.
  * URL: [admin.google.com](https://admin.google.com) > **Data migration**
* Click **Set up data migration**.
* Select:
  * **Migration Source**: **Google Workspace**
  * **Connection Protocol**: **Gmail**
  * **Role Account**: Admin account of source tenant (must have full access to user mailboxes)
* Enter **source admin credentials** and authorize access.
* Choose **Migration Start Date** and select data types (e.g., email, calendar, contacts).

### **Step 4: Map Users**

1. Use a **CSV file** or manually enter user mappings (source → destination email addresses).
2.  Example CSV:

    ```
    source@example.com,destination@example.com
    ```
3. Start migration for each user.

### **Step 5: Monitor and Finalize**

1. View progress in **Admin Console > Data migration**.
2. Statuses: “Running”, “Completed”, or “Failed”.
3. Retry any failed migrations.
4. Notify users when migration is complete.

### Post-Migration Tasks

* Verify mailbox content for completeness.
*   Reassign file ownership for Google Drive using:

    ```bash
    GAM tool: gam user <user> transfer drive <destination-user>
    ```
* Reconfigure:
  * Calendar shares
  * Gmail settings (filters, forwarding)
  * 3rd-party apps and OAuth permissions
* Update DNS settings (MX, SPF, DKIM, DMARC) to point to the new domain (if applicable).



{% hint style="danger" %}
## Limitations of Google DMS

* Only migrates Gmail, Contacts, and Calendar data.
* Does **not** migrate Google Drive files with original ownership or permissions.
* For Drive, use:
  * **Google Drive API scripts**
  * **Google Takeout**
  * **Google Workspace Migrate (for large orgs)**
{% endhint %}



***

## REFERENCES

* [https://www.googlecloudcommunity.com/gc/Workspace-Q-A/Workspace-to-Workspace-migration/td-p/166272](https://www.googlecloudcommunity.com/gc/Workspace-Q-A/Workspace-to-Workspace-migration/td-p/166272)
