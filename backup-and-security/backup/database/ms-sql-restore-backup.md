---
icon: windows
---

# MS SQL Restore Backup

## **SQL Server Backup and Restore with SSMS using BAK File**

With SSMS and the T-SQL command, we can easily restore backup file (.bak). Follow the steps listed below to know how to restore SQL Database from backup using SSMS utility.

**Step 1**. Open SSMS and connect to your database

**Step 2.** Select the database and **right click >> Tasks >> Restore >> Database**

<figure><img src="https://www.systoolsgroup.com/updates/wp-content/uploads/2020/04/restore-database1-1.png" alt="Restore SQL Database" height="549" width="765"><figcaption></figcaption></figure>

**Step 3.** In the **Restore Database** window, select **From device** under Source for restore section and click the **Browse (…)** button.

<figure><img src="https://www.systoolsgroup.com/updates/wp-content/uploads/2020/04/restore-database2.png" alt="Restore Database From BAK File" height="622" width="700"><figcaption></figcaption></figure>

**Step 4.** **Specify Backup** window will open, set Backup media as **File** and click **Add** button for learning how to backup database in SQL Server.

<figure><img src="https://www.systoolsgroup.com/updates/wp-content/uploads/2020/04/restore-database3.png" alt="Restore SQL Server Database" height="360" width="496"><figcaption></figcaption></figure>

**Step 5.** Select backup file which you want to restore and click OK.

<figure><img src="https://www.systoolsgroup.com/updates/wp-content/uploads/2020/04/restore-database4.png" alt="Restore .bak file" height="604" width="431"><figcaption></figcaption></figure>

**Step 6.** The .bak file will be list on the Restore Database window. Click **OK**

**Step 7.** Now, click on **Options** from the left side, select your desired **Restore options** and **Recovery state**

<figure><img src="https://www.systoolsgroup.com/updates/wp-content/uploads/2020/04/restore-database5.png" alt="Restore Database SQL server" height="628" width="698"><figcaption></figcaption></figure>

**Step 8.** In the end, click **OK**.

