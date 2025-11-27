---
icon: tractor
---

# Manual steps for MSSQL SQL Trace file Create, Start, Stop and Delete

## Manual steps for MSSQL SQL Trace file Create, Start, Stop and Delete

For every MSSQL Server agent two traces will be created for Applicare.

* <mark style="color:green;">**SQLTraceProfiling.trc**</mark> <mark style="color:green;"></mark><mark style="color:green;">- To gather SQL data -</mark> <mark style="color:green;"></mark><mark style="color:green;">**512 MB (max)**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">**SQLDeadlockTraceProfiling.trc**</mark> <mark style="color:green;"></mark><mark style="color:green;">- To gather Deadlock data -</mark> <mark style="color:green;"></mark><mark style="color:green;">**10 MB (max).**</mark>
* <mark style="color:green;">Once it reaches its maximum size it will reset. It will not go beyond their maximum limit.</mark>

**Step 1:** Login into **MSSQL Server** with '**sa**' or **Applicare** user. The user should have **sysadmin** permission and create and modify permission for SQL traces in "**master**" database.

**Step 2:** Select "**master**" database and select "**New Query**".



***

**View Trace**

```
Select * from sys.traces;
```

If it is a Applicare trace then in the path column it will have the Applicare Agent Home path and at last it will end with **SQLTraceProfiling.trc** and **SQLDeadlockTraceProfiling.trc**

**Trace details**

<mark style="color:green;">**id -**</mark> <mark style="color:green;"></mark><mark style="color:green;">@traceID</mark>

<mark style="color:green;">**status -**</mark> <mark style="color:green;"></mark><mark style="color:green;">@status</mark>

<mark style="color:green;">**Status Conditions**</mark>

0 - Stops the specified trace.\
1 - Starts the specified trace.\
2 -  Closes the specified trace and deletes its definition from the server.

**Path -** Trace file created path

**Modifies the current state of the specified trace**

```
sp_trace_setstatus @traceid , @status;
```

Replace the **@traceid** with correct **id** and **@status** with **status condition** and execute the above query

Let us consider **@traceid** - **2**

**Start Trace**

```
sp_trace_setstatus 2 , 1;
```

**Stop Trace**

```
sp_trace_setstatus 2 , 0;
```

**Delete Trace**

1\. Stop the Agent.\
2\. Stop the trace if it is already running.\
3\. Execute the below query to delete the trace from MSSQL server.

```
sp_trace_setstatus 2 , 2
```

4\. Delete the trace files from the Agent Home directory.<br>

***

## REFERENCES

* [https://helpdesk.arcturustech.com/hc/en-us/community/posts/4406769466765-Manual-steps-for-MSSQL-SQL-Trace-file-Create-Start-Stop-and-Delete](https://helpdesk.arcturustech.com/hc/en-us/community/posts/4406769466765-Manual-steps-for-MSSQL-SQL-Trace-file-Create-Start-Stop-and-Delete)
