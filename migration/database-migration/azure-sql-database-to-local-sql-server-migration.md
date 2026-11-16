---
icon: cloud
---

# Azure SQL Database to Local SQL Server Migration

### 1. Introduction

Migrating a database from Azure SQL Database to a local or on-premises Microsoft SQL Server involves exporting the database from Azure, importing it into the destination SQL Server, configuring the required database users, and optionally creating a native SQL Server backup (`.bak`) file.

A BACPAC file is used for transferring the database schema and data between supported SQL platforms. Once imported into a local SQL Server instance, the database can be managed like a regular SQL Server database.

This migration approach is useful in scenarios such as:

* Moving an application database from Azure SQL Database to an on-premises SQL Server.
* Migrating databases to a local or private hosting environment.
* Creating a local copy of an Azure-hosted database.
* Moving a database to a different SQL Server hosting provider.
* Preparing a database for traditional SQL Server backup and restore operations.

#### Migration Workflow

The overall migration process consists of the following steps:

1. Export the Azure SQL Database into BACPAC format.
2. Configure the destination SQL Server to support contained databases.
3. Import the BACPAC file into the destination SQL Server.
4. Configure and verify the required database users and permissions.
5. Optionally convert the database from PARTIAL containment to NONE.
6. Create a native SQL Server backup (`.bak`) file.
7. Restore the BAK file on the final destination SQL Server, if required.

***

### 2. Source: Export the Azure SQL Database in BACPAC Format

The first step is to export the existing database from Azure SQL Database into a `.bacpac` file.

A BACPAC file contains:

* Database schema (tables, views, stored procedures, functions, etc.).
* Table data.
* Database object definitions and supported metadata.

#### Step 1: Access Azure Portal

