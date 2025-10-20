---
icon: user-secret
---

# Detecting Who Executed RuntimeBroker.exe and Enabling Tracking

## Detecting Who Executed `RuntimeBroker.exe` and Enabling Tracking

#### **1. Purpose**

To identify which **user or process** initiated `RuntimeBroker.exe` — especially useful when investigating **unexpected shutdowns or power events** triggered by this process.

***

#### **2. Key Event IDs**

| **Event ID**    | **Log Source** | **Description**                                                                                                                                     |
| --------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1074**        | System         | Logged when a user or process initiates a system shutdown or restart. Includes the initiating process (e.g., `RuntimeBroker.exe`) and user account. |
| **4688**        | Security       | Logged when a new process is created. Identifies **who started RuntimeBroker.exe** and what **parent process** initiated it.                        |
| **6006 / 6008** | System         | General shutdown or unexpected shutdown logs (used for correlation).                                                                                |

***

#### **3. Detecting Who Executed `RuntimeBroker.exe`**

**a. Check for Shutdown Event (Event ID 1074)**

1. Open **Event Viewer** (`eventvwr.msc`).
2. Go to: **Windows Logs → System**.
3. Filter by **Event ID 1074**.
4. Review the **process name**, **user account**, and **shutdown reason**.
   *   Example:

       ```
       The process C:\Windows\System32\RuntimeBroker.exe (DD)
       initiated the power off of computer DD
       on behalf of user DD\Administrator.
       ```

**b. Identify What Triggered RuntimeBroker (Event ID 4688)**

1. In Event Viewer, navigate to: **Windows Logs → Security**.
2. Filter for **Event ID 4688**.
3. Look for events where **New Process Name** = `C:\Windows\System32\RuntimeBroker.exe`.
4. Review:
   * **Subject User Name** → the account that ran it.
   * **Creator Process Name** → the parent process that launched it (e.g., `svchost.exe`, `services.exe`, etc.).

***

#### **4. Enabling Required Audit Policies**

If Event ID 4688 is not appearing, enable process creation auditing:

**a. Via Local Security Policy**

1. Run `secpol.msc`.
2. Navigate to:\
   `Advanced Audit Policy Configuration → System Audit Policies → Detailed Tracking`.
3. Double-click **Audit Process Creation**.
4. Check **Success** and click **OK**.

**b. Via Command Line (PowerShell)**

```powershell
auditpol /set /subcategory:"Process Creation" /success:enable
```

This ensures all new processes (including RuntimeBroker) are logged in the **Security log**.

***

#### **5. Optional: Collect Process Creation Details**

Enable the policy to include **command line arguments** in process creation logs:

1. Run `gpedit.msc`.
2. Navigate to:\
   `Computer Configuration → Administrative Templates → System → Audit Process Creation`.
3. Enable: **Include command line in process creation events**.

This helps identify **what command or task triggered RuntimeBroker.exe**.

***

#### **6. Using PowerShell for Live Detection**

You can quickly see which process launched RuntimeBroker.exe:

```powershell
Get-WmiObject Win32_Process -Filter "Name='RuntimeBroker.exe'" |
Select-Object ProcessId, ParentProcessId, CommandLine,
@{Name="ParentProcess";Expression={(Get-Process -Id $_.ParentProcessId -ErrorAction SilentlyContinue).Path}}
```

This shows:

* Process ID
* Parent process ID
* Command line used
* Full path of parent process

***

#### **7. Optional: Use Sysinternals Process Explorer**

1. Download from Microsoft: https://learn.microsoft.com/sysinternals/downloads/process-explorer
2. Run as Administrator.
3. Find `RuntimeBroker.exe` in the list.
4. Hover or open **Properties → Image tab** to view **Parent Process** and **Command Line**.

***

#### **8. Best Practices**

* Do **not** disable or delete `RuntimeBroker.exe`; it’s required for Windows apps.
* Instead, focus on identifying **which process or task** is using it to perform system actions (e.g., Windows Update, Maintenance tasks, or scripts).
* Regularly review **Event ID 1074 and 4688** entries for abnormal shutdown activity.
* Use **Task Scheduler** to check for any scripts or update tasks that could indirectly trigger a shutdown.

***

#### **Summary**

| **Goal**                     | **Action**                                                  |
| ---------------------------- | ----------------------------------------------------------- |
| Detect who ran RuntimeBroker | Check **Event ID 1074 (System)** and **4688 (Security)**    |
| Enable tracking              | Enable **Audit Process Creation** (Success)                 |
| View parent process          | Use PowerShell or Process Explorer                          |
| Ongoing monitoring           | Correlate 1074 + 4688 + 6006/6008 for full shutdown context |
