---
icon: code
---

# How to export and import scheduled tasks using PowerShell

### Exporting tasks with PowerShell <a href="#exporting-tasks-with-powershell-3" id="exporting-tasks-with-powershell-3"></a>

To export a scheduled task with PowerShell, use these steps:

1. Open **Start**.
2. Search for **PowerShell**, right-click the top result, and select the **Run as administrator** option.
3. Type the following command to export a scheduled task and press **Enter**: <mark style="color:$success;">Export-ScheduledTask -TaskName "TASK-NAME" -TaskPath "\TASK-PATH-TASKSCHEDULER\\" | out-file C:\PATH\TO\EXPORT-FOLDER\TASK-EXPORT-NAME.xml</mark> In the command, make sure to update the command ("TASK-NAME," "\TASK-PATH-TASKSCHEDULER\\," "C:\PATH\TO\EXPORT-FOLDER\TASK-EXPORT-NAME.xml") with your device details.

<figure><img src="https://cdn.mos.cms.futurecdn.net/PKUpJgFrYFYtoDnBdcoBXb.jpg" alt=""><figcaption></figcaption></figure>

Once you complete these steps, the task will export into a file using a .xml extension, which you can then use to import the same task on the same or another computer or installation.

\


***

### Importing tasks with PowerShell <a href="#importing-tasks-with-powershell-3" id="importing-tasks-with-powershell-3"></a>

Although there is an "Export" cmdlet, you won't find an "Import" cmdlet variant using PowerShell. Instead, you'll need to register a new task that will import the same settings included in the exported .xml file.

To import a task with PowerShell, use these steps:

1. Open **Start**.
2. Search for **PowerShell**, right-click the top result, and select the **Run as administrator** option.
3. Type the following command to import a scheduled task and press **Enter**: <mark style="color:$success;">Register-ScheduledTask -xml (Get-Content 'C:\PATH\TO\IMPORTED-FOLDER-PATH\TASK-INPORT-NAME.xml' | Out-String) -TaskName "TASK-IMPORT-NAME" -TaskPath "\TASK-PATH-TASKSCHEDULER\\" -User COMPUTER-NAME\USER-NAME –Force</mark> In the command make sure to update the command ("C:\PATH\TO\IMPORTED-FOLDER-PATH\TASK-INPORT-NAME.xml," "TASK-IMPORT-NAME," "\TASK-PATH-TASKSCHEDULER\\," "COMPUTER-NAME\USER-NAME") with your device details.**Quick tip:** If the command fails or you don't want to enter the password manually, make sure to append the `-Password ACCOUNT-PASSWORD` (replacing "ACCOUNT-PASSWORD" with your actual password) after specifying the "COMPUTER-NAME\USER-NAME" parameters.

<figure><img src="https://cdn.mos.cms.futurecdn.net/StMNKzxC4sDguhFEgBHYcY.jpg" alt=""><figcaption></figcaption></figure>

After completing these steps, the exported scheduled task will be imported to the location you specified in Task Scheduler.

\


***

## REFERENCES

* [https://www.windowscentral.com/how-export-and-import-scheduled-tasks-windows-10](https://www.windowscentral.com/how-export-and-import-scheduled-tasks-windows-10)
