---
icon: microsoft
---

# SQL Server database migration

{% hint style="warning" %}
To migrate the contents of your on-premises SQL Server database, we suggest you follow the steps of the respective solutions below.

Two tools are available: you can choose between the [Data Migration Assistant](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#solution-1) (DMA) from Microsoft or the [Microsoft SQL Server Management Studio](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#solution-2) (SSMS).

We highly recommend [cleaning up](https://docs.devolutions.net/rdm/commands/administration/#clean-up) your database before proceeding with the migration.
{% endhint %}

## Solution 1

1. Download and install the [Data Migration Assistant](https://docs.microsoft.com/en-us/sql/dma/dma-overview) (DMA) from Microsoft.
2. Launch the DMA application.
3. Click on the plus "+" sign to create a new migration.
4. Select _**Migration**_ and name the _**Project**_.
5. Select the _**Source**_ of your _**server type**_ and the _**Target**_ of your _**server type**_ from the drop-down menu and leave the _**Migration scope**_ to _**Schema and data**_. Click _**Create**_.

<figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4728.png" alt=""><figcaption></figcaption></figure>

1. Enter the local _**Server name**_ and choose an _**Authentication type**_.

{% hint style="warning" %}
Make sure you have sufficient rights and permission to perform this action.
{% endhint %}

1. Click _**Connect**_.
2. Choose your database in the selection loaded and click _**Next**_.

<figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4729.png" alt="!!KB4729"><figcaption></figcaption></figure>

1.  Enter the target _**Server name**_ and choose an _**Authentication type**_.

    Make sure you have sufficient rights and permission to perform this action.
2. Click _**Connect**_.
3.  Choose your database in the selection loaded and click _**Next**_.



{% hint style="warning" %}
Your new database must have already been [created](https://docs.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart) to appear in this list.
{% endhint %}

<figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4730.png" alt="!!KB4730"><figcaption></figcaption></figure>

1.  Validate if you have issues by scrolling down the schema objects list on the left. You can click on an item for more detail on the specific issue and if a fix is available.



{% hint style="warning" %}
The user accounts with the error Windows users can be converted to external users in Azure SQL Database needs to be deselected from the list for the migration to work.

Those specific users will need to [export](https://docs.devolutions.net/rdm/kb/how-to-articles/export-import-entries/) their _**user vault**_ and configuration prior to the migration. Failing to do so will loose the data saved under those sections: _**My account settings**_, _**User-specific settings**_, and any entry made in their _**user vault**_.

After exporting the user data, you will need to create a new user in your list and reimport the data.
{% endhint %}

1.  When all the issues are fixed or deselected, click _**Generate SQL script**_.

    <figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4731.png" alt="!!KB4731"><figcaption></figcaption></figure>
2.  Once the script has been generated, validate if there are any issues, then click _**Deploy schema**_.

    <figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4732.png" alt="!!KB4732"><figcaption></figcaption></figure>



{% hint style="warning" %}
This may take some time to execute depending on how many connection history you have in your database.
{% endhint %}

1.  Once the _**Deployment results**_ is done executing, validate if there are any issues, then click _**Migrate data**_.

    &#x20;

    <figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4734.png" alt="!!KB4734"><figcaption></figcaption></figure>
2.  Click _**Start data migration**_. Note that the number of tables might be different depending on your version.

    <figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4735.png" alt="!!KB4735"><figcaption></figcaption></figure>
3.  Wait for the migration to complete. When done, you can close the _**Data Migration Assistant**_.

    &#x20;

    <figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4736.png" alt="!!KB4736"><figcaption></figcaption></figure>
4. You are now ready to create the new data source in [Remote Desktop Manager](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#connect-to-remote-desktop-manager) or update the [Devolutions Server Console](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#connect-to-devolutions-server).

<br>

***

## Solution 2 ([BACPAC](https://learn.microsoft.com/en-us/sql/relational-databases/data-tier-applications/data-tier-applications?view=sql-server-ver15#bacpac))

1. Using Microsoft SQL Server Management Studio (SSMS).
2. Connect to your source SQL Server database.
3. Right-click on the _**database name (node) – Tasks – Export Data-tier Application…**_.
4. Follow the wizard steps.
5. Using SSMS, connect to the destination SQL Server.
6. Right-click on the _**Databases (node) – Import Data-tier Application…**_.
7. Follow the wizard steps.
8. Only for Devolutions Server: In the case of a SQL data source, automatic detection already exists when exporting and the query is launched automatically, but not in Devolutions Server. Therefore, if you are migrating a Devolutions Server, you also need to run this query after the import: `UPDATE dbo.ConnectionHistory SET Version = 0x0000000000000000; UPDATE dbo.DatabaseInfo SET ConnectionCacheID = NEWID(), IntelligentCacheID = NEWID();`
9. You are now ready to create the new data source in [Remote Desktop Manager](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#connect-to-remote-desktop-manager) or update the [Devolutions Server Console](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#connect-to-devolutions-server).

<br>

***

## Solution 3

{% hint style="warning" %}
This solution is not supported for a local to local migration. Here is the error message from SSMS when trying to:

You cannot use this Wizard to move databases between local instances of SQL Server. Supported operations include deploying a local instance of SQL Server to Microsoft Azure SQL Database, from Microsoft Azure SQL Database to a local instance of SQL Server, or from one Microsoft Azure SQL Database to another Microsoft Azure SQL Database.
{% endhint %}

<br>

1. Using Microsoft SQL Server Management Studio (SSMS).
2. Right-click on the _**database name (node)**_ – _**Tasks**_ – _**Deploy Database to Microsoft Azure SQL Database.**_
3. Follow the wizard steps.
4. You are now ready to create the new data source in [Remote Desktop Manager](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#connect-to-remote-desktop-manager) or update the [Devolutions Server Console](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/#connect-to-devolutions-server).



#### Connect to Remote Desktop Manager <a href="#connect-to-remote-desktop-manager" id="connect-to-remote-desktop-manager"></a>

1. Create a new data source in _**File – Data sources – Add a new data source**_.
2.  On first connect, you may receive the following error message. If so, click on _**Fix It**_.

    <figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4646.png" alt=""><figcaption></figcaption></figure>



{% hint style="warning" %}
This may take some time to execute depending on how many connection history you have in your database.
{% endhint %}

#### Connect to Devolutions Server <a href="#connect-to-devolutions-server" id="connect-to-devolutions-server"></a>

Update the _**Host**_ and _**Database**_ name for the Devolutions Server Console in _**Server – Edit – Database**_.

<figure><img src="https://cdnweb.devolutions.net/docs/docs_en_kb_KB4971.png" alt="!!KB4971"><figcaption></figcaption></figure>



***

## REFERENCES

* [https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/](https://docs.devolutions.net/rdm/kb/how-to-articles/sql-server-database-migration/)
