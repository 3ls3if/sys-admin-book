---
icon: ubuntu
---

# Plesk to Plesk Migration

## Performing a Plesk to Plesk Migration

{% hint style="warning" %}
Plesk requires the ability to connect to your other Plesk server via your defined SSH port to complete any migrations

Plesk Migrations have to be initiated from the **destination Plesk server**
{% endhint %}

To begin your migration, you first need to ensure you are logged into your Plesk Web Interface. Once you are logged in, click on the “Tools and Settings” link on the left hand side menu.

![Plesk Obsidian Homepage](https://www.ans.co.uk/docs/_images/plesk_obsidianhomepage.PNG)

When you are on the “Tools and Settings” page, click on “Migration and Transfer Manager” which is under “Tools & Resources”.

![Plesk Obsidian Tools and Settings](https://www.ans.co.uk/docs/_images/plesk_obsidiantoolsandsettings.PNG)

Now you are within the Migration and Transfer Manager, click on “Start a New Migration”.

![Plesk Obsidian Transfer Manager](https://www.ans.co.uk/docs/_images/plesk_migrationandtransfermanager.PNG)

For “Panel type”, select Plesk and then populate the rest of the details accordingly.

{% hint style="warning" %}
UKFast Linux Servers listen on port 2020 for SSH by default
{% endhint %}

Once the details have been filled in, click the “Prepare Migration” button.

![Plesk Obsidian Migration Details](https://www.ans.co.uk/docs/_images/plesk_migrationpleskdetails.PNG)

{% hint style="warning" %}
If migrating from a Windows-based server, specify the method for installing the RPC agent (an application **enabling Plesk Migrator to gather data):**

* **Automatic** (recommended). Plesk Migrator will try to deploy and start RPC agent on the source server using the built-in administrator account. In some cases, automatic deployment may fail (for example, due to firewall settings, or because the File and Printer Sharing or RPC services are disabled). If this happens, deploy the agent manually.
* **Manual**. A link to download the RPC agent package will be provided. Download the package and install the agent on the source server manually.
{% endhint %}

When Plesk has scanned the remote server for migratable Plesk sites, select what you want to copy over. Ensure that your chosen Plesk Subscriptions are in the “Selected” box in the “Subscriptions”. Make sure you have ticked what content you want to transfer under the “Content that must be transferred” section. Once you are ready to start the migration, click the “Migrate” button.

![Plesk Obsidian Select Sites to Migrate](https://www.ans.co.uk/docs/_images/plesk_selecttomigrate.PNG)

When the migration completes, you can go to the “Domains” page linked on the left hand side menu and see the site(s) you have transferred over.

![Plesk Obsidian List Domains](https://www.ans.co.uk/docs/_images/plesk_listdomains.PNG)

{% hint style="success" %}
You have successfully performed a Plesk to Plesk Migration!

Before amending your DNS to point to your new server, you can test your websites using a hosts file change You can view more information on that [here](https://portal.ans.co.uk/safedns/index.php)
{% endhint %}



***

## REFERENCES

* [https://www.ans.co.uk/docs/operatingsystems/linux/controlpanels/migration\_plesktoplesk/](https://www.ans.co.uk/docs/operatingsystems/linux/controlpanels/migration_plesktoplesk/)
* [https://support.plesk.com/hc/en-us/articles/12377889325719-Plesk-Migration-and-Transfer-Guide](https://support.plesk.com/hc/en-us/articles/12377889325719-Plesk-Migration-and-Transfer-Guide)
* [https://docs.plesk.com/en-US/obsidian/migration-guide/migrating-from-supported-hosting-platfoms/migrating-via-the-plesk-interface.75721/](https://docs.plesk.com/en-US/obsidian/migration-guide/migrating-from-supported-hosting-platfoms/migrating-via-the-plesk-interface.75721/)
