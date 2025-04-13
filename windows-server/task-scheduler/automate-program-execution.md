---
icon: gear
---

# Automate Program Execution

## What Is Windows Task Scheduler?

**Task Scheduler** is a built-in Windows utility that lets you **schedule tasks (like opening apps or running scripts)** based on time, system events, or triggers like logon or idle state. It’s incredibly useful for automating repetitive tasks.

## Restart an IIS Application Every 5 Minutes

We’ll schedule a task to **recycle a specific IIS web application** every 5 minutes using a batch file that uses PowerShell or `appcmd`.

### Step 1: Create the Batch Script

We'll use **PowerShell** inside the batch file to restart the IIS web application.

Let’s assume:

* <mark style="color:green;">Your IIS site is named:</mark> <mark style="color:green;"></mark><mark style="color:green;">`MyWebApp`</mark>
* <mark style="color:green;">IIS is installed and available on your system</mark>

```batch
#restart_iis_app.bat

@echo off
powershell -Command "Restart-WebAppPool -Name 'MyWebApp'"


# You can also restart the entire IIS site using:

@echo off
powershell -Command "Restart-WebItem 'IIS:\Sites\MyWebApp'"


# Or use appcmd.exe (older systems):

@echo off
%windir%\system32\inetsrv\appcmd stop site /site.name:"MyWebApp"
%windir%\system32\inetsrv\appcmd start site /site.name:"MyWebApp"
```

* <mark style="color:green;">Save this script as:</mark>\
  &#x20;`C:\Scripts\restart_iis_app.bat` &#x20;



### Step 2: Create the Task in Task Scheduler

1. Open **Task Scheduler**
2. Click **Create Task** (not basic)
3. In **General Tab**:
   * <mark style="color:green;">Name:</mark> <mark style="color:green;"></mark><mark style="color:green;">`Restart IIS App Every 5 Minutes`</mark>
   * <mark style="color:green;">Check</mark> <mark style="color:green;"></mark><mark style="color:green;">**Run with highest privileges**</mark>
4. In **Triggers Tab**:
   * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**New**</mark>
   * <mark style="color:green;">Begin the task:</mark> <mark style="color:green;"></mark><mark style="color:green;">**On a schedule**</mark>
   * <mark style="color:green;">Set to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Daily**</mark>
   * <mark style="color:green;">Recur every:</mark> <mark style="color:green;"></mark><mark style="color:green;">**1 day**</mark>
   * <mark style="color:green;">Repeat task every:</mark> <mark style="color:green;"></mark><mark style="color:green;">**5 minutes**</mark> <mark style="color:green;"></mark><mark style="color:green;">for a duration of:</mark> <mark style="color:green;"></mark><mark style="color:green;">**1 day**</mark>
5. In **Actions Tab**:
   * <mark style="color:green;">Action:</mark> <mark style="color:green;"></mark><mark style="color:green;">**Start a program**</mark>
   *   <mark style="color:green;">Program/script:</mark>

       ```
       C:\Scripts\restart_iis_app.bat
       ```
6. In **Conditions Tab** (optional):
   * <mark style="color:green;">Uncheck “Start the task only if the computer is on AC power” if needed.</mark>
7. Click **OK**



***

## What This Does

Every 5 minutes, the batch script will:

* <mark style="color:green;">Use PowerShell to</mark> <mark style="color:green;"></mark><mark style="color:green;">**restart the specific IIS app pool**</mark>
* <mark style="color:green;">Or restart the site using</mark> <mark style="color:green;"></mark><mark style="color:green;">`appcmd`</mark>
* <mark style="color:green;">Keeps the web app refreshed and stable</mark>

## Confirm It Works

* <mark style="color:green;">Right-click the task →</mark> <mark style="color:green;"></mark><mark style="color:green;">**Run**</mark> <mark style="color:green;"></mark><mark style="color:green;">to test it</mark>
* <mark style="color:green;">You can also verify in</mark> <mark style="color:green;"></mark><mark style="color:green;">**Event Viewer → Windows Logs → System**</mark> <mark style="color:green;"></mark><mark style="color:green;">for IIS events</mark>

{% hint style="danger" %}
### Make Sure:

* You’re running Task Scheduler with an account that has **IIS Admin rights**
* PowerShell execution policy allows the script to run (`Set-ExecutionPolicy RemoteSigned`)
{% endhint %}

***

## REFERENCES

* [https://learn.microsoft.com/en-us/sysinternals/downloads/rammap](https://learn.microsoft.com/en-us/sysinternals/downloads/rammap)
* [https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-start-page](https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-start-page)
