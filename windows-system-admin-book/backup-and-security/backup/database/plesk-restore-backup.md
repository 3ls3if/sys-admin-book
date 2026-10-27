---
icon: database
---

# Plesk: Restore Backup

{% hint style="warning" %}
**Note:** When you restore objects from a backup, they overwrite and replace existing objects with the same name. You will not be prompted when an object being restored is about to overwrite an existing one. You will lose all changes to objects being restored that were made after the backup was created.
{% endhint %}

## 1. Restoring All Objects

To restore all objects from a backup:

1. Go to **Websites & Domains** >  **Backup Manager**. Here you can see all backups stored both in the server storage and [remote storages](https://docs.plesk.com/en-US/obsidian/customer-guide/backing-up-and-restoring-websites/configuring-remote-storage.78922/).
2. Click the backup you want to restore.
3. Under “What do you want to restore?” select the “All objects (entire system)” radio button.
4.  Under “Components to restore” you can clear checkboxes next to classes of objects you do not want to restore. For example, when restoring a backup, if the “Databases” checkbox is selected, all databases and database users will be restored. If you clear the checkbox, none will be restored.



    <figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78913.webp" alt=""><figcaption></figcaption></figure>
5.  If you are restoring a backup secured with a password, select the “Get password from settings of Remote storage” radio button. Plesk will attempt to fetch the password automatically. If the password cannot be fetched automatically (for example, you are restoring a backup created on a different server), select the “Input password manually” radio button and type the password in the corresponding fields.



    If the password cannot be fetched automatically and you do not know it, clear the “Provide password” checkbox. Plesk will restore the backup, but all passwords for restored objects (such as database users or mail accounts) will be generated randomly.

    <figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78914.webp" alt=""><figcaption></figcaption></figure>
6. At this point, the backup is ready to be restored. There are a number of optional settings you can configure before restoring the backup:
   * Select the “Suspend domains until the restoration is completed” checkbox if you want to ensure the validity of the restoration. Doing so will make your website unavailable until the restoration process is finished. Website visitors will see an error page with the 503 HTTP status code.
   * Select the “When the restoration is completed, send a notification to” checkbox if you want to be notified via email when the restoration is finished. Make sure that the email address next to the checkbox is correct.
7. Click **Restore** to begin restoring from the backup.

You will be returned to the **Websites & Domains** > **Backup Manager** screen where you can see the backup being restored. The restoration process can take some time to finish, depending on the size of the content being restored. A notification will come up on this screen once the backup has been restored.

<figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78912.webp" alt=""><figcaption></figcaption></figure>



***

## 1. Restoring Individual Objects

{% hint style="warning" %}
You do not have to restore all configuration and content stored in a backup file. You can pick which objects to restore from the backup (for example, a single domain and all associated objects, a single mail account, or even just a single individual file).
{% endhint %}

To restore individual objects from a backup:

1. Go to **Websites & Domains** > **Backup Manager**. Here you can see all backups stored both in the server storage and [remote storages](https://docs.plesk.com/en-US/obsidian/customer-guide/backing-up-and-restoring-websites/configuring-remote-storage.78922/).
2. Click the backup you want to restore.
3. Under “What do you want to restore?” select the “Selected objects” radio button.
4. Under “Type of object to restore” select the type of objects you want to restore:
   * <mark style="color:green;">Mail account. Restore individual mail accounts.</mark>
   * <mark style="color:green;">Database. Restore individual databases.</mark>
   * <mark style="color:green;">Sites. Restore individual websites with all associated objects and content (mail accounts, databases, and so on).</mark>
   * <mark style="color:green;">DNS Zone. Restore DNS zone contents for individual domains.</mark>
   *   <mark style="color:green;">Files of domains. Restore individual files.</mark>

       If you want to restore objects of different types (for example, a single mail account and two databases), you would need to run the restoration twice, once for the databases, and once for the mail account.
5. Select which objects to restore. All available objects of the selected type are displayed in the “Available” column on the left. Click the objects you want to restore. Those objects will move to the “Selected” column.



<figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78916.webp" alt=""><figcaption></figcaption></figure>

If you selected “Files of domains” during the previous step, click **Add files**, select the file or files you want to restore, and then click **OK**.

<figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78917.webp" alt=""><figcaption></figcaption></figure>

You can select any number of files to restore.

1.  Under “Restore”, select whether to restore only the configuration of the selected objects, or both the configuration and content.



    For example, when restoring a database, selecting the former option will restore the database and the associated database users, but not the tables or the data. If the backup file only contains the configuration but not the content, this option is unavailable.

    <figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78918.webp" alt=""><figcaption></figcaption></figure>
2. At this point, the backup is ready to be restored. There are a number of optional settings you can configure before restoring the backup:
   * Select the “Suspend domains until the restoration is completed” checkbox if you want to ensure the validity of the restoration. Doing so will temporarily make your website unavailable. Until the restoration process is finished, visitors to your website will see an error page with the 503 HTTP status code.
   * Select the “When the restoration is completed, send a notification to” checkbox if you want to be notified via email when the restoration is finished. Make sure that the email address next to the checkbox is correct.
3.  If you are restoring a backup secured with a password, Plesk prompts you to provide the password. We recommend selecting the “Get password from settings of Remote storage” radio button. This will automatically fetch a password specified in the Remote storage settings. If the password cannot be fetched automatically (for example, you are restoring the backup created on another server) select the “Input password manually radio button” and type in the password in the corresponding fields.



    If the password cannot be fetched automatically and you have forgotten it, clear the Provide password checkbox. Plesk will restore the backup but certain data will not be recovered properly. For example, all passwords inside the backup database will be generated randomly.

    <figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78919.webp" alt=""><figcaption></figcaption></figure>
4. Click **Restore** to begin restoring from the backup.

You will be returned to the **Websites & Domains** > **Backup Manager** screen where you can see the backup being restored. The restoration process can take some time to finish, depending on the size of content being restored. A notification will come up on this screen once the backup has been restored.

<figure><img src="https://docs.plesk.com/en-US/obsidian/customer-guide/images/78921.webp" alt=""><figcaption></figcaption></figure>



***

## REFERENCES

* [https://docs.plesk.com/en-US/obsidian/customer-guide/backing-up-and-restoring-websites/restoring-backups.65200/](https://docs.plesk.com/en-US/obsidian/customer-guide/backing-up-and-restoring-websites/restoring-backups.65200/)
