---
icon: dolphin
---

# How to Fix MySQL “Table mysql.db is Marked as Crashed” Error in XAMPP (Complete Guide)

### How to Fix MySQL “Table mysql.db is Marked as Crashed” Error in XAMPP (Complete Guide)

Database corruption can suddenly bring your local or production websites offline. One of the most common errors in XAMPP environments is:

```
Table '.\mysql\db' is marked as crashed and should be repaired
Index for table '.\mysql\db' is corrupt
Fatal error: Can't open and lock privilege tables
System error 1067 – The process terminated unexpectedly
```

This article explains **why this happens** and provides a **step-by-step solution** to restore your websites quickly and safely.

***

## Why This Error Happens

This issue typically occurs when:

* MySQL shuts down improperly
* The system experiences a power failure
* XAMPP is force-closed
* Disk corruption occurs
* The MySQL privilege tables become corrupted

In XAMPP installations, the corruption usually affects the **`mysql` system database**, which stores user accounts and permissions. When this database is damaged, MySQL cannot start — and all websites show “Connection Failed”.

***

## Step-by-Step Fix for XAMPP (Windows)

This method works in most cases without losing your website databases.

***

### Step 1: Stop MySQL Completely

* Close XAMPP Control Panel
* Open Task Manager
* End any `mysqld.exe` process

Make sure MySQL is fully stopped before continuing.

***

### Step 2: Locate the MySQL Folder

Go to:

```
C:\xampp\mysql\
```

You will see:

* `backup`
* `bin`
* `data`

***

### Step 3: Rename the Corrupted Data Folder

Rename:

```
data → data_old
```

Do NOT delete it — it contains your databases.

***

### Step 4: Restore Clean System Tables

Copy the `backup` folder and rename the copy to:

```
data
```

You should now have:

```
data        (fresh system files)
data_old    (your old databases)
```

The `backup` folder contains clean system tables required for MySQL to start.

***

### Step 5: Restore Your Databases

Open `data_old` and copy **only your project databases**.

⚠️ Do NOT copy these system folders:

* `mysql`
* `performance_schema`
* `phpmyadmin`
* `sys`

Paste your own database folders into the new `data` folder.

{% hint style="info" icon="lightbulb" %}
Do not forget to copy the ibdata1 file from your old data folder to the new one.
{% endhint %}

***

### Step 6: Start MySQL

Open XAMPP Control Panel and start MySQL.

In most cases, it will now run successfully.

***

## Step 7: Reset the Root Password

After restoration, the root password may be reset.

Open:

```
C:\xampp\mysql\bin
```

Run:

```
mysql -u root
```

Then set a new password:

```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewPassword';
FLUSH PRIVILEGES;
```

***

### Important: Update Website Configuration

If websites still show “Connection Failed”, update the database credentials in your project files:

Example:

```
DB_HOST = localhost
DB_USER = root
DB_PASSWORD = NewPassword
DB_NAME = your_database_name
```

Also update:

```
C:\xampp\phpMyAdmin\config.inc.php
```

Set the new root password there.

***

## If It Still Doesn’t Work

Check for:

* Missing `ibdata1` file
* Permission issues
* Incorrect database name
* Access denied errors
* Incorrect `localhost` configuration

Review the MySQL error log located in:

```
C:\xampp\mysql\data\mysql_error.log
```

***

## Preventing This Issue in the Future

To avoid future corruption:

* Always stop MySQL from XAMPP before shutting down
* Avoid force-closing XAMPP
* Use a UPS if power outages are common
* Regularly back up your databases
* Monitor disk health

***

## Conclusion

The “mysql.db is marked as crashed” error can look serious, but in XAMPP environments it is usually recoverable without data loss. By restoring clean system tables and preserving your database folders, you can bring your websites back online quickly and safely.

Proper shutdown practices and regular backups will significantly reduce the risk of encountering this issue again.
