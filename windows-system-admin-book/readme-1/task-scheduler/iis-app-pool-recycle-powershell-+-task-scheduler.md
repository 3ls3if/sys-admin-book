---
icon: rocket
---

# IIS App Pool Recycle – PowerShell + Task Scheduler

### 1. PowerShell Script

* File path: `C:\Scripts\RecycleAppPool.ps1`
* Purpose: Recycles the IIS Application Pool `test.example.com`.
*   Script contents:

    ```powershell
    Import-Module WebAdministration
    Restart-WebAppPool -Name "test.example.com"
    ```



### 2. Scheduled Task Setup

#### **Action**

* Executes PowerShell with parameters to run the script silently.

```powershell
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -File C:\Scripts\RecycleAppPool.ps1"
```

#### **Trigger**

* Starts once (1 minute from creation).
* Repeats every **1 minute** for **1 day**.
* Effectively keeps running every minute, renewed daily.

```powershell
$trigger = New-ScheduledTaskTrigger `
    -Once -At (Get-Date).Date.AddMinutes(1) `
    -RepetitionInterval (New-TimeSpan -Minutes 1) `
    -RepetitionDuration (New-TimeSpan -Days 1)
```

#### **Register the Task**

* Task name: `RecycleAppPool_Test`.
* Runs with **highest privileges** under the **SYSTEM** account.

```powershell
Register-ScheduledTask `
    -TaskName "RecycleAppPool_Test" `
    -Action $action `
    -Trigger $trigger `
    -RunLevel Highest `
    -User "SYSTEM"
```



### 3. Notes & Recommendations

* **Frequency**: Current setup recycles the app pool every **1 minute**.\
  ⚠️ This is unusual and may cause performance issues (sessions dropped, caches reset).
*   **Best Practice**: Recycle **once daily during off-peak hours** (e.g., 3 AM).

    ```powershell
    $trigger = New-ScheduledTaskTrigger -Daily -At 03:00AM
    ```
* **Logs/Monitoring**:
  * Check Task Scheduler → Task History to confirm successful execution.
  * IIS logs will show recycle events.



***

## REFERENCES

* [https://www.leansentry.com/guide/reset-restart-recycle-iis](https://www.leansentry.com/guide/reset-restart-recycle-iis)
