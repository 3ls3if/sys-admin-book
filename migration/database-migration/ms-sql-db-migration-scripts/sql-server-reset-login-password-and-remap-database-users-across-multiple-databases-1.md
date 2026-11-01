---
icon: keyboard-brightness
---

# SQL Server: Reset Login Password and Remap Database Users Across Multiple Databases 1

### 1. Overview

This article explains how to identify all SQL Server databases containing a specific database user, reset the associated SQL Server login password, remap existing database users to the server login, and verify the login mappings and permissions.

This procedure is useful when:

* A SQL login password needs to be changed.
* The same SQL user exists across multiple databases.
* Database users need to be remapped to an existing server login.
* Orphaned database users need to be corrected.
* Existing database permissions and role memberships must be preserved.

#### Example scenario

The following generic example is used throughout this article.

| Parameter         | Value                                    |
| ----------------- | ---------------------------------------- |
| SQL Server Login  | App\_SQLUser                             |
| Database User     | App\_SQLUser                             |
| Authentication    | SQL Server Authentication                |
| Example databases | SchoolDB\_01, SchoolDB\_02, SchoolDB\_03 |
| Operation         | Password reset and user remapping        |

**Important:** Never store production passwords directly in scripts, GitHub repositories, or shared documentation. Use a secure secret-management method.

***

### 2. Prerequisites

Before executing the scripts, ensure:

1. Access to SQL Server Management Studio (SSMS).
2. A SQL Server account with sufficient permissions, preferably sysadmin.
3. The target SQL login exists or can be created.
4. All relevant databases are online.
5. A backup of important databases is available.
6. Existing user permissions and role memberships have been documented if a drop-and-recreate operation is being considered.

***

### 3. Step 1 – Identify All Databases Containing the User

First, identify which databases contain the specified database user.

The following script checks all online user databases and returns the database name, username, user type, and default schema.

#### SQL Script

```ps1
USE [master];
GO

DECLARE @Username NVARCHAR(128) = 'App_SQLUser';
DECLARE @SQL NVARCHAR(MAX) = N'';

CREATE TABLE #UserDatabases
(
    DatabaseName SYSNAME,
    UserName SYSNAME,
    UserType NVARCHAR(60),
    DefaultSchema SYSNAME
);

SELECT @SQL = @SQL + '
USE ' + QUOTENAME(name) + ';

INSERT INTO #UserDatabases
SELECT
    DB_NAME(),
    dp.name,
    dp.type_desc,
    dp.default_schema_name
FROM sys.database_principals dp
WHERE dp.name = @Username;
'
FROM sys.databases
WHERE state_desc = 'ONLINE'
AND database_id > 4;

EXEC sys.sp_executesql
    @SQL,
    N'@Username NVARCHAR(128)',
    @Username = @Username;

SELECT *
FROM #UserDatabases
ORDER BY DatabaseName;

DROP TABLE #UserDatabases;
GO
```

#### Explanation

* `sys.databases` retrieves the SQL Server database list.
* `sys.database_principals` identifies database users.
* `QUOTENAME()` safely delimits database names.
* `sp_executesql` executes the dynamic SQL.
* `#UserDatabases` stores the results.

The script excludes system databases and databases that are not online.

#### Expected output

| DatabaseName | UserName     | UserType  | DefaultSchema |
| ------------ | ------------ | --------- | ------------- |
| SchoolDB\_01 | App\_SQLUser | SQL\_USER | dbo           |
| SchoolDB\_02 | App\_SQLUser | SQL\_USER | dbo           |
| SchoolDB\_03 | App\_SQLUser | SQL\_USER | dbo           |

The actual number of databases will depend on the SQL Server environment.

***

### 4. Step 2 – Reset or Create the SQL Server Login

After identifying the databases, update the SQL Server login password.

The following script checks whether the server login exists.

* If it exists, its password is updated.
* If it does not exist, a new SQL login is created.
* The login is enabled.

#### SQL Script

