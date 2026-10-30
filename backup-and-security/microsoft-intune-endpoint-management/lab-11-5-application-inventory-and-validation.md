# Lab 11.5 - Application Inventory and Validation

## Objective

Collect basic installed application inventory and compare it with Intune deployment results.

## PowerShell inventory

Run elevated PowerShell and query these uninstall registry locations:

* HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*
* HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*
* HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*

Use Get-ItemProperty, filter entries with DisplayName, select DisplayName, DisplayVersion, Publisher, InstallDate, and InstallLocation, then export the result with Export-Csv to a protected lab report folder.

This is a basic registry inventory, not a complete inventory of every Store, portable, or per-user application.

## Validation

Compare installed app name/version with Intune assignment and device status. Confirm install behavior and detection rule. Check IME service/logs for Win32 apps. Record version, OS build, timestamp, and sanitized result.

## Troubleshooting

For Win32 apps, inspect C:\ProgramData\Microsoft\IntuneManagementExtension\Logs. Common logs include IntuneManagementExtension.log, AppWorkload.log, and AgentExecutor.log; availability varies by workload/version.

## Security

Do not export or commit sensitive production inventory without approval. Redact usernames, device identifiers, and internal software details as required.

## Exercise

Export inventory from the test device and reconcile one deployed app with its Intune status.
