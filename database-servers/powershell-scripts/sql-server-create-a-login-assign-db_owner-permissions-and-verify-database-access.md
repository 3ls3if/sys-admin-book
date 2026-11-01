---
icon: user-unlock
---

# SQL Server: Create a Login, Assign DB\_OWNER Permissions, and Verify Database Access

### 1. Overview

In SQL Server environments hosting multiple customer databases, administrators may need to create a single SQL Server login and grant it access to several databases.

This guide explains how to:

1. Create a SQL Server login if it does not already exist.
2. Create a database user mapped to that login in multiple databases.
3. Assign the `db_owner` database role.
4. Verify which databases contain the user and whether the user has `db_owner` permissions.

The process uses two scripts:

* **Script 1 – Login and Permission Assignment:** Creates or maps the login across a predefined list of databases and assigns `db_owner`.
* **Script 2 – Permission Verification:** Searches databases for the login's database user and displays its `db_owner` membership.

> **Important:** The examples use fictional database names and placeholder credentials. Replace them with the appropriate values in your environment before execution.

***

### 2. Prerequisites

Before running the scripts, ensure that:

* You have SQL Server administrative privileges.
* The target SQL Server login does not conflict with an existing account.
* The target databases exist and are online.
* You have permission to create logins, database users, and database role memberships.
* You have reviewed the security implications of assigning `db_owner`.

**Security note:** Members of `db_owner` have extensive control over their respective databases. Grant this role only when the account genuinely requires full database-level permissions.

***

### 3. Script 1 – Create Login and Assign DB\_OWNER Permissions

#### Purpose

This script automates login and database-user provisioning across a predefined list of databases.

It performs the following operations:

* Checks whether the server-level login exists.
* Creates the login if it is missing.
* Checks whether each target database exists and is online.
* Creates the database user if it does not exist.
* Maps an existing database user to the server login.
* Adds the user to the `db_owner` role if it is not already a member.
* Prints a success, failure, or skipped message for each database.

#### Step 1: Create the SQL Server Login

```ps1
USE [master];
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.server_principals
    WHERE name = N'app_service_user'
)
BEGIN
    CREATE LOGIN [app_service_user]
    WITH PASSWORD = N'<STRONG_PASSWORD>',
         CHECK_POLICY = ON,
         CHECK_EXPIRATION = OFF;
END
ELSE
BEGIN
    PRINT 'Login app_service_user already exists.';
END;
GO
```

**Explanation:**

* `sys.server_principals` checks whether the login exists at the SQL Server instance level.
* `CREATE LOGIN` creates the login if it is missing.
* `CHECK_POLICY = ON` enables Windows password policy enforcement.
* `CHECK_EXPIRATION = OFF` disables password expiration for this login.

**Important:** If the login already exists, this script does not change its password. Password changes must be handled separately and deliberately.

#### Step 2: Define the Target Databases

The following example uses fictional database names.

```ps1
DECLARE @Databases TABLE (
    DatabaseName SYSNAME
);

INSERT INTO @Databases (DatabaseName)
VALUES
(N'CustomerDB_A'),
(N'CustomerDB_B'),
(N'CustomerDB_C'),
(N'SchoolManagementDB'),
(N'BillingDatabase'),
(N'ApplicationDB'),
(N'WebsiteDatabase'),
(N'ReportingDB'),
(N'TestEnvironmentDB');
```

Add the actual target database names to this table before executing the provisioning script.

#### Step 3: Create Users and Assign DB\_OWNER

