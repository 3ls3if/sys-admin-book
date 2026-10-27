---
icon: database
---

# How to increase database size in sql server

Increasing the size of a database in SQL Server can be achieved by expanding existing data and log files or by adding new files.

Using SQL Server Management Studio (SSMS):

* **Connect to the Database Instance:** Open SSMS and connect to the desired SQL Server instance.
* **Locate the Database:** In Object Explorer, expand "Databases," then right-click on the database you wish to modify, and select "Properties."
* **Access the Files Page:** In the "Database Properties" window, navigate to the "Files" page.
* **Increase Existing File Size:** To increase the size of an existing data or log file, locate the file in the grid and modify the value in the "Initial Size (MB)" column to the desired larger size.&#x20;

&#x20;

* **Configure Autogrowth (Optional but Recommended):** Click the "..." button next to "Autogrowth / Maxsize" for the respective file. In the "Change Autogrowth" dialog, enable "Enable Autogrowth" and configure the "File Growth" increment (e.g., by 64 MB) and the "Maximum File Size" (e.g., unlimited or a specific size).
* **Add New Files (Optional):** To add a new data or log file, click the "Add" button and specify the file name, file type (ROWS or LOG), initial size, and filegroup (for data files).
* **Apply Changes:** Click "OK" to apply the changes to the database properties.

***

**Using Transact-SQL (T-SQL):**

You can use the `ALTER DATABASE` statement to modify file properties.

**To increase the size of an existing file:**

```
ALTER DATABASE YourDatabaseName
MODIFY FILE (NAME = LogicalFileName, SIZE = NewSizeMB);
```

Replace `YourDatabaseName` with the actual database name, `LogicalFileName` with the logical name of the data or log file (you can find this in `sys.database_files`), and `NewSizeMB` with the desired new size in megabytes.

**To add a new file:**

```
ALTER DATABASE YourDatabaseName
ADD FILE (NAME = NewLogicalFileName, FILENAME = 'C:\Path\To\NewFile.ndf', SIZE = InitialSizeMB, FILEGROWTH = GrowthIncrementMB)
TO FILEGROUP YourFilegroupName; -- For data files
```

**or for a log file:**

```
ALTER DATABASE YourDatabaseName
ADD LOG FILE (NAME = NewLogicalLogFileName, FILENAME = 'C:\Path\To\NewLogFile.ldf', SIZE = InitialSizeMB, FILEGROWTH = GrowthIncrementMB);
```

**Important Considerations:**

**Disk Space:**

Ensure sufficient disk space is available on the drive where the database files reside.

**Autogrowth Settings:**

Properly configuring autogrowth for data and log files can help prevent database outages due to full files.

**Transaction Log Management:**

Regularly back up the transaction log to prevent it from growing excessively.

**SQL Server Express Edition:**

Be aware of the 10 GB database size limit for SQL Server Express Edition.
