---
icon: trash-can
---

# Uninstall an Instance of SQL Server

{% hint style="warning" %}
[SQL Server](https://www.geeksforgeeks.org/introduction-of-ms-sql-server/) is a Relational Database Management system that was developed and marketed by Microsoft.&#x20;
{% endhint %}

#### **Prerequisites:**

1. To uninstall SQL Server, you need to have local administrator permissions.
2. Back up your data. You could create full backups of all databases, including system databases, or manually copy the .mdf and .ldf files to a separate location.
3. Stop all SQL Server services.

#### **Uninstall:**

* To start the removal process from Windows Server 2008, Windows Server 2012 and Windows 2012 R2 navigate to the **Control Panel**, then select **Programs and Features.**
* Right-click Microsoft SQL Server (Version) (Bit) and choose **Uninstall**.

**OR**

* To start the removal process from Windows 10, Windows Server 2016, Windows Server 2019 navigate to Settings from the Start menu and then choose Apps.
* Search for SQL within the search box, select Microsoft SQL Server (Version) (Bit). As ab example, Microsoft SQL Server 2016 (64-bit) shown below:

<figure><img src="https://media.geeksforgeeks.org/wp-content/uploads/20210603154452/remove-660x526.png" alt=""><figcaption></figcaption></figure>

* Select **Uninstall**.
* Select Remove on the SQL Server pop-up dialog box to launch the Microsoft SQL Server wizard.

<figure><img src="https://media.geeksforgeeks.org/wp-content/uploads/20210603154616/step1.png" alt=""><figcaption></figcaption></figure>

* Use the drop-down to select Instance, mark the SQL Server instance name, or the option to remove only SQL Server shared features and management tools. To continue, select Next.
* On the Select Features page, choose the features which required to be removed from the instance of SQL Server.

<figure><img src="https://media.geeksforgeeks.org/wp-content/uploads/20210603154842/step2.png" alt=""><figcaption></figcaption></figure>

* On the Remove page, preview the list of features and components which will be uninstalled. Click Remove to start the un-installation.

<figure><img src="https://media.geeksforgeeks.org/wp-content/uploads/20210603154943/step3.png" alt=""><figcaption></figcaption></figure>

* Refresh the Apps and Features window in Windows 10, Windows Server 2016, Windows Server 2019, or Programs and Features in Windows Server 2008, Windows Server 2012 and Windows 2012 R2 to verify the SQL Server instance has been removed with success.

***

## REFERENCES

* [https://learn.microsoft.com/en-us/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup?view=sql-server-ver16\&tabs=Windows10](https://learn.microsoft.com/en-us/sql/sql-server/install/uninstall-an-existing-instance-of-sql-server-setup?view=sql-server-ver16\&tabs=Windows10)
* [https://www.geeksforgeeks.org/sql/how-to-uninstall-an-instance-of-sql-server/](https://www.geeksforgeeks.org/sql/how-to-uninstall-an-instance-of-sql-server/)
* [https://www.sql-easy.com/learn/how-to-uninstall-sql-server/](https://www.sql-easy.com/learn/how-to-uninstall-sql-server/)
* [https://kb.lenels2.com/home/how-to-perform-a-clean-uninstall-of-microsoft-sql-server](https://kb.lenels2.com/home/how-to-perform-a-clean-uninstall-of-microsoft-sql-server)