```ps1
USE [master];
GO

IF EXISTS
(
    SELECT 1
    FROM sys.server_principals
    WHERE name = 'App_SQLUser'
)
BEGIN
    ALTER LOGIN [App_SQLUser]
    WITH PASSWORD = '<NEW_STRONG_PASSWORD>',
         CHECK_POLICY = ON;

    ALTER LOGIN [App_SQLUser] ENABLE;

    PRINT 'Existing login password updated successfully.';
END
ELSE
BEGIN
    CREATE LOGIN [App_SQLUser]
    WITH PASSWORD = '<NEW_STRONG_PASSWORD>',
         CHECK_POLICY = ON;

    PRINT 'New SQL Server login created successfully.';
END
GO
```

#### Explanation

`ALTER LOGIN` changes the password of an existing SQL Server login.

`CREATE LOGIN` creates a new SQL Server authentication login if it does not already exist.

`CHECK_POLICY = ON` enables Windows password policy enforcement where supported.

**Note:** Changing a password does not automatically modify database-user permissions.

Replace `<NEW_STRONG_PASSWORD>` with a secure password before execution. The placeholder is not a valid password as written.

***

### 5. Step 3 – Remap the Database User Across All Databases

This is the most important step.

Instead of dropping and recreating the database users, use `ALTER USER ... WITH LOGIN` to associate existing database users with the SQL Server login.

This approach preserves existing database-level permissions and role memberships.

#### SQL Script

```ps1
USE [master];
GO

DECLARE @SQL NVARCHAR(MAX) = N'';

SELECT @SQL = @SQL + '
BEGIN TRY

    USE ' + QUOTENAME(name) + ';

    IF EXISTS
    (
        SELECT 1
        FROM sys.database_principals
        WHERE name = N''App_SQLUser''
          AND type = ''S''
    )
    BEGIN

        ALTER USER [App_SQLUser]
        WITH LOGIN = [App_SQLUser];

        PRINT ''SUCCESS: ' +
        REPLACE(name, '''', '''''') + ''';

    END

END TRY
BEGIN CATCH

    PRINT ''FAILED: ' +
    REPLACE(name, '''', '''''') +
    ' - '' + ERROR_MESSAGE();

END CATCH;
'
FROM sys.databases
WHERE state_desc = 'ONLINE'
AND database_id > 4;

EXEC sys.sp_executesql @SQL;
GO
```

#### Explanation

The script performs the following operations:

1. Retrieves all online user databases.
2. Checks whether `App_SQLUser` exists in each database.
3. Executes `ALTER USER` for matching users.
4. Maps the database user to the server login.
5. Displays a SUCCESS or FAILED message for each database.

#### Why use ALTER USER instead of DROP USER?

Dropping and recreating a database user can remove its existing permissions and role memberships.

Using `ALTER USER ... WITH LOGIN` preserves the existing database principal and its associated database permissions.

This is particularly important when the same database user has different permissions in multiple databases.

***

### 6. Step 4 – Verify Database User and Login Mapping

After remapping all database users, verify that the database-user SID matches the SQL Server login SID.

A matching SID confirms that the database user is mapped to the intended server login.

#### SQL Script

```ps1
USE [master];
GO

CREATE TABLE #Verification
(
    DatabaseName SYSNAME,
    UserName SYSNAME,
    LoginName SYSNAME,
    DefaultSchema SYSNAME,
    MappingStatus VARCHAR(30)
);

DECLARE @SQL NVARCHAR(MAX) = N'';

SELECT @SQL = @SQL + '
USE ' + QUOTENAME(name) + ';

INSERT INTO #Verification
SELECT
    DB_NAME(),
    dp.name,
    sp.name,
    dp.default_schema_name,
    CASE
        WHEN dp.sid = sp.sid THEN ''MAPPED''
        ELSE ''NOT MAPPED''
    END
FROM sys.database_principals dp
LEFT JOIN master.sys.server_principals sp
    ON sp.name = dp.name
WHERE dp.name = N''App_SQLUser''
AND dp.type = ''S'';
'
FROM sys.databases
WHERE state_desc = 'ONLINE'
AND database_id > 4;

EXEC sys.sp_executesql @SQL;

SELECT *
FROM #Verification
ORDER BY DatabaseName;

DROP TABLE #Verification;
GO
```

