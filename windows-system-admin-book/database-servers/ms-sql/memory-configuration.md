---
icon: memory
---

# Memory configuration

### Max server memory <a href="#max-server-memory" id="max-server-memory"></a>

The max server memory option sets the maximum amount of memory that the SQL Server instance can use. It is generally used if multiple applications are running on the same server where SQL Server is running and you want to guarantee that these applications have sufficient memory to function properly.

Some applications only use whatever memory is available when they start and do not request additional memory, even if they are under memory pressure. That is where the max server memory setting comes into play.

On a SQL Server cluster with several SQL Server instances, each instance could be competing for resources. Setting a memory limit for each SQL Server instance can help guarantee best performance for each instance.

{% hint style="warning" %}
**Recommends** leaving at least 4GB to 6GB of RAM for the operating system to avoid performance issues.
{% endhint %}

<figure><img src="https://docs.netapp.com/us-en/ontap-apps-dbs/media/mssql-max-server-memory.png" alt=""><figcaption></figcaption></figure>

#### Adjusting minimum and maximum server memory using SQL Server Management Studio. <a href="#adjusting-minimum-and-maximum-server-memory-using-sql-server-management-studio" id="adjusting-minimum-and-maximum-server-memory-using-sql-server-management-studio"></a>

Using SQL Server Management Studio to adjust minimum or maximum server memory requires a restart of the SQL Server service. You can also adjust server memory using transact SQL (T-SQL) using this code:

```
EXECUTE sp_configure 'show advanced options', 1
GO
EXECUTE sp_configure 'min server memory (MB)', 2048
GO
EXEC sp_configure 'max server memory (MB)', 120832
GO
RECONFIGURE WITH OVERRIDE
```

***

### Nonuniform memory access <a href="#nonuniform-memory-access" id="nonuniform-memory-access"></a>

Nonuniform memory access (NUMA) is a memory-access optimization technology that helps avoid extra the load on the processor bus.

If NUMA is configured on a server where SQL Server is installed, no additional configuration is required because SQL Server is NUMA-aware and performs well on NUMA hardware.

***

### Index create memory <a href="#index-create-memory" id="index-create-memory"></a>

The index create memory option is another advanced option that should not normally need to be changed from defaults.

It controls the maximum amount of RAM initially allocated for creating indexes. The default value for this option is 0, which means that it is managed by SQL Server automatically. However, if you encounter difficulties creating indexes, consider increasing the value of this option.

***

### Min memory per query <a href="#min-memory-per-query" id="min-memory-per-query"></a>

When a query is run, SQL Server tries to allocate the optimum amount of memory to run efficiently.

By default, the min memory per query setting allocates >= to 1024KB for each query to run. It is a best practice is to leave this setting at the default value in order to allow SQL Server to dynamically manage the amount of memory allocated for index creation operations. However, if SQL Server has more RAM than it needs to run efficiently, the performance of some queries can be boosted if you increase this setting. Therefore, as long as memory is available on the server that is not being used by SQL Server, any other applications, or the operating system, then boosting this setting can help overall SQL Server performance. If no free memory is available, increasing this setting might hurt overall performance.

<figure><img src="https://docs.netapp.com/us-en/ontap-apps-dbs/media/mssql-min-memory-per-query.png" alt=""><figcaption></figcaption></figure>



***

## REFERENCES

* [https://docs.netapp.com/us-en/ontap-apps-dbs/mssql/mssql-memory-configuration.html#min-memory-per-query](https://docs.netapp.com/us-en/ontap-apps-dbs/mssql/mssql-memory-configuration.html#min-memory-per-query)
