---
icon: album
---

# Delete Recovery Partition using DiskPart (Admin)

### Delete Recovery Partition using DiskPart (Admin)

#### 1. Open DiskPart

* Press **Win + X** → **Terminal (Admin)** or **Command Prompt (Admin)**
* Run:

```
diskpart
```

***

#### 2. Identify the disk

```
list disk
```

Note the disk number (usually `0`).

```
select disk 0
```

***

#### 3. Find the recovery partition

```
list partition
```

Look for:

* **Type**: Recovery
* Size: usually **500 MB – 1 GB**

Example:

```
Partition 4    Recovery    1000 MB
```

***

#### 4. Select the recovery partition

```
select partition 4
```

***

#### 5. Delete it (force delete)

Recovery partitions are protected, so you **must** use `override`:

```
delete partition override
```

You should see:

> DiskPart successfully deleted the selected partition.

***

### Optional: Reclaim the space

If the deleted partition was next to your main Windows partition:

```
select volume C
extend
```

(Only works if the free space is **adjacent**.)

***

### Exit DiskPart

```
exit
```

***

### (Optional but recommended) Disable WinRE before deleting

If you want to be extra clean:

```
reagentc /disable
```

After deletion, check status:

```
reagentc /info
```

***

### Want to recreate it later?

You can restore WinRE with:

* Windows install media
* Or manually re-enable with `reagentc /enable` after creating a new recovery partition
