---
icon: windows
---

# IIS Application Pool

## Can You Limit RAM Per Domain in IIS Using Virtual Memory Recycling?

{% hint style="success" %}
If you're managing multiple websites hosted on **IIS (Internet Information Services)** and you're wondering whether you can control the **RAM usage per domain**, you've landed on the right post. Let's break this down in a way that's easy to understand and implement.
{% endhint %}

### The Question

**"Can I limit RAM for different domains using virtual memory recycling in IIS?"**

### The Short Answer

**Not directly per domain**, but you can achieve this **per Application Pool**—and since each website (domain) can be assigned its own App Pool, **you&#x20;**_**can**_**&#x20;effectively control memory usage per site**.

### How It Works

IIS doesn’t provide a built-in option to limit memory on a per-domain basis. However:

* <mark style="color:green;">**Each Application Pool**</mark> <mark style="color:green;"></mark><mark style="color:green;">runs its own</mark> <mark style="color:green;"></mark><mark style="color:green;">**worker process**</mark> <mark style="color:green;"></mark><mark style="color:green;">(</mark><mark style="color:green;">`w3wp.exe`</mark><mark style="color:green;">).</mark>
* <mark style="color:green;">You can assign</mark> <mark style="color:green;"></mark><mark style="color:green;">**one domain per App Pool**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Then, configure</mark> <mark style="color:green;"></mark><mark style="color:green;">**memory limits**</mark> <mark style="color:green;"></mark><mark style="color:green;">on each pool to restrict RAM usage.</mark>

This gives you **process-level isolation** between your sites—if one misbehaves, it won’t affect the others.



***

### Steps to Limit RAM Per Domain

Here’s how to set it up:

#### 1.  Create Separate App Pools

For each website (domain), create a dedicated **Application Pool**.

#### 2.  Assign Sites to App Pools

Link each website to its own App Pool using the **IIS Manager**.

#### 3. Set Memory Limits

Go to:

```
IIS Manager > Application Pools > [Your App Pool] > Advanced Settings
```

Then set:

* <mark style="color:green;">**Private Memory Limit (KB)**</mark> <mark style="color:green;"></mark><mark style="color:green;">– for limiting</mark> <mark style="color:green;"></mark><mark style="color:green;">**non-shared RAM usage**</mark>
* <mark style="color:green;">**Virtual Memory Limit (KB)**</mark> <mark style="color:green;"></mark><mark style="color:green;">– for limiting</mark> <mark style="color:green;"></mark><mark style="color:green;">**total virtual memory**</mark><mark style="color:green;">, including RAM + page file</mark>

> Example values:
>
> * 500 MB → `512000`
> * 1 GB → `1024000`
> * 750 MB → `768000`

{% hint style="danger" %}
#### What Is **Non-Shared RAM Usage** (aka **Private Memory**)?

**Non-shared RAM usage**, or **private memory**, refers to the portion of RAM that is **used exclusively by a single process**—in this case, the **IIS worker process (`w3wp.exe`)**.

This memory:

* **Cannot be shared** with other processes
* Is allocated only for **that specific app pool**
* Is where your application stores its **data, state, and code execution** that isn't part of shared system libraries or memory-mapped files
{% endhint %}



***

### &#x20;Example Scenario

You’re hosting these websites:

* `siteA.com` → needs up to **500 MB**
* `siteB.com` → needs up to **1 GB**
* `siteC.com` → needs up to **750 MB**

Here’s how you configure:

| Domain    | App Pool       | Memory Limit (Virtual) |
| --------- | -------------- | ---------------------- |
| siteA.com | AppPool\_SiteA | 512000 KB              |
| siteB.com | AppPool\_SiteB | 1024000 KB             |
| siteC.com | AppPool\_SiteC | 768000 KB              |

***

### Pro Tip: Monitor Before You Limit

Before setting arbitrary values:

* <mark style="color:green;">Monitor each app’s real-world memory usage using</mark> <mark style="color:green;"></mark><mark style="color:green;">**Performance Monitor (perfmon.exe)**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**Resource Monitor**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Base your thresholds on actual patterns to avoid unnecessary app pool recycling, which can affect performance.</mark>

***

### Bonus: Automate with PowerShell

Managing dozens of sites? Here's a quick PowerShell snippet to set a memory limit:

```powershell
# Example: Set virtual memory limit for AppPool_SiteA to 512 MB
Set-ItemProperty IIS:\AppPools\AppPool_SiteA -Name recycling.periodicRestart.privateMemory -Value 512000
```

You can loop this across all your app pools for automation. Let me know if you'd like a full script template.

***

### Final Thoughts

While IIS doesn't allow **per-domain** memory limits directly, assigning each domain its own **Application Pool** and applying **memory recycling thresholds** is a robust, scalable solution. It enhances performance, improves fault isolation, and ensures each site plays nice with system resources.

***

Want help tuning these settings for your own environment or automating across your web farm? Drop a comment or reach out—we’re happy to help!
