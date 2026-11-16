---
icon: bars-progress
---

# Local SQL Server to Azure SQL Migration

### 1. Introduction

Migrating a database from a local or on-premises Microsoft SQL Server to Microsoft Azure involves transferring the existing database schema, data, and required configurations to an Azure-hosted SQL platform.

There are multiple ways to perform this migration depending on the database size, compatibility requirements, acceptable downtime, and the Azure SQL deployment model.

The three primary destination options are:

1. **Azure SQL Database:** A fully managed Platform as a Service (PaaS) offering. Native `.bak` restoration is not supported. BACPAC import or supported migration tools can be used.
2. **Azure SQL Managed Instance:** A managed SQL Server environment that offers greater compatibility with traditional SQL Server features and supports native backup restoration from Azure Blob Storage.
3. **SQL Server on Azure Virtual Machine:** A traditional SQL Server instance hosted on an Azure VM. It supports standard SQL Server backup and restore operations.

This article covers three approaches to migrating a local SQL Server database to Azure.

#### Migration Methods

| Method                       | Destination                                         | Recommended scenario                                                |
| ---------------------------- | --------------------------------------------------- | ------------------------------------------------------------------- |
| Method 1: BACPAC             | Azure SQL Database                                  | Smaller databases and offline migrations                            |
| Method 2: Migration tools    | Primarily Azure SQL Database                        | Larger databases, compatibility assessment, or controlled migration |
| Method 3: Native BAK restore | Azure SQL Managed Instance / SQL Server on Azure VM | Native SQL Server backup migration                                  |

***

### 2. Prerequisites

Before starting the migration, ensure the following requirements are met:

* Access to the source SQL Server instance.
* SQL Server Management Studio (SSMS).
* A full database backup (`.bak`) if the database needs to be restored locally first.
* An active Azure subscription.
* Appropriate permissions to create and manage Azure SQL resources.
* Network connectivity between the source environment and Azure, where required.
* Sufficient storage and compute capacity on the destination.
* Confirmation that the source database is compatible with the selected Azure SQL deployment model.

**Important:** Azure SQL Database does not support every SQL Server feature. Review the compatibility requirements before choosing it as the destination.

***

## Method 1: Convert the Database to BACPAC Format (Best for Smaller Databases)

A BACPAC file contains the database schema and data and can be imported into Azure SQL Database.

This is a straightforward migration approach when the database is relatively small and an offline migration is acceptable.

#### Step 1: Restore the Existing BAK File Locally

If you already have a `.bak` file, restore it to a local SQL Server instance before exporting it to BACPAC format.

1. Open SQL Server Management Studio.
2. Connect to your local SQL Server instance.
3. Right-click **Databases**.
4. Select **Restore Database**.
5. Choose **Device** as the backup source.
6. Browse and select the `.bak` file.
7. Specify the destination database name.
8. Review the database files and restore options.
9. Click **OK** to start the restoration.

Alternatively, if the database is already available on the local SQL Server, you can directly proceed to the export operation.

#### Step 2: Export the Database to BACPAC Format

Once the database has been restored successfully:

1. In SSMS, expand **Databases**.
2. Right-click the database you want to migrate.
3. Select **Tasks → Export Data-tier Application**.
4. Click **Next** on the introduction screen.
5. Choose the option to save the BACPAC file to a local disk.
6. Specify the BACPAC filename and destination path.
7. Review the export settings.
8. Click **Finish** to initiate the export.

Wait until the export operation completes successfully.

The generated `.bacpac` file contains the supported database schema and data.

**Alternative:** You can use the SqlPackage command-line utility to export the database:

```
SqlPackage /Action:Export `
  /SourceServerName:"localhost" `
  /SourceDatabaseName:"YourDatabaseName" `
  /TargetFile:"C:\SQLBackups\YourDatabaseName.bacpac" `
  /SourceTrustServerCertificate:True
```

Adjust the server name, authentication options, and file path according to your environment.

#### Step 3: Create an Azure SQL Database