```ps1
DECLARE @DB SYSNAME;
DECLARE @SQL NVARCHAR(MAX);

DECLARE db_cursor CURSOR LOCAL FAST_FORWARD FOR
SELECT DatabaseName
FROM @Databases;

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @DB;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF DB_ID(@DB) IS NOT NULL
       AND DATABASEPROPERTYEX(@DB, 'Status') = 'ONLINE'
    BEGIN
        SET @SQL = N'
        USE ' + QUOTENAME(@DB) + N';

        IF NOT EXISTS (
            SELECT 1
            FROM sys.database_principals
            WHERE name = N''app_service_user''
        )
        BEGIN
            CREATE USER [app_service_user]
            FOR LOGIN [app_service_user];
        END
        ELSE
        BEGIN
            ALTER USER [app_service_user]
            WITH LOGIN = [app_service_user];
        END;

        IF NOT EXISTS (
            SELECT 1
            FROM sys.database_role_members rm
            INNER JOIN sys.database_principals r
                ON rm.role_principal_id = r.principal_id
            INNER JOIN sys.database_principals u
                ON rm.member_principal_id = u.principal_id
            WHERE r.name = N''db_owner''
              AND u.name = N''app_service_user''
        )
        BEGIN
            ALTER ROLE [db_owner]
            ADD MEMBER [app_service_user];
        END;
        ';

        BEGIN TRY
            EXEC sys.sp_executesql @SQL;
            PRINT 'SUCCESS: ' + @DB;
        END TRY
        BEGIN CATCH
            PRINT 'FAILED: ' + @DB + ' - ' + ERROR_MESSAGE();
        END CATCH
    END
    ELSE
    BEGIN
        PRINT 'SKIPPED (Database missing or offline): ' + @DB;
    END;

    FETCH NEXT FROM db_cursor INTO @DB;
END;

CLOSE db_cursor;
DEALLOCATE db_cursor;
GO
```

#### Explanation of Important Commands

| Command                     | Purpose                                                         |
| --------------------------- | --------------------------------------------------------------- |
| `DB_ID()`                   | Checks whether a database exists.                               |
| `DATABASEPROPERTYEX()`      | Checks the database status.                                     |
| `QUOTENAME()`               | Safely delimits the database identifier.                        |
| `CREATE USER`               | Creates a database user mapped to the server login.             |
| `ALTER USER ... WITH LOGIN` | Remaps an existing database user to the specified server login. |
| `ALTER ROLE ... ADD MEMBER` | Adds the database user to the `db_owner` role.                  |
| `TRY...CATCH`               | Captures errors for individual databases.                       |
| `PRINT`                     | Displays the processing result.                                 |

#### Expected Output

The script prints a result for every database in the predefined list.

Example:

```
SUCCESS: CustomerDB_A
SUCCESS: CustomerDB_B
SUCCESS: CustomerDB_C
SKIPPED (Database missing or offline): ReportingDB
FAILED: ApplicationDB - <error message>
```

Interpretation:

* **SUCCESS:** The SQL statements executed without an error for that database.
* **SKIPPED:** The database does not exist or is not online.
* **FAILED:** An error occurred while processing that database.

A `SUCCESS` message indicates that the statements executed successfully; it is still good practice to run the verification script afterward.

***

### 4. Script 2 – Verify Database User and DB\_OWNER Permissions

#### Purpose

After provisioning, administrators should verify that the database user exists and has the expected role membership.

The second script uses `sp_MSforeachdb` to iterate through databases on the SQL Server instance.

It checks:

* Whether the database user exists.
* Which databases contain that user.
* Whether the user is a member of `db_owner`.

#### Verification Script

```ps1
EXEC sp_MSforeachdb '
IF EXISTS (
    SELECT 1
    FROM [?].sys.database_principals
    WHERE name = ''app_service_user''
)
BEGIN
    SELECT
        ''?'' AS DatabaseName,
        dp.name AS DatabaseUser,
        rp.name AS DatabaseRole
    FROM [?].sys.database_principals dp
    INNER JOIN [?].sys.database_role_members drm
        ON dp.principal_id = drm.member_principal_id
    INNER JOIN [?].sys.database_principals rp
        ON drm.role_principal_id = rp.principal_id
    WHERE dp.name = ''app_service_user''
      AND rp.name = ''db_owner'';
END';
```

#### Explanation

| Component                   | Description                                            |
| --------------------------- | ------------------------------------------------------ |
| `sp_MSforeachdb`            | Iterates through databases on the SQL Server instance. |
| `[?]`                       | Placeholder replaced with the current database name.   |
| `sys.database_principals`   | Contains database-level users and roles.               |
| `sys.database_role_members` | Stores database role membership information.           |
| `rp.name = 'db_owner'`      | Filters results to `db_owner` membership.              |