#### Expected output

| DatabaseName | UserName     | LoginName    | DefaultSchema | MappingStatus |
| ------------ | ------------ | ------------ | ------------- | ------------- |
| SchoolDB\_01 | App\_SQLUser | App\_SQLUser | dbo           | MAPPED        |
| SchoolDB\_02 | App\_SQLUser | App\_SQLUser | dbo           | MAPPED        |
| SchoolDB\_03 | App\_SQLUser | App\_SQLUser | dbo           | MAPPED        |

**Expected result:** All identified databases should show `MAPPED`.

***

### 7. Step 5 – Verify Database Permissions and Role Memberships

A successful SID mapping does not independently prove that every database permission is working.

The following query can be executed inside each database to inspect role memberships.

#### Check Database Role Memberships

```ps1
SELECT
    DP1.name AS DatabaseUser,
    DP2.name AS DatabaseRole
FROM sys.database_role_members DRM
INNER JOIN sys.database_principals DP1
    ON DRM.member_principal_id = DP1.principal_id
INNER JOIN sys.database_principals DP2
    ON DRM.role_principal_id = DP2.principal_id
WHERE DP1.name = 'App_SQLUser'
ORDER BY DP2.name;
```

#### Check Explicit Database Permissions

```ps1
SELECT
    USER_NAME(grantee_principal_id) AS UserName,
    permission_name,
    state_desc,
    class_desc
FROM sys.database_permissions
WHERE grantee_principal_id =
    DATABASE_PRINCIPAL_ID('App_SQLUser')
ORDER BY permission_name;
```

These queries help confirm that existing database role memberships and explicit permissions are retained.

For a complete permission audit, also inspect schema-level and object-level permissions, ownership, and inherited permissions.

***

### 8. Execution Results and Validation

After executing the scripts, review the output from each stage.

#### Execution summary

| Operation                    | Expected result                |
| ---------------------------- | ------------------------------ |
| Database discovery           | Completed                      |
| Database identification      | All matching databases listed  |
| SQL login password reset     | Successful                     |
| Database-user remapping      | SUCCESS messages               |
| Failed remapping messages    | 0                              |
| SID verification             | All matching users show MAPPED |
| Role membership verification | Existing memberships retained  |
| Permission verification      | Existing permissions retained  |

The remapping script reports individual database execution results.

The final SID verification and permission checks should be completed before declaring the operation fully successful.

***

### 9. Important Notes and Best Practices

1. Never drop an existing database user unless you have documented and recreated all its permissions, role memberships, ownership, and other dependencies.
2. Prefer `ALTER USER ... WITH LOGIN` for remapping existing SQL database users.
3. Take database backups before making production-level security changes.
4. Use strong passwords and avoid storing passwords directly in scripts.
5. Ensure the login is enabled and has the required server-level permissions.
6. Check whether any database is offline, restoring, or inaccessible before concluding that all databases have been processed.
7. SID mapping alone does not validate application connectivity or effective access.
8. Update application connection strings or stored credentials after a password reset.
9. Test the login against representative databases before declaring the change complete.
10. Review server-level permissions separately because database-user remapping does not automatically preserve or grant server-level permissions.

***

### 10. Conclusion

Using dynamic SQL and the `ALTER USER ... WITH LOGIN` command, SQL Server administrators can efficiently remap a single SQL login across multiple databases without unnecessarily dropping and recreating database users.

This method is particularly useful in hosting environments where a single SQL Server login is associated with multiple application or customer databases and maintaining existing database permissions is essential.

The recommended workflow is:

**Discover databases → Reset login password → Remap database users → Verify SID mappings → Audit permissions → Test application connectivity.**

Following this process helps maintain database access continuity while reducing the risk of accidentally removing existing permissions.
