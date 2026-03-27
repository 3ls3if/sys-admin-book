---
icon: microsoft
---

# Fixing the "Login failed for user 'IIS APPPOOL'" Error in SQL Server with IIS and ASP.NET Core

## Fixing the "Login failed for user 'IIS APPPOOL'" Error in SQL Server with IIS and ASP.NET Core

When deploying an ASP.NET Core application to IIS, many developers run into this frustrating error:

`Login failed for user 'IIS APPPOOL\<AppPoolName>'.Reason: Failed to open the explicitly specified database 'YourDatabaseName'. [CLIENT: <local machine>]`

This error has two parts:

1. **Login failed for user 'IIS APPPOOL...':**\
   SQL Server is trying to log in using the Windows identity of your IIS Application Pool.
2. **Failed to open the explicitly specified database:**\
   Even if login worked, SQL Server cannot open the database. This usually means the database doesn’t exist, is offline, or the user doesn’t have permissions.

***

### Why This Happens

The problem almost always traces back to the connection string. If your connection string contains:

`"ODWContextConnection": "Server=SERVER\\SQLEXPRESS;Database=TestDB;Trusted_Connection=True;MultipleActiveResultSets=true"`

The `Trusted_Connection=True` (or `Integrated Security=True`) tells SQL Server to use **Windows Authentication**. Instead of using a SQL username and password, it tries to connect with the identity of the IIS Application Pool (for example, `IIS APPPOOL\test.com`).

If SQL Server doesn’t recognize this account, or if the database name is invalid/offline, you get the error.

***

### Steps to Fix

#### 1. Verify the Database Exists

Run this in SQL Server Management Studio (SSMS):

`SELECT name, state_descFROM sys.databasesWHERE name = 'TestDB';`

* If no rows return → the database name is wrong or doesn’t exist. Double-check the spelling.
*   If it shows `OFFLINE` or `RESTORING` → bring it online with:

    `ALTER DATABASE TestDB SET ONLINE;`

***

#### 2. Adjust the Connection String

**Option A – Use SQL Authentication (Recommended for hosted apps)**

Instead of relying on the IIS App Pool identity, create a SQL Login:

`CREATE LOGIN ODWUser WITH PASSWORD = 'StrongPasswordHere!';USE TestDB;CREATE USER ODWUser FOR LOGIN ODWUser;EXEC sp_addrolemember 'db_owner', 'ODWUser';`

Then, update your `appsettings.json`:

`"ODWContextConnection": "Server=SERVER\\SQLEXPRESS;Database=TestDB;User Id=ODWUser;Password=StrongPasswordHere!;TrustServerCertificate=True;MultipleActiveResultSets=True;"`

This is the simplest and most reliable approach.

***

**Option B – Stick With Windows Authentication**

If you want to keep using `Trusted_Connection=True`, you must grant the IIS App Pool identity access to the database:

`CREATE LOGIN [IIS APPPOOL\Test.com] FROM WINDOWS;USE [TestDB];CREATE USER [IIS APPPOOL\Test.com] FOR LOGIN [IIS APPPOOL\test.com];ALTER ROLE db_owner ADD MEMBER [IIS APPPOOL\test.com];`

This explicitly tells SQL Server to trust the IIS Application Pool account and grant it permissions.

***

### Recommended Path

* First, confirm the database exists and is online.
* If you control the SQL Server and can manage logins easily, **use SQL Authentication**. It avoids many headaches with permissions.
* If you must use Windows Authentication, explicitly grant the IIS App Pool account access as shown above.

***

### Final Thoughts

This error may look intimidating, but it boils down to two things: **the database must exist** and **the connecting identity must have permission**. By fixing the connection string and ensuring the right login exists, you’ll resolve the dreaded:

Login failed for user 'IIS APPPOOL\\...'.

and get your ASP.NET Core app talking to SQL Server correctly.
