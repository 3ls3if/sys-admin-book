---
icon: globe-wifi
---

# How to Open a URL Daily at 2 AM Using Task Scheduler

In many server administration or automation use cases, you may want to open a specific URL every day at a scheduled time—for instance, triggering a web-based report, monitoring system, or internal dashboard. This guide walks you through **two simple methods** to set this up on **Windows Server** using **Task Scheduler**:

***

### Method 1: Using a `.bat` (Batch) File

#### Step 1: Create a Batch File to Open the URL

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Notepad**</mark><mark style="color:green;">.</mark>
2.  <mark style="color:green;">Paste the following code:</mark>

    ```bat
    @echo off
    start "" "https://example.com"
    ```
3. <mark style="color:green;">Save the file as</mark> <mark style="color:green;"></mark><mark style="color:green;">`open_url.bat`</mark> <mark style="color:green;"></mark><mark style="color:green;">in a secure location like</mark> <mark style="color:green;"></mark><mark style="color:green;">`C:\Scripts`</mark><mark style="color:green;">.</mark>

{% hint style="warning" %}
This command uses `start` to launch the URL with the default browser. The `""` prevents Windows from treating the URL as a window title.
{% endhint %}

***

#### Step 2: Schedule It with Task Scheduler

1. <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`taskschd.msc`</mark><mark style="color:green;">, and press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enter**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Create Basic Task**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Give the task a name (e.g.,</mark> <mark style="color:green;"></mark><mark style="color:green;">`OpenURLDaily`</mark><mark style="color:green;">) and description.</mark>
4. <mark style="color:green;">Set the trigger to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Daily**</mark><mark style="color:green;">, and choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**2:00 AM**</mark> <mark style="color:green;"></mark><mark style="color:green;">as the start time.</mark>
5. <mark style="color:green;">For the action, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Start a program**</mark><mark style="color:green;">.</mark>
6. <mark style="color:green;">Browse and select</mark> <mark style="color:green;"></mark><mark style="color:green;">`open_url.bat`</mark><mark style="color:green;">.</mark>
7. <mark style="color:green;">Finish the wizard.</mark>

**Optional: Advanced Settings**

* <mark style="color:green;">If using</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Create Task”**</mark> <mark style="color:green;"></mark><mark style="color:green;">instead of Basic:</mark>
  * <mark style="color:green;">Check</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Run whether user is logged on or not”**</mark>
  * <mark style="color:green;">Check</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Run with highest privileges”**</mark>
  * <mark style="color:green;">Adjust</mark> <mark style="color:green;"></mark><mark style="color:green;">**Conditions**</mark> <mark style="color:green;"></mark><mark style="color:green;">to ensure it runs even if on battery or idle.</mark>

***

### Method 2: Using a PowerShell Script

#### Step 1: Create a PowerShell Script

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Notepad**</mark><mark style="color:green;">.</mark>
2.  <mark style="color:green;">Paste the following:</mark>

    ```powershell
    Start-Process "https://example.com"
    ```
3. <mark style="color:green;">Save the file as</mark> <mark style="color:green;"></mark><mark style="color:green;">`open_url.ps1`</mark> <mark style="color:green;"></mark><mark style="color:green;">in</mark> <mark style="color:green;"></mark><mark style="color:green;">`C:\Scripts`</mark><mark style="color:green;">.</mark>

***

#### Step 2: Schedule It with Task Scheduler

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Task Scheduler**</mark> <mark style="color:green;"></mark><mark style="color:green;">(</mark><mark style="color:green;">`taskschd.msc`</mark><mark style="color:green;">).</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Create Basic Task**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Name the task and set the trigger to run</mark> <mark style="color:green;"></mark><mark style="color:green;">**daily at 2:00 AM**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">In the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Action**</mark> <mark style="color:green;"></mark><mark style="color:green;">step, choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**Start a program**</mark><mark style="color:green;">.</mark>
5.  <mark style="color:green;">Set the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Program/script**</mark> <mark style="color:green;"></mark><mark style="color:green;">to:</mark>

    ```
    powershell.exe
    ```
6.  <mark style="color:green;">Set</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add arguments (optional)**</mark> <mark style="color:green;"></mark><mark style="color:green;">to:</mark>

    ```
    -ExecutionPolicy Bypass -File "C:\Scripts\open_url.ps1"
    ```

**Optional: Advanced Settings**

* <mark style="color:green;">Use</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Create Task"**</mark> <mark style="color:green;"></mark><mark style="color:green;">for more control.</mark>
* <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Run with highest privileges”**</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Run whether user is logged on or not.”**</mark>



{% hint style="warning" %}
### Final Notes

* Both methods launch the URL using the **default browser** set on the system.
* Use **PowerShell** if you need more advanced control or want to expand the script in the future.
* Always test the script manually before scheduling to ensure it behaves as expected.
{% endhint %}



***

## REFERENCES

* [https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-start-page](https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-start-page)
