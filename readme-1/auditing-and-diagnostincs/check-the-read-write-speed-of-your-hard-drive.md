---
icon: disc-drive
---

# Check the read/write speed of your hard drive

{% hint style="warning" %}
To check the **read/write speed of your hard drive** (especially relevant for SQL Server performance), you can use various methods depending on whether you're on **Windows**, **Linux**, or via **SQL Server tools**.
{% endhint %}

## On **Windows Server** (SQL Server host)

### Option 1: PowerShell (Quick & Built-In)

```
winsat disk -drive C
```

{% hint style="success" %}
> Replace `C` with your actual data drive letter.
{% endhint %}

### Option 2: Performance Monitor (Built-in GUI Tool)

1. Run `perfmon`.
2. Add counters for:
   * **PhysicalDisk → Avg. Disk sec/Read**
   * **PhysicalDisk → Avg. Disk sec/Write**
   * **PhysicalDisk → Disk Reads/sec**
   * **PhysicalDisk → Disk Writes/sec**

{% hint style="success" %}
Look for **Avg. Disk sec/Read** and **Avg. Disk sec/Write**. Values under `0.005` (5ms) are good.
{% endhint %}

### Option 3: CrystalDiskMark (Third-Party)

* Download: [https://crystalmark.info](https://crystalmark.info)
* Run a benchmark on the drive (e.g., `D:` or `E:`).
* Focus on:
  * **Sequential Read/Write** (bulk operations)
  * **Random 4K Read/Write** (small transactions)

