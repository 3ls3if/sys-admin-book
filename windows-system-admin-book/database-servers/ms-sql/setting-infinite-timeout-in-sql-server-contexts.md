---
icon: clock-ten
---

# Setting Infinite Timeout in SQL Server Contexts

{% hint style="warning" %}
#### Note:

SQL Server itself does **not have a built-in "infinite timeout"** at the server level. Timeout behavior is controlled at the **client/tool/application level**.
{% endhint %}

#### **SQL Server Management Studio (SSMS)**

* <mark style="color:green;">Navigate to:</mark>\
  <mark style="color:green;">`Tools`</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">`Options`</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">`Query Execution`</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">`SQL Server`</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">`General`</mark>
* <mark style="color:green;">Set</mark> <mark style="color:green;"></mark><mark style="color:green;">**Execution time-out**</mark> <mark style="color:green;"></mark><mark style="color:green;">to</mark> <mark style="color:green;"></mark><mark style="color:green;">`0`</mark>
* <mark style="color:green;">A value of</mark> <mark style="color:green;"></mark><mark style="color:green;">**0**</mark> <mark style="color:green;"></mark><mark style="color:green;">means</mark> <mark style="color:green;"></mark><mark style="color:green;">**no timeout (infinite)**</mark>



{% hint style="warning" %}
Setting timeouts to **infinite** can be useful for long-running queries, but use with caution to avoid hanging systems or applications.
{% endhint %}

