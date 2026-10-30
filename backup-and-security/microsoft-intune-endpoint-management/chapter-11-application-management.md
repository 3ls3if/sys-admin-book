# Chapter 11 - Application Management

This chapter covers application delivery and lifecycle management for Windows devices managed by Microsoft Intune.

## Objectives

* Understand app deployment architecture.
* Deploy Win32, Microsoft Store (new), and Microsoft 365 Apps.
* Configure install/uninstall commands, requirements, detection, and assignments.
* Manage dependencies, supersedence, updates, monitoring, and rollback.

## Prerequisites and licensing

Use an appropriately licensed Intune tenant, supported enrolled Windows 10/11 test device, Entra ID test groups for users/devices/pilot, Windows packaging workstation, Win32 Content Prep Tool, legitimate installer, and vendor licenses. Microsoft 365 Apps requires an eligible Apps license for activation.

## Architecture

Intune stores app metadata, packages, assignments, and status. Windows receives management policy; the Intune Management Extension processes supported Win32 workloads. The installer executes in the configured context and detection rules determine installed state. Company Portal exposes apps assigned as Available.

## Assignment intents

* Required: Intune automatically attempts installation.
* Available for enrolled devices: user can install from Company Portal.
* Uninstall: Intune attempts removal.

## Naming examples

APP-11-WIN-ContosoApp; APP-11-WIN-StoreApp; APP-11-WIN-Microsoft365.

## Safety

Use a pilot group and disposable test device. Validate silent install, detection, uninstall, licensing, and upgrade behavior before broad deployment. Do not commit installers, product keys, credentials, or proprietary application files.

## Lab pages

Continue with Win32, Microsoft Store, Microsoft 365 Apps, dependencies/supersedence, inventory, and troubleshooting pages below.

## References

[Add apps to Intune](https://learn.microsoft.com/en-us/intune/app-management/deployment/) · [Win32 app management](https://learn.microsoft.com/en-us/intune/intune-service/apps/apps-win32-app-management) · [Win32 Content Prep Tool](https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool) · [Microsoft 365 Apps](https://learn.microsoft.com/en-us/intune/intune-service/apps/apps-add-office365)