1. Log in to the [Microsoft Azure Portal](https://portal.azure.com/).
2. Navigate to **SQL Databases**.
3. Select the database you want to migrate.
4. Open the database overview page.

#### Step 2: Start the Export Operation

1. Select the **Export** option from the database toolbar.
2. Select the Azure Storage Account where the BACPAC file will be stored.
3. Choose the appropriate storage container.
4. Specify the BACPAC filename.
5. Enter the SQL Server administrator credentials required for the export operation.
6. Click **OK** to initiate the export.

#### Step 3: Download the BACPAC File

Once the export operation is completed:

1. Navigate to the selected Azure Storage Account.
2. Open the storage container.
3. Locate the exported `.bacpac` file.
4. Download the file to your local system or the destination server.

**Important:** Ensure that the export operation completes successfully before downloading the file. For transactionally consistent exports, avoid database write activity during the export or use a transactionally consistent copy of the database.

***

### 3. Destination: Configure the Local SQL Server

Before importing the BACPAC file, configure the destination SQL Server to support contained databases.

Azure SQL Database uses database-level authentication for contained users. During the BACPAC import process, SQL Server may need to create the database with PARTIAL containment.

By default, contained database authentication may be disabled on a local SQL Server instance.

#### Step 1: Connect to the Destination SQL Server

1. Open SQL Server Management Studio (SSMS).
2. Connect to the destination SQL Server instance.
3. Open a **New Query** window.
4. Ensure that the query is executed against the `master` database.

#### Step 2: Enable Contained Database Authentication

Execute the following commands:

```
-- Enable advanced configuration options
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

-- Enable contained database authentication
EXEC sp_configure 'contained database authentication', 1;
RECONFIGURE;
```

#### Step 3: Verify the Configuration

Execute the following query:

```
SELECT
    name,
    value,
    value_in_use
FROM sys.configurations
WHERE name = 'contained database authentication';
```

Expected output:

| Setting        | Expected Value |
| -------------- | -------------- |
| value          | 1              |
| value\_in\_use | 1              |

Both values should be `1`, confirming that contained database authentication is enabled.

**Important security consideration:** `contained database authentication` is an instance-level setting. If the destination SQL Server is shared by multiple clients, obtain approval from the SQL Server administrator before enabling it. This setting changes the authentication capabilities available across the instance, not just for the database being migrated.

***

### 4. Import the BACPAC File into the Destination SQL Server

After enabling contained database authentication, proceed with importing the BACPAC file.

#### Step 1: Launch the Import Wizard

1. Open SQL Server Management Studio.
2. Connect to the destination SQL Server instance.
3. Right-click **Databases** in Object Explorer.
4. Select **Import Data-tier Application**.

#### Step 2: Select the BACPAC File

1. Click **Next** on the introduction screen.
2. Select the option to import from a local disk.
3. Browse and select the downloaded `.bacpac` file.
4. Click **Next**.

#### Step 3: Configure the Destination Database

1. Specify the destination database name.
2. Configure the data file and log file locations, if required.
3. Review the database configuration.
4. Click **Next**.

#### Step 4: Review and Execute the Import

1. Review the import summary.
2. Check for any validation errors.
3. Click **Finish** to initiate the import.
4. Wait for the import operation to complete.

Once the operation is successful, the imported database should appear under the Databases section in SSMS.

#### Step 5: Verify the Imported Database

Execute the following query:

```
SELECT
    name,
    state_desc,
    containment_desc
FROM sys.databases
WHERE name = 'YourDatabaseName';
```

Verify that:

* The database is in the `ONLINE` state.
* The containment status is displayed correctly.
* The database objects and table data are available.

***

### 5. Create and Configure the Required Database Users

After importing the database, review the database users and their authentication types.

Database users and server-level logins are different security objects in SQL Server. A database user may need to be mapped to a SQL Server login before applications can connect using the traditional SQL Server authentication model.

#### Step 1: Check Existing Database Users

Execute the following query:

```
USE [YourDatabaseName];

SELECT
    name,
    type_desc,
    authentication_type_desc,
    sid
FROM sys.database_principals
WHERE principal_id > 4
ORDER BY name;
```

Review the output and identify:

* Existing contained database users.
* Users mapped to SQL Server logins.
* Windows or Microsoft Entra-related principals, where applicable.
* Users requiring additional permissions.

#### Step 2: Create Required SQL Server Logins

If your application requires traditional SQL Server authentication, create the necessary server-level logins.

Example:

```
USE [master];
GO

CREATE LOGIN [ApplicationUser]
WITH PASSWORD = 'ReplaceWithAStrongPassword';
GO
```

Use a strong password and store credentials securely.

#### Step 3: Map the Login to the Database User

If the corresponding database user already exists, map it to the newly created login:

```
USE [YourDatabaseName];
GO

ALTER USER [ApplicationUser]
WITH LOGIN = [ApplicationUser];
GO
```

If the database user does not exist, create it:

```
USE [YourDatabaseName];
GO

CREATE USER [ApplicationUser]
FOR LOGIN [ApplicationUser];
GO
```

#### Step 4: Assign Required Permissions

Grant only the permissions required by the application.

For example, if the application requires read and write access:

```
ALTER ROLE db_datareader
ADD MEMBER [ApplicationUser];

ALTER ROLE db_datawriter
ADD MEMBER [ApplicationUser];
```

Do not grant `db_owner` unless the application genuinely requires full database-level administrative permissions.

#### Step 5: Verify User Mapping

Execute:

```
USE [YourDatabaseName];

SELECT
    dp.name AS DatabaseUser,
    dp.type_desc,
    dp.authentication_type_desc,
    sp.name AS ServerLogin
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE dp.principal_id > 4;
```

Verify that the required database users are mapped to the appropriate server-level logins.

**Note:** Do not blindly create duplicate users or logins. If the imported user is a contained database user, preserve its identity and permissions when converting it to a traditional login-based user. The login and user SID mapping must be handled correctly.

***

### 6. Optional: Convert Database Containment from PARTIAL to NONE

After successfully importing the database, you may want to convert its containment setting from `PARTIAL` to `NONE`.

This is particularly useful when preparing a database for migration to another SQL Server instance where contained database authentication is not enabled or cannot be enabled.

Before proceeding, verify that:

* Required database users have been identified.
* Application users have been mapped to appropriate SQL Server logins.
* The application does not depend on contained database authentication.
* You have a verified backup or rollback copy.

#### Step 1: Check the Current Containment Status

Execute:

```
SELECT
    name,
    containment,
    containment_desc
FROM sys.databases
WHERE name = 'YourDatabaseName';
```

If the database is partially contained, the output will show:

| Property          | Value   |
| ----------------- | ------- |
| containment       | 1       |
| containment\_desc | PARTIAL |

#### Step 2: Map Contained Users to SQL Server Logins

If your database contains SQL-authenticated contained users, create corresponding SQL Server logins and map the existing database users to those logins.

For example, create a login using the existing database user's SID:

```
-- Run in master
CREATE LOGIN [ApplicationUser]
WITH PASSWORD = 'ReplaceWithAStrongPassword',
SID = 0x1234567890ABCDEF;
```

The SID above is only a placeholder. Use the actual SID retrieved from `sys.database_principals` for the corresponding user.

Then map the existing database user:

```
USE [YourDatabaseName];
GO

ALTER USER [ApplicationUser]
WITH LOGIN = [ApplicationUser];
GO
```

Repeat this process for each SQL-authenticated contained user that needs to use the traditional login model.

{% hint style="warning" %}
**Important:** Assign new, securely managed passwords to the corresponding SQL Server logins. Do not assume that the original Azure SQL Database password is available in the BACPAC.
{% endhint %}

Windows and Microsoft Entra principals require separate handling and should not be converted into SQL logins using this procedure.

#### Step 3: Change the Database Containment Setting

After handling the required users, execute the following command:

```
USE [master];
GO

ALTER DATABASE [YourDatabaseName]
SET CONTAINMENT = NONE;
GO
```

This changes the database from partially contained to non-contained.

#### Step 4: Verify the Change

Execute:

```
SELECT
    name,
    containment,
    containment_desc
FROM sys.databases
WHERE name = 'YourDatabaseName';
```

Expected output:

| Property          | Expected Value |
| ----------------- | -------------- |
| containment       | 0              |
| containment\_desc | NONE           |

The database is now configured as a non-contained database.

**Important:** Changing the containment setting does not automatically create SQL Server logins or migrate all database users. Complete the user mapping and application authentication checks before changing this setting.

***

### 7. Create a Native SQL Server Backup (.BAK) File

Once the database has been imported, users have been configured, and the optional containment conversion has been completed, you can create a native SQL Server backup.

A `.bak` file contains the database backup and can be restored on another compatible SQL Server instance.

#### Step 1: Open the Backup Wizard

1. Open SSMS.
2. Expand **Databases**.
3. Right-click the migrated database.
4. Select **Tasks → Back Up**.

#### Step 2: Configure Backup Settings

Configure the following:

| Setting          | Value    |
| ---------------- | -------- |
| Backup type      | Full     |
| Backup component | Database |
| Destination      | Disk     |
| Backup extension | .bak     |

1. Select **Add** under Destination.
2. Specify the backup file path.
3. Enter a filename with the `.bak` extension.
4. Click **OK** to start the backup.

Alternatively, execute the following T-SQL command:

```
BACKUP DATABASE [YourDatabaseName]
TO DISK = 'D:\SQLBackups\YourDatabaseName.bak'
WITH
    INIT,
    COMPRESSION,
    STATS = 10;
GO
```

Ensure that the SQL Server Database Engine service account has permission to write to the specified backup directory.

#### Step 3: Verify the Backup File

After the backup completes, execute:

```
RESTORE VERIFYONLY
FROM DISK = 'D:\SQLBackups\YourDatabaseName.bak';
GO
```

A successful verification indicates that SQL Server can read the backup and that its backup structure is valid. It does not replace a test restore.

***

### 8. Restore the BAK File on the Final Destination SQL Server

If you need to move the database to another SQL Server instance, you can now use the generated `.bak` file.

#### Step 1: Copy the Backup File

Transfer the `.bak` file to the destination SQL Server or a location accessible to its Database Engine service account.

#### Step 2: Restore the Database

1. Open SSMS and connect to the final destination SQL Server.
2. Right-click **Databases**.
3. Select **Restore Database**.
4. Select **Device** as the backup source.
5. Browse and select the `.bak` file.
6. Specify the destination database name.
7. Review the Files and Options pages.
8. Click **OK** to begin restoration.

#### Step 3: Verify the Restored Database

Execute:

```
SELECT
    name,
    state_desc,
    containment_desc
FROM sys.databases
WHERE name = 'YourDatabaseName';
```

Also verify:

* Tables and records.
* Stored procedures and functions.
* Database users and permissions.
* SQL Server login mappings.
* Application connectivity.

***

### 9. Important Migration Considerations

Before considering the migration complete, review the following points:

1. **SQL Server Compatibility:** Ensure the destination SQL Server version supports the database features and objects being imported. A backup created on a newer SQL Server version generally cannot be restored to an older version.
2. **Database Users:** BACPAC migration does not automatically guarantee that all authentication credentials and server-level login configurations are preserved. Review and configure users separately.
3. **Instance-Level Objects:** SQL Server Agent jobs, linked servers, server-level permissions, and other instance-level objects must be migrated separately where required.
4. **Application Connectivity:** Update the application's connection string to point to the new SQL Server instance and database.
5. **Backup Verification:** Always verify the generated backup and perform a test restore before considering the migration complete.
6. **Shared SQL Server Security:** Avoid enabling contained database authentication on a shared production SQL Server without administrator approval.
7. **BACPAC vs. BAK:** A BACPAC is primarily a schema-and-data transfer package, whereas a BAK file is a native SQL Server backup intended for database restore operations.

***

### 10. Conclusion

Migrating an Azure SQL Database to a local SQL Server can be accomplished using the BACPAC export and import process.

Once the database has been imported, the required users and permissions can be configured. If the destination environment does not support contained database authentication, the database can be reviewed, its required users mapped to SQL Server logins, and its containment setting changed from `PARTIAL` to `NONE`.

Finally, a native `.bak` backup can be generated and restored on another compatible SQL Server instance.

Following this workflow helps establish a structured migration process while maintaining database integrity, user access, and compatibility with the destination SQL Server environment.
