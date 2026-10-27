---
icon: windows
---

# MS SQL DB Backup

## Introduction

In SQL Server, the database can be stored in different files and filegroups. If your database is small (100 MB or less), you do not need to worry too much about files and filegroups. But if you have a large database (in several GBs or TBs), separating the data into different files help you to optimize the performance. You can store the data files in different disks. This will also help to backup and restore the information faster because you do not need to restore the entire database but only the files or the filegroups selected.

## Types of Backups

In SQL Server, there are different types of backups:

1. **Full Backup:** It contains the entire database information.
2. **Differential Backup:** It requires a full backup and then it stores the differences between the previous backup and the current database. This backup requires less information because it stores only the differences.
3. **Transaction Log Backup:** It stores the information about the Transaction log.



***

## **How To Create a Full Backup Using SSMS**

1. In **Object Explorer**, connect to the desired instance of the **Microsoft SQL Server Database Engine**, expand the server instance.
2. Expand [**Databases** ](https://www.geeksforgeeks.org/what-is-database/)**box** and select a user database or select a system database.
3.  **Right-click** the database that need to backup, click on **Tasks**, and then click **Back Up.**

    <figure><img src="https://media.geeksforgeeks.org/wp-content/uploads/20200910161620/bkp1.PNG" alt=""><figcaption></figcaption></figure>
4.  In the Back-Up Database dialog box, the database that you selected appears in the drop-down list.<br>

    * In the Backup type **drop**–**down** list, select the **backup type** – the default is **Full**.
    * Under Backup component, select **Database**.
    * Review the default location for the backup file, in the Destination section.
    * To remove a backup destination, click on it and **Remove**.<br>
    * To backup to a new device, change the selection using the **Add** and select destination.

    ![](https://media.geeksforgeeks.org/wp-content/uploads/20200910162100/bkp2.PNG)
5.  Review the other available settings under the **Media Options** and **Backup Options** pages.

    <figure><img src="https://media.geeksforgeeks.org/wp-content/uploads/20200910162443/bkp23.PNG" alt=""><figcaption></figcaption></figure>
6.  Click OK to start the backup. Click OK to close the [**SQL Server Management Studio** ](https://www.geeksforgeeks.org/sql-server-management-studio-ssms/)dialog box once the backup completed successfully.

    <figure><img src="https://media.geeksforgeeks.org/wp-content/uploads/20200910162602/bkp4.PNG" alt=""><figcaption></figcaption></figure>





