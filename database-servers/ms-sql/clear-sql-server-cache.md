---
icon: fire-smoke
---

# Clear SQL Server Cache

## What is SQL Server Cache?

SQL Server uses memory to cache:

* <mark style="color:green;">**Execution Plans**</mark> <mark style="color:green;"></mark><mark style="color:green;">(Plan Cache)</mark>
* <mark style="color:green;">**Data Pages**</mark> <mark style="color:green;"></mark><mark style="color:green;">(Buffer Pool)</mark>
* <mark style="color:green;">**Procedure Cache**</mark> <mark style="color:green;"></mark><mark style="color:green;">(Compiled procedures/functions)</mark>

This improves performance by reducing the need to recompile queries or fetch data from disk repeatedly.

## Why Clear SQL Server Cache?

* <mark style="color:green;">For</mark> <mark style="color:green;"></mark><mark style="color:green;">**performance testing**</mark> <mark style="color:green;"></mark><mark style="color:green;">(benchmarking with a "cold cache")</mark>
* <mark style="color:green;">To</mark> <mark style="color:green;"></mark><mark style="color:green;">**troubleshoot performance issues**</mark>
* <mark style="color:green;">After</mark> <mark style="color:green;"></mark><mark style="color:green;">**large data changes**</mark>
* <mark style="color:green;">To</mark> <mark style="color:green;"></mark><mark style="color:green;">**free up memory**</mark> <mark style="color:green;"></mark><mark style="color:green;">temporarily</mark>

{% hint style="danger" %}
#### **Caution**

Clearing cache can **slow down** performance temporarily since SQL Server has to reload data/plans into memory. **Do not use on production servers unless necessary**.
{% endhint %}

## Commands to Clear SQL Server Cache

### **Clear the Procedure (Execution Plan) Cache**

```
DBCC FREEPROCCACHE;
```

### Clear the Buffer Pool (Data Cache)

```
DBCC DROPCLEANBUFFERS;
```

### Clear Both Caches (Common for testing)

```
CHECKPOINT;
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;
```

{% hint style="warning" %}
#### Permissions Required

* Membership in the `sysadmin` or `serveradmin` role.
{% endhint %}

{% hint style="success" %}
#### Useful for:

* Database **performance testing**
* Resetting **memory usage**
* **Benchmarking** different query versions
{% endhint %}



***

## REFERENCES

* [https://www.mssqltips.com/sqlservertip/4714/different-ways-to-flush-or-clear-sql-server-cache/](https://www.mssqltips.com/sqlservertip/4714/different-ways-to-flush-or-clear-sql-server-cache/)
