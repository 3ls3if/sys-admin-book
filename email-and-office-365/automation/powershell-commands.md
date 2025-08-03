---
icon: rectangle-terminal
---

# Powershell Commands

## PowerShell Essentials – Notes

```
Get-Service
EXPLANATION: Lists all services on the local computer along with their statuses.

Start-Service -Name winrm
EXPLANATION: Starts the Windows Remote Management (WinRM) service.

Stop-Service -Name winrm
EXPLANATION: Stops the WinRM service.

Get-Service -ComputerName CLIENT10
EXPLANATION: Retrieves the list of services from a remote computer named CLIENT10.

Enter-PSSession -ComputerName CLIENT10
EXPLANATION: Starts an interactive PowerShell session with the remote computer CLIENT10 using WinRM.

Get-Process
EXPLANATION: Displays a list of all currently running processes on the local machine.

Get-Process -ComputerName CLIENT10,CLIENT11,CLIENT12 | Out-File c:\clientprocesses.txt
EXPLANATION: Gets the running processes from three remote computers and saves the output to a text file.

Get-Command
EXPLANATION: Lists all available cmdlets, functions, workflows, aliases, and external commands.

Get-Command -Verb Get
EXPLANATION: Shows all commands that use the verb "Get" (e.g., Get-Process, Get-Service).

Get-Command -Noun net
EXPLANATION: Shows all commands that use "net" as the noun (e.g., Get-NetIPConfiguration).

Get-Command -Noun net*
EXPLANATION: It shows commands with nouns starting with "net".

*Get-Command -Noun net
EXPLANATION: Lists commands whose noun ends with "net".

Get-Command -Noun net
EXPLANATION: Lists commands whose noun contains the word "net" anywhere.

Get-Command -Verb Remove -Noun net
EXPLANATION: Displays all commands that use the verb "Remove" and whose noun contains "net".

Get-Help Get-Eventlog
EXPLANATION: Shows help documentation for the Get-EventLog command.

Get-EventLog -LogName Security -Newest 10
EXPLANATION: Retrieves the 10 most recent entries from the Security event log.

Get-EventLog -LogName Security -Newest 10 | Format-List
EXPLANATION: Same as above but formats the output as a list for easier readability.

Get-EventLog -LogName Security -Newest 10 | Format-List | Out-File c:\security_log.txt
EXPLANATION: Formats the 10 most recent Security log entries as a list and saves them to a text file.

$computername = CLIENT10
EXPLANATION: Stores the name "CLIENT10" in the variable $computername.

Get-EventLog -LogName Security -ComputerName CLIENT10 -Newest 10 | Format-List | Out-File c:\security_log.txt
EXPLANATION: Fetches the latest 10 security log entries from CLIENT10, formats as a list, and saves to a file.

$num1 = 1
EXPLANATION: Assigns the value 1 to the variable $num1.
$num2 = 2
EXPLANATION: Assigns the value 2 to the variable $num2.

$num1 + $num2
EXPLANATION: Adds the two variables and returns the result (3).

Get-ExecutionPolicy
EXPLANATION: Displays the current script execution policy for PowerShell.

Set-ExecutionPolicy -ExecutionPolicy Bypass
EXPLANATION: Temporarily disables script execution restrictions, allowing all scripts to run (use with caution).
```