#### Expected Output

Example:

| DatabaseName       | DatabaseUser       | DatabaseRole |
| ------------------ | ------------------ | ------------ |
| CustomerDB\_A      | app\_service\_user | db\_owner    |
| CustomerDB\_B      | app\_service\_user | db\_owner    |
| CustomerDB\_C      | app\_service\_user | db\_owner    |
| SchoolManagementDB | app\_service\_user | db\_owner    |

If a database does not appear in the output, the user may not exist there or may not be a member of `db_owner`.

**Important limitation:** `sp_MSforeachdb` is an undocumented SQL Server system procedure. It is commonly used for administrative tasks, but it should not be treated as a guaranteed, comprehensive database-audit mechanism. For critical audits, use an explicit database iteration script with error handling.

***

### 5. Understanding the Two-Script Workflow

The scripts are designed to be executed in sequence.

```
        SQL Server Instance
                |
                v
    Check Server-Level Login
                |
                v
       Create Login if Missing
                |
                v
     Read Target Database List
                |
                v
       Check Database Status
                |
                v
      Create or Map DB User
                |
                v
       Assign db_owner Role
                |
                v
       Print Processing Result
                |
                v
       Run Verification Script
                |
                v
     Review Database Permissions
```

#### Difference Between Both Scripts

| Feature                   | Script 1           | Script 2           |
| ------------------------- | ------------------ | ------------------ |
| Creates server login      | Yes, if missing    | No                 |
| Creates database users    | Yes, if missing    | No                 |
| Maps users to login       | Yes                | No                 |
| Assigns `db_owner`        | Yes                | No                 |
| Checks database existence | Yes                | No explicit check  |
| Checks role membership    | Yes, before adding | Yes, for reporting |
| Modifies permissions      | Yes                | No                 |
| Main purpose              | Provisioning       | Verification       |

***

### 6. Important Security and Operational Considerations

#### 6.1 Existing Login Password

If `app_service_user` already exists, Script 1 leaves its existing password unchanged.

To change the password separately:

```
ALTER LOGIN [app_service_user]
WITH PASSWORD = N'<NEW_STRONG_PASSWORD>';
```

Use a secure password-management process and do not store credentials directly in shared scripts or documentation.

#### 6.2 DB\_OWNER Is a High-Privilege Role

The `db_owner` role allows extensive database-level control, including modifying database objects, managing permissions, and performing administrative operations.

For application accounts, consider whether a more restricted role or custom permissions would be sufficient.

#### 6.3 Database User Mapping

A SQL Server login exists at the instance level, while a database user exists inside an individual database.

The following command maps an existing database user to the server login:

```
ALTER USER [app_service_user]
WITH LOGIN = [app_service_user];
```

This can resolve an orphaned or mismatched user mapping, but it should be used only after confirming that the existing database principal is intended to represent this login.

#### 6.4 Offline or Missing Databases

The first script skips databases that are missing or offline.

These databases must be checked separately after they become available.

#### 6.5 Verification Scope

The provisioning script processes only the databases listed in `@Databases`.

The verification script searches across databases using `sp_MSforeachdb`, but its undocumented nature means that a more controlled audit is preferable for production compliance.

***

### 7. Recommended Execution Procedure

1. Connect to the correct SQL Server instance using an administrative account.
2. Review the target database list.
3. Confirm that the login name is correct.
4. Execute Script 1.
5. Review all `SUCCESS`, `FAILED`, and `SKIPPED` messages.
6. Execute Script 2.
7. Compare the verification output against the expected database list.
8. Investigate any missing databases or missing `db_owner` memberships.
9. Record the results for change management or audit documentation.

### 8. Conclusion

These two scripts provide a practical method for managing SQL Server login access across multiple databases.

* Script 1 automates login creation, database-user mapping, and `db_owner` role assignment.
* Script 2 verifies which databases contain the user with `db_owner` membership.

Together, they simplify repetitive database permission administration while providing a basic verification process. For production environments, always review the privilege level, validate execution results, and retain an audit record of permission changes.