1. Log in to the [Microsoft Azure Portal](https://portal.azure.com/).
2. Search for **SQL databases**.
3. Select **Create**.
4. Choose the appropriate Azure subscription and resource group.
5. Specify the database name.
6. Create a new logical SQL server or select an existing one.
7. Configure the desired compute and storage pricing tier.
8. Configure networking and firewall access.
9. Review the configuration.
10. Click **Create**.

Wait for Azure to deploy the SQL Database.

#### Step 4: Import the BACPAC File into Azure

There are two common ways to import the BACPAC file.

**Option A: Import through Azure Portal**

1. Navigate to the Azure SQL logical server.
2. Locate the **Import database** option.
3. Select the Azure Storage Account containing the BACPAC file.
4. Browse and select the exported `.bacpac` file.
5. Specify the destination database name.
6. Enter the required SQL administrator credentials.
7. Select the desired pricing tier.
8. Start the import operation.

Monitor the deployment until the import completes successfully.

**Option B: Import through SSMS**

1. Open SQL Server Management Studio.
2.  Connect to the Azure SQL logical server using its fully qualified server name:

    `yourserver.database.windows.net`
3. Expand **Databases**.
4. Right-click **Databases**.
5. Select **Import Data-tier Application**.
6. Browse and select the local `.bacpac` file.
7. Specify the destination database name.
8. Configure the database settings.
9. Click **Next** and review the import summary.
10. Click **Finish**.

Wait for the import operation to complete.

#### Step 5: Verify the Imported Database

After the import completes, connect to the Azure SQL Database and verify the database objects and records.

For example:

```
SELECT
    DB_NAME() AS DatabaseName,
    COUNT(*) AS TotalTables
FROM sys.tables;
```

You can also execute:

```
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;
```

Verify that:

* All required tables are available.
* The expected records have been imported.
* Stored procedures and functions are available.
* Application queries execute successfully.
* Database users and permissions have been configured.

**Important considerations:**

* BACPAC export and import require downtime or a transactionally consistent source copy to prevent inconsistent data.
* BACPAC is generally more suitable for smaller databases.
* Large databases with numerous objects can take considerable time to export and import.
* Some SQL Server features and objects are not supported in Azure SQL Database.
* Server-level logins, SQL Agent jobs, linked servers, and other instance-level configurations must be handled separately where applicable.

***

## Method 2: Use Azure Migration Tools (Recommended for Larger or More Complex Migrations)

If the database is large or contains SQL Server features that may not be supported by Azure SQL Database, consider using dedicated migration and assessment tools.

This approach helps identify compatibility issues before migration and provides additional migration options.

#### Step 1: Restore the BAK File Locally

If you have an existing `.bak` file, restore it on a local SQL Server instance.

1. Open SSMS.
2. Connect to the source SQL Server.
3. Right-click **Databases**.
4. Select **Restore Database**.
5. Browse and select the `.bak` file.
6. Specify the database name.
7. Start the restore operation.

Ensure the database is online and accessible before proceeding.

#### Step 2: Assess Database Compatibility

Before migrating the database to Azure SQL Database, identify unsupported features and potential migration blockers.

You can use the following tools:

**Option A: Data Migration Assistant (DMA)**

Data Migration Assistant can assess a SQL Server database for compatibility with Azure SQL Database.

1. Install Microsoft Data Migration Assistant.
2. Open DMA.
3. Select **New (+)** to create an assessment project.
4. Select SQL Server as the source platform.
5. Select Azure SQL Database as the target platform.
6. Connect to the local SQL Server instance.
7. Select the database to assess.
8. Choose the assessment report options.
9. Run the assessment.

Review the generated report for:

* Unsupported SQL Server features.
* Breaking changes.
* Deprecated features.
* Compatibility issues.
* Recommended remediation steps.

Resolve blocking issues before beginning the migration.

**Note:** DMA is an assessment tool; it should not be treated as the service that directly transfers the database to Azure.

#### Step 3: Select a Migration Tool

Depending on the target, database size, and downtime requirements, select an appropriate migration approach.

Common options include:

* Azure Database Migration Service (Azure DMS).
* SQL Server Migration through the current SSMS migration experience.
* SqlPackage for BACPAC export and import.
* Transactional replication for supported Azure SQL Database scenarios.

For an offline migration using Azure DMS:

1. Open the Azure Portal.
2. Search for **Azure Database Migration Service**.
3. Create or select a migration service instance.
4. Configure the required source and destination connectivity.
5. Create a migration project for the supported SQL Server-to-Azure SQL Database scenario.
6. Configure the source SQL Server connection.
7. Configure the destination Azure SQL Database connection.
8. Select the database to migrate.
9. Review the migration configuration.
10. Start the migration.

Monitor the migration activity and review any errors or warnings.

**Important:** Check the current Azure DMS support matrix for the selected source version, target, region, and migration mode. Azure SQL Database does not currently support online continuous migration through Azure DMS in the same way as Azure SQL Managed Instance.

#### Step 4: Verify the Migration

Once the migration is completed:

1. Connect to the destination Azure SQL Database.
2. Verify the database schema.
3. Check the migrated records.
4. Review stored procedures, functions, and views.
5. Configure the required database users and permissions.
6. Test application connectivity.
7. Validate application functionality.

For production migration, plan a cutover window and ensure that application writes to the source database are stopped or synchronized appropriately before the final migration.

***

## Method 3: Direct BAK Restore (Azure SQL Managed Instance / SQL Server on Azure VM)

If you want to migrate a database using the native SQL Server `.bak` backup without converting it to BACPAC, choose an Azure SQL deployment that supports native backup restoration.

This method is suitable for Azure SQL Managed Instance and SQL Server installed on an Azure Virtual Machine.

**Important distinction:** Standard Azure SQL Database does not support direct restoration of native `.bak` files.

### Option A: Restore the BAK File to Azure SQL Managed Instance

Azure SQL Managed Instance supports native database backup and restore from Azure Blob Storage.

#### Step 1: Create an Azure Storage Account

1. Log in to the Azure Portal.
2. Search for **Storage Accounts**.
3. Select **Create**.
4. Select the required subscription and resource group.
5. Specify the storage account name.
6. Select the appropriate region.
7. Configure the required redundancy.
8. Complete the deployment.

#### Step 2: Create a Blob Container

1. Open the newly created Storage Account.
2. Navigate to **Data Storage → Containers**.
3. Click **+ Container**.
4.  Specify a container name, for example:

    `sql-backups`
5. Create the container.

#### Step 3: Upload the BAK File

1. Open the newly created container.
2. Select **Upload**.
3. Browse and select the `.bak` file.
4. Start the upload.
5. Wait for the upload to complete.

#### Step 4: Generate a Shared Access Signature (SAS)

A Shared Access Signature provides delegated access to the storage resource.

1. Open the Storage Account.
2. Navigate to **Shared access signature**.
3. Configure the required permissions.
4. Select an appropriate start and expiry time.
5. Generate the SAS token.

Ensure that the SAS has the permissions required by the selected restore workflow, including read access to the backup file.

Keep the SAS token secure. It provides access to the storage resource within the permissions and validity period granted.

#### Step 5: Configure SQL Managed Instance Access to Azure Storage

Before restoring, configure the required credentials and storage access according to the Managed Instance backup and restore requirements.

For example, when using a SAS token, a database-scoped credential can be created using the appropriate container URL and SAS token.

```
USE master;
GO

CREATE CREDENTIAL [https://storageaccount.blob.core.windows.net/sql-backups]
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'YourSASTokenWithoutQuestionMark';
GO
```

Use the exact container URL and a valid SAS token. The credential name must match the storage container URL used by the restore operation.

#### Step 6: Restore the Database from the BAK File

Connect to the Azure SQL Managed Instance using SSMS.

Execute the restore command:

```
RESTORE DATABASE [YourDatabaseName]
FROM URL = 'https://storageaccount.blob.core.windows.net/sql-backups/YourDatabaseName.bak';
GO
```

Monitor the restoration process until it completes.

The exact restore options depend on the backup file and the Managed Instance configuration.

#### Step 7: Verify the Restored Database

Execute:

```
SELECT
    name,
    state_desc
FROM sys.databases
WHERE name = 'YourDatabaseName';
```

Confirm that the database is online and accessible.

Also verify the database objects, records, user permissions, and application connectivity.

### Option B: Restore the BAK File to SQL Server on an Azure Virtual Machine

If you have deployed a Windows Server VM in Azure with SQL Server installed, you can use the traditional SQL Server backup and restore process.

#### Step 1: Access the Azure Virtual Machine

1. Log in to the Azure Portal.
2. Navigate to **Virtual Machines**.
3. Select the SQL Server VM.
4. Connect to the VM using RDP.

#### Step 2: Transfer the BAK File

Copy the backup file to the Azure VM using an approved transfer method.

For example:

`D:\SQLBackups\YourDatabaseName.bak`

Ensure the SQL Server Database Engine service account has access to the backup directory.

#### Step 3: Restore the Database

1. Open SSMS inside the Azure VM.
2. Connect to the SQL Server instance.
3. Right-click **Databases**.
4. Select **Restore Database**.
5. Select **Device** as the backup source.
6. Browse and select the `.bak` file.
7. Configure the destination database name.
8. Review the restore settings.
9. Click **OK**.

Alternatively, use T-SQL:

```
RESTORE DATABASE [YourDatabaseName]
FROM DISK = 'D:\SQLBackups\YourDatabaseName.bak'
WITH
    RECOVERY,
    STATS = 10;
GO
```

If the physical database file paths differ between the source and destination, use `WITH MOVE` to specify the destination data and log file paths.

#### Step 4: Verify the Restored Database

Execute:

```
SELECT
    name,
    state_desc
FROM sys.databases
WHERE name = 'YourDatabaseName';
```

Verify that the database is online and that the application can connect successfully.

***

## 3. Post-Migration Tasks and Verification

Regardless of the migration method, complete the following checks before considering the migration successful.

#### 1. Verify Database Objects

Check that all required:

* Tables
* Views
* Stored procedures
* Functions
* Triggers
* Indexes

are available.

#### 2. Verify Database Users and Permissions

Review the database users and configure the required authentication.

For Azure SQL Database, database-level users and Microsoft Entra authentication should be configured according to the application's authentication requirements.

For Azure SQL Managed Instance and SQL Server on Azure VM, review server logins and database user mappings separately.

#### 3. Update Application Connection Strings

Update the application's database connection string to point to the Azure destination.

Example for Azure SQL Database:

```
Server=tcp:yourserver.database.windows.net,1433;
Initial Catalog=YourDatabaseName;
Persist Security Info=False;
User ID=YourSQLAdmin;
Password=YourPassword;
MultipleActiveResultSets=False;
Encrypt=True;
TrustServerCertificate=False;
Connection Timeout=30;
```

For production applications, use secure secret storage and Microsoft Entra authentication where appropriate instead of embedding passwords in configuration files.

#### 4. Configure Network Access

For Azure SQL Database:

* Configure the SQL logical server firewall rules.
* Allow only the required client IP addresses or network paths.
* Configure private endpoints if required by the security architecture.

For Managed Instance and SQL Server on Azure VM:

* Verify the required network connectivity.
* Review NSGs, routing, firewall rules, and DNS.
* Restrict database access to authorized networks.

#### 5. Perform Application Testing

Verify:

* Application database connectivity.
* Login and authentication.
* Insert, update, and delete operations.
* Stored procedure execution.
* Reporting and scheduled processes.
* Application performance.

#### 6. Configure Backup and Recovery

Review the backup and recovery requirements for the selected Azure SQL deployment.

Azure SQL Database and Azure SQL Managed Instance provide managed automated backups. SQL Server on Azure VM requires an appropriate SQL Server backup and recovery strategy.

***

## 4. Important Considerations

Before selecting a migration method, consider the following:

1. **Database Size:** BACPAC is generally more suitable for smaller databases. Large databases may benefit from dedicated migration tools or native backup restoration to Managed Instance or Azure VM.
2. **SQL Server Compatibility:** Not every SQL Server feature is supported in Azure SQL Database. Run a compatibility assessment before migration.
3. **Downtime:** BACPAC and offline migration approaches require a planned period during which source changes must be stopped or otherwise synchronized.
4. **SQL Server Logins:** Server-level logins and database users may require separate migration and mapping.
5. **SQL Agent Jobs:** Azure SQL Database does not support traditional SQL Server Agent. Review alternative scheduling solutions such as Azure Elastic Jobs or Azure Automation.
6. **Linked Servers:** Review linked-server dependencies because Azure SQL Database has different capabilities from a full SQL Server instance.
7. **Performance and Pricing:** Select the appropriate Azure compute and storage tier based on actual workload requirements.
8. **Security:** Use encrypted connections, secure credentials, appropriate firewall restrictions, and least-privilege access.
9. **Backup Compatibility:** A native `.bak` file cannot be directly restored to Azure SQL Database. Use BACPAC or a supported database migration method instead.

***

## 5. Conclusion

Migrating a local SQL Server database to Azure can be accomplished using different approaches depending on the destination platform and database requirements.

For smaller databases, exporting the database into BACPAC format and importing it into Azure SQL Database is a straightforward approach.

For larger or more complex migrations, compatibility assessment and dedicated migration tools can help identify issues and select an appropriate migration workflow.

If you want to retain native SQL Server backup and restore functionality, Azure SQL Managed Instance or SQL Server on an Azure Virtual Machine can be more suitable destinations.

Selecting the correct Azure SQL deployment model before beginning the migration is essential for ensuring compatibility, minimizing downtime, and maintaining application functionality after migration.
