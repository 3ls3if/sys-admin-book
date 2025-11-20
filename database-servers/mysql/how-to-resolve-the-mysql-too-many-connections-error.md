---
icon: triangle-exclamation
---

# How to Resolve the “MySQL – Too Many Connections” Error

This error occurs when the number of active MySQL connections reaches the maximum limit defined in the MySQL configuration.

#### **1. Check the Current Connection Limit**

Run the following SQL command:

```sql
SHOW VARIABLES LIKE 'max_connections';
```

#### **2. Check Current Active Connections**

```sql
SHOW STATUS LIKE 'Threads_connected';
```

***

### **3. Increase the MySQL Connection Limit**

#### **Option A: Temporary Increase (Immediate Effect, but Resets After Restart)**

```sql
SET GLOBAL max_connections = 500;
```

(You can set any number as needed.)

***

#### **Option B: Permanent Increase (Recommended)**

Edit the MySQL configuration file:

* **Linux:** `/etc/my.cnf` or `/etc/mysql/my.cnf`
* **Windows:** `my.ini`

Add or update:

```
[mysqld]
max_connections = 500
```

Then restart MySQL:

*   **Linux:**

    ```bash
    sudo systemctl restart mysql
    ```
* **Windows:** Restart MySQL service from Services.

***

### **4. Identify Scripts That Keep Connections Open**

Sometimes the real issue is:

* Unoptimized PHP scripts
* Long-running queries
* Missing `mysqli_close()`
* Too many concurrent requests

Check the process list:

```sql
SHOW FULL PROCESSLIST;
```
