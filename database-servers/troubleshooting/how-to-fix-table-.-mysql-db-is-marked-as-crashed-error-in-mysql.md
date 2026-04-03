---
icon: dolphin
---

# How to Fix “Table '.\mysql\db' is Marked as Crashed” Error in MySQL

If you’ve ever encountered the dreaded MySQL error:

> _“Table '.\mysql\db' is marked as crashed… Can't open and lock privilege tables”_

you’re not alone. This issue can completely prevent your MySQL server from starting, making it impossible to access databases or applications that depend on it. In this guide, we’ll break down what causes this error and walk you through a reliable step-by-step fix.

***

### What Does This Error Mean?

This error occurs when the internal **`mysql.db` table** becomes corrupted. This table is critical because it stores user permissions and access privileges.

When MySQL tries to start:

* It attempts to read privilege tables
* Fails due to corruption
* Refuses to start for security reasons

***

### Common Causes

There are several reasons why the `mysql.db` table might get corrupted:

* Sudden system shutdown or crash
* Improper MySQL service termination
* Disk issues or file system corruption
* Hardware failures
* Interrupted write operations

***

### Recommended Solution: Repair via Command Line

Since MySQL cannot load privilege tables, you must temporarily bypass them to perform repairs.

#### Step 1: Stop MySQL Service

Before starting, ensure MySQL is not running.

*   On Windows:

    ```
    net stop mysql
    ```
*   On Linux:

    ```
    sudo systemctl stop mysql
    ```

***

#### Step 2: Start MySQL in Safe Mode

Run MySQL without loading privilege tables:

```
mysqld --console --skip-grant-tables --skip-external-locking
```

⚠️ Keep this terminal window open — MySQL is now running in safe mode.

***

#### Step 3: Repair the Corrupted Table

Open a **second terminal window** and execute:

```
mysqlcheck -r --databases mysql --use-frm -u root
```

If the above command fails, try repairing only the affected table:

```
mysqlcheck -r mysql db -u root
```

***

#### Step 4: Restart MySQL Normally

Once repair is complete:

1. Close the safe mode terminal
2. Restart MySQL normally:

*   Windows:

    ```
    net start mysql
    ```
*   Linux:

    ```
    sudo systemctl start mysql
    ```

***

### Verify the Fix

After restarting:

* Try logging in to MySQL
* Check if databases are accessible
* Ensure no further errors appear in logs

***

### Prevent Future Corruption

To avoid similar issues in the future:

* Always shut down MySQL properly
* Use a reliable power backup (UPS)
* Regularly back up your databases
* Monitor disk health
* Enable binary logging for recovery options

***

### Final Thoughts

While this error can feel catastrophic, it’s usually recoverable with the right steps. Running MySQL in safe mode and repairing the corrupted tables often restores full functionality without data loss.

However, if repairs fail, restoring from backup may be your safest option.

***
