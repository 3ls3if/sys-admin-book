---
icon: microsoft
---

# SQL Server Database Migration from a Higher Version to a Lower Version Using Generate Scripts

## SQL Server Database Migration from a Higher Version to a Lower Version Using Generate Scripts

### 1. Introduction

Database migration between different SQL Server versions is a common requirement in hosting environments, particularly when migrating databases between servers with different SQL Server installations.

One challenge occurs when migrating a database from a newer SQL Server instance to an older SQL Server instance.

For example:

* Source SQL Server: SQL Server 2019
* Destination SQL Server: SQL Server 2016

In this scenario, the traditional database backup and restore method does not work because SQL Server does not support restoring backups created on newer versions to older versions.

This article explains how to migrate a database from SQL Server 2019 to SQL Server 2016 using SQL Server Management Studio (SSMS), including schema, data, database users, and permissions.

### 2. Understanding the Backup Restoration Failure

SQL Server backup files contain database information associated with the SQL Server version that created them.

When attempting to restore a backup created on a newer SQL Server version to an older SQL Server instance, the restoration process fails.

#### Example environment

| Component          | SQL Server Version |
| ------------------ | ------------------ |
| Source Server      | SQL Server 2019    |
| Destination Server | SQL Server 2016    |
| Source Database    | SampleDatabase     |
| Backup Format      | .BAK               |

SQL Server 2019 uses the major version number 15.x, whereas SQL Server 2016 uses 13.x.

You can verify the SQL Server version by executing:

```
SELECT
    @@VERSION AS SQLServerVersion,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('Edition') AS Edition;
```

**Important:** SQL Server does not support direct backup restoration from a higher major version to a lower major version.

Therefore, an alternative migration approach is required.

### 3. Migration Approach: Generate Scripts

SQL Server Management Studio provides a Generate Scripts wizard that allows administrators to export database objects and data into a SQL script.

This approach can be used to migrate databases between SQL Server versions, provided the database objects and features are compatible with the destination version.

The generated script can include:

* Database tables and structures
* Stored procedures
* Views
* Functions
* Indexes
* Primary keys
* Foreign keys
* Triggers
* Database data
* Database users and permissions, where selected and supported

### 4. Step-by-Step Migration Procedure

#### Step 1: Restore the Original Backup on the Source Version

First, restore the original `.bak` file on an SQL Server 2019 instance.

1. Open SSMS and connect to SQL Server 2019.
2. Right-click Databases.
3. Select Restore Database.
4. Select Device as the backup source.
5. Browse and select the `.bak` file.
6. Specify the database name.
7. Complete the restoration process.

Verify that the database is accessible and its tables and data are available.

#### Step 2: Open the Generate Scripts Wizard

Once the database has been restored:

1. Expand Databases.
2. Right-click the database you want to migrate.
3. Navigate to Tasks → Generate Scripts.
4. Select Script entire database and all database objects.
5. Click Next.

#### Step 3: Configure the Scripting Options

Select Save to file and specify a location where the generated script will be stored.

Open Advanced scripting options and configure:

| Setting                   | Recommended Value                              |
| ------------------------- | ---------------------------------------------- |
| Types of data to script   | Schema and Data                                |
| Script for Server Version | SQL Server 2016                                |
| Script Indexes            | True                                           |
| Script Triggers           | True                                           |
| Script Primary Keys       | True                                           |
| Script Foreign Keys       | True                                           |
| Script Database Create    | True or False, depending on the migration plan |

**Note:** Targeting SQL Server 2016 helps generate compatible syntax where supported. It does not automatically convert every SQL Server 2019 feature into an SQL Server 2016 equivalent.

#### Step 4: Generate the SQL Script

1. Click OK.
2. Review the selected scripting options.
3. Click Next.
4. Click Finish.

SSMS will generate a `.sql` file containing the selected database schema and data.

Depending on database size, the generated script may be very large.

#### Step 5: Prepare the Destination Database

Connect to the destination SQL Server 2016 instance.

Create a new empty database through SSMS or execute:

```
CREATE DATABASE [SampleDatabase];
GO
```

If the generated script already contains a database creation statement, review it and avoid creating the database twice.

#### Step 6: Review Database File Paths

When generating database creation scripts, SSMS may include the original server's MDF and LDF file paths.

For example:

```
FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SampleDatabase.mdf'
```

If the destination SQL Server uses a different instance directory, update the paths accordingly.

For example:

```
FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\SampleDatabase.mdf'
```

Update both the MDF and LDF paths.

Before execution, verify:

* The destination directory exists.
* The SQL Server service account has appropriate file-system permissions.
* The target filenames do not already exist.
* Sufficient disk space is available.

