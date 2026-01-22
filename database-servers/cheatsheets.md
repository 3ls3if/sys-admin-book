---
icon: sheet-plastic
---

# CheatSheets

## SQL Server Login & User Management – Cheatsheet

### 1️⃣ Create Login (Server Level)

Creates a SQL Server **login** (server-wide authentication).

```sql
CREATE LOGIN [demomvc]
WITH PASSWORD = 'Demomvc@123',
CHECK_POLICY = OFF;
```

✔ Use when the login does **not exist**\
✔ `CHECK_POLICY = OFF` disables password complexity rules

***

### 2️⃣ Drop Login

Removes a login from the SQL Server instance.

```sql
DROP LOGIN [demomvc];
```

⚠ Fails if:

* Login owns a database
* Login has active sessions
* Login is mapped to a database user

***

### 3️⃣ Check If Login Exists

```sql
SELECT *
FROM sys.server_principals
WHERE name = 'demomvc';
```

***

### 4️⃣ Kill Active Sessions for a Login

Find active sessions:

```sql
SELECT session_id, login_name
FROM sys.dm_exec_sessions
WHERE login_name = 'demomvc';
```

Kill a session:

```sql
KILL 52;
```

✔ Required before dropping a login

***

### 5️⃣ Create Database User (Mapped to Login)

Run inside the target database.

```sql
USE [admin_old_core_datanew];
GO

CREATE USER [demomvc] FOR LOGIN [demomvc];
```

✔ Links the **login** to a **database user**

***

### 6️⃣ Drop Database User

```sql
DROP USER IF EXISTS [demomvc];
```

⚠ Will fail if:

* User owns schemas
* User owns objects

***

### 7️⃣ Check Schema Ownership by User

Before dropping a user, verify schema ownership:

```sql
SELECT name AS schema_name, principal_id
FROM sys.schemas
WHERE principal_id = USER_ID('demomvc');
```

✔ If rows exist → user owns schema(s)

***

### 8️⃣ Grant Database Access

```sql
GRANT CONNECT TO [demomvc];
```

✔ Allows login to connect to the database

***

### 9️⃣ Add User to Database Role

Make user database owner:

```sql
EXEC sp_addrolemember 'db_owner', 'demomvc';
```

📌 Modern alternative:

```sql
ALTER ROLE db_owner ADD MEMBER demomvc;
```

***

### 🔟 Full Clean Reset Pattern (Login + User)

```sql
-- Kill sessions
SELECT session_id FROM sys.dm_exec_sessions WHERE login_name = 'demomvc';

KILL <session_id>;

-- Drop user
USE [admin_old_core_datanew];
DROP USER IF EXISTS [demomvc];

-- Drop login
DROP LOGIN [demomvc];

-- Recreate login
CREATE LOGIN [demomvc]
WITH PASSWORD = 'Demomvc@123', CHECK_POLICY = OFF;

-- Recreate user
USE [admin_old_core_datanew];
CREATE USER [demomvc] FOR LOGIN [demomvc];

-- Assign role
ALTER ROLE db_owner ADD MEMBER demomvc;
```

***

### 1️⃣1️⃣ Working with Another Login (`demo`)

Same pattern, different names:

```sql
CREATE LOGIN [demo] WITH PASSWORD = 'Demo@123', CHECK_POLICY = OFF;

USE [demodata];
CREATE USER [demo] FOR LOGIN [demo];

ALTER ROLE db_owner ADD MEMBER demo;
```

***

### 🧠 Quick Mental Model

| Level    | Object | Purpose        |
| -------- | ------ | -------------- |
| Server   | LOGIN  | Authentication |
| Database | USER   | Authorization  |
| Database | ROLE   | Permissions    |
