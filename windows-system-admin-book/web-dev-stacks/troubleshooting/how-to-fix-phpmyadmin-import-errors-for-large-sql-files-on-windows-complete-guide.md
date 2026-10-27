---
icon: php
---

# How to Fix phpMyAdmin Import Errors for Large SQL Files on Windows (Complete Guide)

## How to Fix phpMyAdmin Import Errors for Large SQL Files on Windows (Complete Guide)

Importing large `.sql` files (100MB–200MB or more) into your database can often lead to frustrating errors such as:

* **“Maximum execution time exceeded”**
* **“MySQL server has gone away”**
* SQL syntax errors like `SET FOREIGN_KEY_CHECKS = ON`

This guide will walk you through the **correct fixes and the most reliable method** to successfully import large databases using **MySQL** and **phpMyAdmin** on a Windows server.

***

## The Best Solution: Use Command Line (Recommended)

phpMyAdmin is convenient, but it is **not designed for large imports**. The most reliable method is using the MySQL command line.

#### Steps (Windows / XAMPP)

1. Open **Command Prompt**
2.  Navigate to MySQL `bin` directory:

    ```
    cd C:\xampp\mysql\bin
    ```
3.  Run the import command:

    ```
    mysql -u root -p your_database < C:\path\to\file.sql
    ```
4. Enter your password when prompted

#### ✔ Benefits:

* No timeout limits
* No file size restrictions
* Faster and more stable

***

## Fixing phpMyAdmin (If You Must Use It)

If you still prefer phpMyAdmin, you need to increase multiple limits.

***

### 1. Increase PHP Limits

Edit:

```
C:\xampp\php\php.ini
```

Update:

```
upload_max_filesize = 200M
post_max_size = 200M
max_execution_time = 600
max_input_time = 600
memory_limit = 512M
```

👉 You can also set:

```
max_execution_time = 0
max_input_time = 0
```

for unlimited execution.

***

### 2. Increase MySQL Limits

Edit:

```
C:\xampp\mysql\bin\my.ini
```

Add or update:

```
max_allowed_packet = 256M
wait_timeout = 600
interactive_timeout = 600
```

***

### 3. Restart Services

Restart MySQL and Apache:

```
net stop MySQL80
net start MySQL80
```

Or use:

* `services.msc` → restart MySQL & Apache

***

## Fix SQL Syntax Errors

A common issue during import is incorrect syntax like:

```
SET FOREIGN_KEY_CHECKS = ON;
```

❌ This is invalid in MySQL.

#### Correct syntax:

```
SET FOREIGN_KEY_CHECKS = 0;
-- import data
SET FOREIGN_KEY_CHECKS = 1;
```

***

### How to Check Your `.sql` File

#### Method 1: Manual Search

* Open file in Notepad or Notepad++
* Press `Ctrl + F`
*   Search:

    ```
    FOREIGN_KEY_CHECKS
    ```

***

#### Method 2: Replace Automatically

Press `Ctrl + H` and replace:

```
Find:    SET FOREIGN_KEY_CHECKS = ON;
Replace: SET FOREIGN_KEY_CHECKS = 1;
```

(Optional):

```
Find:    SET FOREIGN_KEY_CHECKS = OFF;
Replace: SET FOREIGN_KEY_CHECKS = 0;
```

***

## ❌ Common Errors Explained

### 1. Maximum Execution Time Exceeded

* PHP timeout reached while parsing file
* Happens in phpMyAdmin for large imports

### 2. MySQL Server Has Gone Away

* File too large
* `max_allowed_packet` too small
* Connection timeout

### 3. Lexer.php Error

* phpMyAdmin parser fails on large SQL files

***

## Alternative Solution: BigDump

If you must use a browser-based method:

* Use **BigDump**
* Imports SQL files in chunks
* Avoids timeout issues

***

## Why These Errors Happen

* PHP has upload and execution limits
* MySQL limits packet size and timeouts
* Browsers cannot handle long-running requests
* phpMyAdmin parses entire SQL in memory

***

## Final Checklist

✔ Replace `ON` → `1` in SQL\
✔ Increase PHP limits\
✔ Increase MySQL `max_allowed_packet`\
✔ Restart services\
✔ Prefer command line import

***

## Final Recommendation

For large database imports on Windows:

👉 **Always use command line instead of phpMyAdmin**

```
mysql -u root -p db_name < file.sql
```

It will save you time, avoid errors, and ensure a smooth import process.