**Important:** SQL Server creates new database files at the specified paths. Do not point the script to existing database files belonging to another database.

#### Step 7: Execute the Generated SQL Script

After preparing the destination database:

1. Connect to SQL Server 2016.
2. Open the generated `.sql` file.
3. Select the destination database in the database dropdown.
4. Review the script for incompatible SQL Server 2019 features.
5. Execute the script.

For large databases, consider executing schema and data separately rather than running one extremely large script.

### 5. Troubleshooting Common Migration Errors

#### Issue 1: SQL Server Login Does Not Exist

Example error:

```
Msg 15007, Level 16, State 1
'SampleLogin' is not a valid login or you do not have permission.
```

Another related error:

```
Msg 15151, Level 16, State 1
Cannot add the principal 'SampleLogin',
because it does not exist or you do not have permission.
```

**Cause:**

The generated script attempts to create a database user mapped to a SQL Server login that does not exist on the destination SQL Server instance.

SQL Server maintains two separate security objects:

* Login: An instance-level security principal.
* Database User: A database-level security principal.

A database user can be mapped to a SQL Server login.

**Step 1: Verify whether the login exists**

Execute this query on the destination SQL Server:

```
SELECT
    name,
    type_desc,
    is_disabled
FROM sys.server_principals
WHERE name = 'SampleLogin';
```

If no records are returned, the login does not exist.

**Step 2: Determine whether the login is required**

If the application uses this login to connect to the database, preserve its access during migration.

Coordinate with the SQL Server administrator to create or provision the corresponding login.

If the login is not required, review the generated script and remove the corresponding user and permission statements only after confirming that they are not needed.

**Step 3: Map the database user**

Once the login exists, map the database user:

```
USE [SampleDatabase];
GO

CREATE USER [SampleLogin]
FOR LOGIN [SampleLogin];
GO
```

If the database user already exists, use `ALTER USER ... WITH LOGIN = ...` instead of creating it again.

**Important:** Do not create unnecessary server-level logins on shared SQL Server environments. Confirm the application's authentication requirements and obtain administrator approval.

#### Issue 2: SQL Server Feature Compatibility

Even when the Generate Scripts wizard targets SQL Server 2016, some database objects may use features introduced in SQL Server 2017 or 2019.

Examples include:

* Newer T-SQL syntax
* Newer built-in functions
* Newer data types or database features
* Features that depend on newer compatibility levels

Review execution errors and modify incompatible objects where necessary.

### 6. Post-Migration Verification

Once the generated script has executed successfully, perform the following checks.

#### Database status

```
SELECT
    name,
    state_desc,
    compatibility_level
FROM sys.databases
WHERE name = 'SampleDatabase';
```

#### Verify table count

```
USE [SampleDatabase];
GO

SELECT COUNT(*) AS TotalTables
FROM sys.tables;
```

#### Verify database size

```
EXEC sp_spaceused;
```

#### Verify database users

```
SELECT
    name,
    type_desc,
    authentication_type_desc
FROM sys.database_principals
WHERE type IN ('S', 'U', 'G');
```

#### Additional verification

Check the following manually:

* Table counts and important record counts
* Stored procedures and functions
* Views
* Indexes
* Primary and foreign keys
* Triggers
* Database users and permissions
* Application connectivity
* SQL Agent jobs and external dependencies
* Application functionality

Also review the database for orphaned users and confirm that the application can authenticate successfully.

### 7. Important Considerations for Shared SQL Server Environments

When performing database migrations on shared hosting servers, additional precautions are necessary.

1. Do not modify global SQL Server configurations without approval.
2. Do not overwrite existing MDF or LDF files.
3. Avoid changing server-level authentication settings.
4. Do not grant unnecessary sysadmin or db\_owner permissions.
5. Preserve existing client database security configurations.
6. Verify database names and file paths before execution.
7. Take a backup of the destination database before replacing any existing data.
8. Test the application after migration.

For large databases, a generated SQL script containing all schema and data may not be the most efficient approach. Consider a controlled data transfer using SSIS, BCP, or another suitable migration process.

### 8. Conclusion

When a database backup created on a newer SQL Server version cannot be restored to an older SQL Server instance, the Generate Scripts approach provides an alternative migration method.

By restoring the original backup on the newer SQL Server, generating scripts targeting the older SQL Server version, and executing those scripts on the destination, administrators can migrate compatible database objects and data without relying on direct backup restoration.

However, database migration is not limited to transferring tables and records. Login mappings, permissions, database features, dependencies, and application connectivity must also be verified.

A successful migration should be considered complete only after the destination database has been validated and the application is functioning correctly.
