---
icon: postgresql
---

# Migrating a PostgreSQL Database Between Windows Servers (Including Users & Permissions)

### Migrating a PostgreSQL Database Between Windows Servers (Including Users & Permissions)

Moving a PostgreSQL database from one Windows server to another isn’t complicated—but it _does_ require attention to detail, especially when you need to preserve **user roles, permissions, and ownership**. A clean migration ensures your applications continue working without authentication failures or permission issues.

This guide walks through a reliable, production-friendly approach.

***

### 🧭 Why Migration Needs Care

A PostgreSQL database isn’t just data. It includes:

* Schemas and tables
* Stored procedures and extensions
* Users (roles) and permissions

A common mistake is migrating only the database and forgetting roles—leading to login failures and broken apps.

***

### 🔍 Step 1: Verify PostgreSQL Versions

Before doing anything, confirm compatibility between source and destination servers.

```
psql --version
```

Best practice:

* Same version → ideal
* Newer version on target → acceptable
* Older version on target → **not recommended**

***

### 👥 Step 2: Export Roles (Users & Permissions)

PostgreSQL manages users as **roles**, and they are **not included** in standard database dumps.

Export roles using:

```
pg_dumpall -U postgres --roles-only > roles.sql
```

This captures:

* User accounts
* Password hashes
* Role memberships
* Privileges

***

### 🗄️ Step 3: Backup the Database

#### Option A: Single Database (Recommended)

```
pg_dump -U postgres -F c -d your_db_name -f your_db.dump
```

* `-F c` = custom format
* Supports selective and parallel restore

***

#### Option B: All Databases

```
pg_dumpall -U postgres > fulldb.sql
```

This creates a full logical backup of the entire cluster.

***

### 📦 Step 4: Transfer Backup Files

Move the following to the new server:

* `roles.sql`
* `your_db.dump` or `fulldb.sql`

Transfer methods:

* Shared network drive
* SCP / SFTP
* External storage (USB)

***

### 🔄 Step 5: Restore Roles First

On the destination server:

```
psql -U postgres -f roles.sql
```

You may see warnings like:

```
ERROR: role "postgres" already exists
```

This is normal—the default role already exists. PostgreSQL will still apply updates (like passwords).

***

### 🛠️ Step 6: Restore the Database

#### If using custom dump:

```
createdb -U postgres your_db_name
pg_restore -U postgres -d your_db_name your_db.dump
```

***

#### If using full SQL dump:

```
psql -U postgres -f fulldb.sql
```

***

### 🔐 Step 7: Fix Ownership (If Needed)

After restore, ownership mismatches can occur.

```
ALTER DATABASE your_db_name OWNER TO postgres;
```

Or reassign objects:

```
REASSIGN OWNED BY old_user TO new_user;
```

***

### ⚙️ Step 8: Verify Configuration

#### `postgresql.conf`

Ensure PostgreSQL accepts connections:

```
listen_addresses = '*'
```

***

#### `pg_hba.conf`

Allow authentication:

```
host all all 0.0.0.0/0 md5
```

***

#### Restart PostgreSQL (Windows)

```
net stop postgresql
net start postgresql
```

***

### ⚠️ Common Pitfalls

Avoid these frequent issues:

* ❌ Roles not migrated → login failures
* ❌ Version mismatch → restore errors
* ❌ Missing extensions → application crashes
* ❌ Incorrect encoding → data corruption
* ❌ Ownership mismatch → permission errors

Check installed extensions:

```
\dx
```

***

### 🚀 Performance Tip for Large Databases

For big datasets, use **parallel restore**:

```
pg_dump -F d -j 4 -f dumpdir your_db_name
pg_restore -j 4 -d your_db_name dumpdir
```

This significantly reduces downtime.

***

### 🧠 Final Thoughts

A successful PostgreSQL migration comes down to **sequence and completeness**:

1. Export roles
2. Dump database
3. Transfer files
4. Restore roles first
5. Restore database
6. Fix ownership and configuration

Done correctly, your application should reconnect seamlessly with no data loss or permission issues.
