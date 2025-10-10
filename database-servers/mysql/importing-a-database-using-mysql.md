---
icon: square-terminal
---

# Importing a Database Using MySQL

#### **1. Prerequisites**

Before importing a database, ensure that:

* MySQL or MariaDB is installed and running.
* You have access to the MySQL client (command-line tool).
* You have a valid **`.sql`** dump file (e.g., `database.sql`).
* You have the necessary **username** and **password** to access the MySQL server.
* The target **database already exists** (or you have permission to create one).

#### **2. Command-Line Method**

You can import a database directly from the **Command Prompt** or **Terminal**.

**Step 1: Open Command Prompt**

Navigate to the MySQL bin directory (if not already in PATH):

```bash
cd C:\xampp\mysql\bin
```

***

**Step 2: Access MySQL**

Login to MySQL using:

```bash
mysql -u root -p
```

Then, enter your MySQL password when prompted.

***

**Step 3: (Optional) Create a Database**

If the target database doesn’t exist, create one:

```sql
CREATE DATABASE fisheriesexp1;
```

Then exit MySQL:

```sql
quit;
```

***

**Step 4: Import the `.sql` File**

Run the import command:

```bash
mysql -u root -p fisheriesexp1 < C:\Users\Administrator\Downloads\fisheriesexp.sql
```

**Explanation:**

* `-u root` → Username (`root`)
* `-p` → Prompts for password
* `fisheriesexp1` → Target database name
* `<` → Tells MySQL to read from the SQL file
* `C:\Users\Administrator\Downloads\fisheriesexp.sql` → Path to your SQL dump file

***

#### **3. Alternative: Using phpMyAdmin**

If you’re using **XAMPP**, you can import databases visually via phpMyAdmin:

1. Start **Apache** and **MySQL** from XAMPP Control Panel.
2.  Open your browser and visit:

    ```
    http://localhost/phpmyadmin
    ```
3. Create a new database (if not exists).
4. Select the database → Go to **Import** tab.
5. Choose your `.sql` file → Click **Go**.
