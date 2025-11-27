---
icon: triangle-exclamation
---

# Fixing a SUSPECT Database in SQL Server and Restoring User Permissions: Complete Troubleshooting Gui

## **Fixing a SUSPECT Database in SQL Server and Restoring User Permissions: Complete Troubleshooting Guide**

<figure><img src="../../.gitbook/assets/image (120).png" alt=""><figcaption></figcaption></figure>

SQL Server databases may enter a **SUSPECT** state when SQL Server cannot complete the recovery process. This usually happens due to corruption, unexpected shutdowns, insufficient disk space, hardware failures, or missing database files. When this happens, the database becomes inaccessible, users cannot connect, and administrative actions such as ALTER DATABASE fail—especially if the logged-in user does not have sysadmin privileges.

This article explains:

* What causes a SQL database to go **SUSPECT**
* How to regain sysadmin permissions if you’ve lost access
* How to bring the SUSPECT database back online safely
* How to fix the SINGLE\_USER mode lock
* How to create users/logins and grant appropriate permissions
* Full SQL scripts for every step

***

## **1. Understanding the Problem**

When trying to repair or access the database, the following messages may appear:

```
Database 'ExactllyERP' cannot be opened. It has been marked SUSPECT by recovery.
User does not have permission to alter database 'ExactllyERP'
ALTER DATABASE statement failed.
```

These errors tell us two things:

#### **A. The database is in SUSPECT mode**

This means SQL Server failed to start recovery for the database. The cause may be corruption or interrupted transactions.

#### **B. The user lacks sufficient permissions**

To repair or change a SUSPECT database, the user **must be a sysadmin**. Without sysadmin privileges, SQL Server blocks repair operations.

***

## **2. Step-by-Step Solution Guide**

Below is the complete resolution workflow.

***

## **Step 1 — Verify Your Permissions**

Run:

```sql
SELECT IS_SRVROLEMEMBER('sysadmin');
```

* **1 = You are sysadmin**
* **0 = You are NOT sysadmin**

If you are _not_ sysadmin, you must regain admin access.

***

## **Step 2 — Regain Sysadmin Access (If Lost)**

If you cannot run ALTER DATABASE, you must log in with a privileged account.

#### **Option A: Log in Using Windows Authentication**

1. Log in to the Windows server (RDP).
2. Open SSMS.
3. Select **Windows Authentication**.

If your Windows account is a local administrator, SQL automatically assigns sysadmin privileges.

***

#### **Option B: Force SQL into Single-User Mode to Restore Sysadmin**

If no admin login works:

1.  Stop SQL Server:

    ```
    services.msc → SQL Server (MSSQLSERVER) → Stop
    ```
2.  Start it in single-user mode:

    ```cmd
    net start MSSQLSERVER /m"SQLCMD"
    ```
3.  Connect via SQLCMD:

    ```cmd
    sqlcmd -S .\MSSQLSERVER
    ```
4.  Add yourself as sysadmin:

    ```sql
    CREATE LOGIN [YourDomain\YourUser] FROM WINDOWS;
    ALTER SERVER ROLE sysadmin ADD MEMBER [YourDomain\YourUser];
    GO
    ```
5.  Restart SQL normally:

    ```cmd
    net stop MSSQLSERVER
    net start MSSQLSERVER
    ```

Now you have sysadmin permissions again.

***

## **Step 3 — Check the Database State**

Run:

```sql
SELECT name, state_desc 
FROM sys.databases
WHERE name = 'ExactllyERP';
```

State will likely show as:

* **SUSPECT**
* **RECOVERY\_PENDING**
* **OFFLINE**

Proceed with repair.

***

## **Step 4 — Repair a SUSPECT Database**

As sysadmin, run:

```sql
ALTER DATABASE [ExactllyERP] SET EMERGENCY;
GO
ALTER DATABASE [ExactllyERP] SET SINGLE_USER;
GO
DBCC CHECKDB ('ExactllyERP', REPAIR_ALLOW_DATA_LOSS);
GO
ALTER DATABASE [ExactllyERP] SET MULTI_USER;
GO
```

This sequence:

* Forces emergency access
* Allows exclusive repair
* Repairs corruption
* Returns database to normal mode

***

## **Step 5 — Fix “Database is already open and can only have one user”**

Sometimes the database gets stuck in **SINGLE\_USER** mode:

```
Database 'ExactllyERP' is already open and can only have one user at a time.
```

This means another session is connected.

#### **1. Identify the blocking session**

```sql
SELECT 
    db_name(dbid) AS DBName, 
    spid, 
    loginame, 
    hostname 
FROM master.dbo.sysprocesses
WHERE dbid = DB_ID('ExactllyERP');
```

#### **2. Kill the session**

```sql
KILL <SPID>;
```

#### **3. Force multi-user mode**

```sql
ALTER DATABASE [ExactllyERP] 
SET MULTI_USER WITH ROLLBACK IMMEDIATE;
GO
```

***

## **Step 6 — Create Login and Database User (If Missing)**

If SQL raises the error:

```
Cannot add the principal 'Exactlly', because it does not exist
```

You must first check whether the login exists.

#### **Check if LOGIN exists**

```sql
SELECT name FROM sys.server_principals WHERE name = 'Exactlly';
```

If missing:

```sql
CREATE LOGIN [Exactlly] WITH PASSWORD = 'StrongPassword@123';
GO
```

***

#### **Check if USER exists in the database**

```sql
USE [ExactllyERP];
SELECT name FROM sys.database_principals WHERE name = 'Exactlly';
```

If missing:

```sql
USE [ExactllyERP];
CREATE USER [Exactlly] FOR LOGIN [Exactlly];
GO
```

***

## **Step 7 — Grant Permissions to the User**

Most ERP applications require db\_owner.

```sql
USE [ExactllyERP];
ALTER ROLE [db_owner] ADD MEMBER [Exactlly];
GO
```

If you want least-privilege access instead, permissions can be customized (SELECT, INSERT, EXECUTE, etc.).

***

## **Conclusion**

This complete troubleshooting process covers:

* Identifying a SUSPECT database
* Regaining sysadmin access when locked out
* Repairing the corrupted database
* Fixing SINGLE\_USER mode errors
* Creating missing logins and database users
* Assigning necessary permissions

Following these steps ensures that the database is fully restored and accessible, and the necessary user accounts are properly configured with the correct privileges.
