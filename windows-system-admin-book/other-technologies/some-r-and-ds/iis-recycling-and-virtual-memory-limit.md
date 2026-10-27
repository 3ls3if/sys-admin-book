---
icon: windows
---

# IIS Recycling and Virtual Memory Limit

{% hint style="success" %}
In **IIS (Internet Information Services)**, **recycling** refers to restarting the **worker process** (`w3wp.exe`) that handles web application requests. It's a built-in mechanism designed to improve the stability and performance of web applications by periodically refreshing the environment in which the application runs.
{% endhint %}

#### What is Recycling in IIS?

When a worker process is recycled, it is **terminated and replaced** by a new one. This can help:

* <mark style="color:green;">Free up memory leaks or excessive memory usage</mark>
* <mark style="color:green;">Reset unstable application states</mark>
* <mark style="color:green;">Apply configuration changes without restarting the server</mark>

Recycling can happen in various ways:

* <mark style="color:green;">**Scheduled recycling**</mark> <mark style="color:green;"></mark><mark style="color:green;">(e.g., every 1740 minutes by default)</mark>
* <mark style="color:green;">**Specific time recycling**</mark>
* <mark style="color:green;">**Request-based recycling**</mark> <mark style="color:green;"></mark><mark style="color:green;">(e.g., after a certain number of requests)</mark>
* <mark style="color:green;">**Memory-based recycling**</mark> <mark style="color:green;"></mark><mark style="color:green;">(discussed next)</mark>

***

#### &#x20;What is Private Memory Limit?

* <mark style="color:green;">**Private Memory Limit**</mark> <mark style="color:green;"></mark><mark style="color:green;">defines the maximum amount of</mark> <mark style="color:green;"></mark><mark style="color:green;">**private memory (non-shared RAM)**</mark> <mark style="color:green;"></mark><mark style="color:green;">a worker process is allowed to use.</mark>
* <mark style="color:green;">If the limit is exceeded,</mark> <mark style="color:green;"></mark><mark style="color:green;">**IIS recycles**</mark> <mark style="color:green;"></mark><mark style="color:green;">the worker process to avoid potential performance degradation or memory exhaustion.</mark>

> Example: If a site has a memory leak, the private memory keeps growing. When it hits the threshold (e.g., 500 MB), IIS recycles it to release memory.

***

#### &#x20;What is Virtual Memory Limit?

* <mark style="color:green;">**Virtual Memory Limit**</mark> <mark style="color:green;"></mark><mark style="color:green;">sets a cap on the</mark> <mark style="color:green;"></mark><mark style="color:green;">**total virtual memory**</mark> <mark style="color:green;"></mark><mark style="color:green;">(including both RAM and page file usage) a worker process can use.</mark>
* <mark style="color:green;">If the worker process exceeds this, it’s recycled.</mark>

> This helps protect the server from apps consuming excessive memory, which could otherwise affect other applications or the whole server.

***

#### &#x20;Key Differences

| Metric               | Type of Memory             | When to Use                                      |
| -------------------- | -------------------------- | ------------------------------------------------ |
| Private Memory Limit | RAM (non-shared)           | To prevent apps with memory leaks hogging memory |
| Virtual Memory Limit | RAM + Page File (total VM) | For overall memory usage control                 |

***

#### &#x20;Things to Keep in Mind

* <mark style="color:green;">Frequent recycling can cause performance issues like application pool cold starts.</mark>
* <mark style="color:green;">Memory limits should be based on monitoring real-world usage, not arbitrary numbers.</mark>
* <mark style="color:green;">Set limits carefully, especially on high-traffic apps.</mark>
