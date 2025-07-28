---
icon: user
---

# Create User and Import Database

## Create Database and User

### Using MySQL Command Line

#### Step-by-step:



1. **Login to MySQL as root or privileged user**:

```bash
mysql -u root -p
```

2. **Run the following SQL commands:**

```sql
-- 1. Create the database
CREATE DATABASE example_db CHARACTER SET utf8 COLLATE utf8_general_ci;

-- 2. Create the user (if not exists)
CREATE USER 'example_db'@'localhost' IDENTIFIED BY 'PaSSw0rd';

-- 3. Grant all privileges to that user on the new database
GRANT ALL PRIVILEGES ON tradedns_b2btrade4expor.* TO 'example_db'@'localhost';

-- 4. Apply changes
FLUSH PRIVILEGES;
```



***

## Import Database

### **Prerequisites**

* MySQL is installed and added to the system's PATH.
* You know your MySQL credentials.
* The database you want to import **already exists**.
* You have the `.sql` file on your disk.

### Syntax

```
mysql -u [username] -p [database_name] < [path_to_sql_file]
```

### **Example**

Suppose:

* **Host:** `localhost`
* **Username:** example
* **Password:** Password
* **Database:** example\_db
* **Charset:** `utf8`



#### **Ensure the Database Exists**

You must create the database **before** importing, unless the `.sql` file includes `CREATE DATABASE`. Use this command:

```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS example_db CHARACTER SET utf8 COLLATE utf8_general_ci;"
```



#### **Import the `.sql` File via CMD**

Assume your `.sql` file is at: `C:\backups\tradedns.sql`

#### Run this:

```bash
mysql -u example -p example_db  < "C:\backups\tradedns.sql"
```

* It will prompt you for the password → enter `password`&#x20;



