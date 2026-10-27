---
icon: binary
---

# Understanding SQL Server Express Edition Storage Limits and Their Impact on Application Data

SQL Server Express is a widely used, free edition of Microsoft SQL Server. It is popular for small to medium applications because it provides strong database capabilities at no licensing cost. However, it comes with a number of **built-in limitations**, and the most important one is **database storage size**.

This article explains the SQL Server Express storage limitation, why the issue occurs in some tables and not others, and what solutions are available.

***

### **1. SQL Server Express Has a Hard Storage Limit**

SQL Server Express editions (2012–2022) have the following limit:

#### **Maximum Database Size: 10 GB per database**

This limit applies to:

* The **primary data file** (.mdf)
* Any **secondary data files** (.ndf)
* The entire **filegroup**

Once the combined size of all data files reaches 10 GB, SQL Server Express **cannot grow anymore**.

Logs (.ldf) do _not_ count toward the 10 GB limit, but data files do.

***

### **2. Why You Can Still Insert Data Into Some Tables**

A common point of confusion is:

> _“If the database is full, why can I insert data into some tables but not others?”_

The reason is how SQL Server allocates storage internally.

#### SQL Server allocates storage in units called **pages** (8 KB each) and **extents** (64 KB each).

When a table has free space inside its existing pages, SQL Server can insert more rows **without allocating new pages**.

So:

#### ✔ Some tables may still have unused space inside their allocated extents

#### ❌ The table that fails (like `Api_Details`) requires new space, and none is available

This is why you see:

```
Could not allocate space for object 'dbo.Api_Details'.'PK_Api_Details'
because the PRIMARY filegroup is full.
```

It is not that SQL Server “blocks one table”—it simply cannot allocate new space for the table that has grown large.

***

### **3. Example: Api\_Details Table Consuming Large Storage**

From the `sp_spaceused` output:

```
Rows:     108,601
Data:     625,904 KB (≈611 MB)
Unused:   1,624 KB
```

This table stores:

* Encrypted request bodies
* Encrypted responses

This means the table grows very quickly. Because the database is near the 10 GB limit, the system cannot allocate additional pages required by this large table.

Smaller tables (e.g., ones with a few hundred rows) can still insert, because they have free space already allocated.

***

### **4. Symptoms of Hitting the SQL Express Storage Limit**

Once the database reaches the 10 GB limit, you may see:

* Errors inserting into large or fast-growing tables
* Intermittent failures only for specific tables
* Autogrowth failures
* `PRIMARY filegroup is full` errors
* Queries slowing down because SQL Server cannot reorganize pages

This is expected behavior when the size cap is reached.

***

### **5. Solutions To Overcome the 10 GB Limit**

Since the limit is part of SQL Server Express, you cannot disable or bypass it.\
But you _can_ work around it:

***

#### **Solution A — Delete old or unused data**

Best for large logs or API tables.

Example:

```sql
DELETE FROM Api_Details
WHERE CreatedOn < DATEADD(DAY, -30, GETDATE());
```

Then shrink the database:

```sql
DBCC SHRINKDATABASE('YourDatabaseName');
```

***

#### **Solution B — Archive data to another database**

Move older data to a separate database or backup table, keeping only recent data in the main database.

***

#### **Solution C — Add a new file (if database is not yet exactly 10 GB)**

Adding another `.ndf` file spreads data over multiple files, but still:

* The **total** size must stay under 10 GB.
* If you already hit 10 GB, this will not help.

***

#### **Solution D — Upgrade to SQL Server Standard or Web Edition**

These editions support:

* No 10 GB data limit
* Table and index compression
* Better performance, more CPU/memory support

This is the long-term solution for growing systems.

***

### **6. Best Practices to Avoid Hitting the Limit Again**

* Regularly clean up large logging tables (API logs, audit logs, temporary data).
* Enable scheduled jobs to automatically delete or archive old records.
* Monitor database size monthly.
* Do not store large encrypted request/response bodies directly in the database unless necessary.

***

### **7. Conclusion**

The error encountered—“PRIMARY filegroup is full”—is a direct consequence of SQL Server Express reaching its built-in 10 GB limit. This limit cannot be expanded without upgrading the edition.

Tables with large, rapidly growing data such as `Api_Details` exhaust space faster, which is why inserts fail there first, even while smaller tables continue to accept data.

The recommended approach is to:

* Archive or delete older data, or
* Upgrade to a higher SQL Server edition if long-term growth is expected.
