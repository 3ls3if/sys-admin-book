---
icon: toggle-large-off
---

# Take SQL Server Database Offline

### Take SQL Server Database Offline with SQL Server Management Studio (SSMS)

To start SQL Server Management Studio

1. Left click Start
2. All Apps
3. Microsoft SQL Server Tools
4. Microsoft SQL Server Management Studio

![Start SQL Server Management Studio (SSMS) from Shortcut](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.001.png)

Or alternatively, as the SQL Server Tools path will be appended to your users %PATH% variable:

1. Right click Start
2. Run

![Run](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.002.png)

1. Enter ssms in ‘Open’

![Start SQL Server Management Studio (SSMS) from executable](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.003.png)

Object Explorer will likely open automatically, but if it doesn’t do the following:

1. View
2. Object Explorer (or, just F8)

![Show Object Explorer](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.004.png)

Now, we’ll connect to the database engine.

1. Connect
2. Database Engine…

![Connect](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.005.png)

1. Server name: (in our example I’m connecting to a named instance call SQL2017 on my local machine, so the full name of the SQL Server is .\SQL2017)
2. Authentication (presuming you’re using Active Directory authentication)
3. Connect

![Connect  to Database Engine](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.006.png)

The name of the database we’re going to take offline is called MyDatabase.

1. Expand server dropdown
2. Expand Databases dropdown
3. Right click on database name – MyDatabase
4. Tasks
5. Take Offline

![Start Database Offline](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.007.png)

If the Status is ‘Ready’, there are no connections in the database.

1. Check Status
2. OK

![Database Offline screen](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.008.png)

But, if the status is ‘Not Ready’ as shown below.

1. Click on the ‘Message’ link

![Shows if there are active connections in database](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.009.png)

As we can see in our example, it’s telling us there is one connection in the database we want to take offline. The message box tells us to close the connections or select the ‘Drop All Active Connections’ box. We can take care of this in one of two ways.

Option #1

1. Click ‘New Query’

![New Query](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.010.png)

1. Run EXEC sp\_who2 in the query window
2. F5 (or click Execute button)
3. Look under the DBName column for any referenced to the database we’re taking offline and note the corresponding number under the SPID column

![Look for connections in database](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.011.png)

Next, run kill with the spid on any that are in the database. Here we only have one with a spid = 57.

1. Type in ‘kill x’ for each spid and highlight it
2. F5 (or click Execute)

![Kill connection(s)](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.012.png)

1. Highlight ‘EXEC sp\_who2’
2. F5 (or click Execute)
3. Verify process has been killed

![Verify there are no more connections](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.013.png)

Go back to the Object Explorer.

1. Right click on database name, MyDatabase
2. Tasks
3. Take Offline

In the Take Database Offline window, do the following:

1. Check Status
2. OK

![Take database offline](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.014.png)

One thing to note here. We could have just checked ‘Drop All Active Connections’ to force connections out. But the SQL Server is keeping us from taking the database offline for a reason, which is to protect us from ourselves. It’s just safer to see what connection(s) are in the database first. If you were accidentally attempting to take an active production database offline you would probably be able to catch the mistake before you made it.

Look in the Object Explorer to be sure the database shows (Offline).

![Verify database offline](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.015.png)

If not, do the following:

1. Right click ‘Databases’
2. Refresh

![Refresh Databases list](https://www.mssqltips.com/wp-content/images-tips/6418_taking-sql-server-database-offline.016.png)



***

## REFERENCES

* [https://www.mssqltips.com/sqlservertip/6418/how-to-take-sql-server-database-offline/](https://www.mssqltips.com/sqlservertip/6418/how-to-take-sql-server-database-offline/)
