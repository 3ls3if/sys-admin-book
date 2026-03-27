---
icon: triangle-exclamation
---

# Troubleshooting IIS HTTP Error 503 Due to Missing or Corrupted DLL Files

## Troubleshooting IIS HTTP Error 503 Due to Missing or Corrupted DLL Files

### Overview

**Service Unavailable – HTTP Error 503** is a common IIS error that occurs when an **Application Pool stops automatically**. One of the most frequent root causes is **missing or corrupted IIS module DLL files**. When IIS fails to load a required DLL, it terminates the worker process, resulting in a 503 error.

This document explains **how to systematically troubleshoot and resolve IIS 503 errors caused by corrupted or missing DLL files**, using two real-world case studies:

* `caches.dll` (Output Caching Module)
* `defreq.dll` (Request Filtering / Default Requests Module)

> ⚠️ **Important:** The same methodology applies to **any other IIS module DLL** that becomes corrupted or goes missing.

***

### How to Identify the Root Cause

Always start by checking the **Event Viewer**:

1. Open **Event Viewer**
2. Navigate to **Windows Logs → Application**
3. Look for IIS-related errors

Typical error message:

```
The Module DLL C:\Windows\System32\inetsrv\<dll_name>.dll failed to load. The data is the error.
```

This confirms IIS is attempting to load a module whose DLL is missing, corrupted, or inaccessible.

***

## Case Study 1: caches.dll Corruption

#### Error Observed

```
The Module DLL C:\Windows\System32\inetsrv\caches.dll failed to load. The data is the error.
```

This DLL belongs to the **Output Caching Module** in IIS.

***

### Step 1 — Verify if `caches.dll` Exists

1. Open **File Explorer**
2.  Navigate to:

    ```
    C:\Windows\System32\inetsrv\
    ```
3. Confirm whether **caches.dll** is present

* ❌ If missing → IIS cannot start the module
* ✅ If present → Continue with permission and repair checks

***

### Step 2 — Check File Permissions

Even if the file exists, IIS may fail to load it due to incorrect permissions.

1. Right-click **caches.dll** → **Properties**
2. Open the **Security** tab
3. Ensure the following accounts have **Read & Execute** permission:

* IIS\_IUSRS
* IUSR
* NETWORK SERVICE
* Administrators

Apply changes if required.

***

### Step 3 — Re-register IIS Modules

Open **Command Prompt (Run as Administrator)** and execute:

```
dism /online /enable-feature /featurename:IIS-WebServerRole /all
dism /online /enable-feature /featurename:IIS-WebServerManagementTools /all
```

Then restart IIS:

```
iisreset
```

This re-enables and re-registers IIS core components.

***

### Step 4 — Repair Corrupted System Files

If the DLL exists but is corrupted, repair it using system tools.

Run (Admin Command Prompt):

```
sfc /scannow
```

After completion, run:

```
DISM /Online /Cleanup-Image /RestoreHealth
```

Restart IIS once completed.

***

## Case Study 2: defreq.dll Corruption

#### Error Observed

```
The Module DLL C:\Windows\System32\inetsrv\defreq.dll failed to load. The data is the error.
```

This DLL belongs to **Request Filtering / Default Requests Module**.

First, follow **all steps from Case Study 1**. If the issue persists, proceed with the advanced steps below.

***

### Step 1 — Open IIS Configuration File

Open the IIS server-level configuration file:

```
C:\Windows\System32\inetsrv\config\applicationhost.config
```

Use **Notepad (Run as Administrator)**.

***

### Step 2 — Locate Request Filtering Module References

Press **Ctrl + F** and search for:

* `defreq.dll`
* `RequestFilteringModule`

You may find entries like:

```xml
<add name="RequestFilteringModule" image="%windir%\System32\inetsrv\defreq.dll" />
```

***

### Step 3 — Comment Out the Broken Module

Use XML comment syntax to disable the module:

```xml
<!-- <add name="RequestFilteringModule" image="%windir%\System32\inetsrv\defreq.dll" /> -->
```

If the module appears multiple times (for example under `globalModules`, `modules`, or handlers), **comment out every occurrence**.

Example:

```xml
<!--
<add name="RequestFilteringModule" image="%windir%\System32\inetsrv\defreq.dll" />
-->
```

***

### Step 4 — Comment All Related References

Ensure **every reference** to the following is commented out:

* `defreq.dll`
* `DefaultRequestsModule`
* `RequestFilteringModule`
* `RequestFiltering`

Save the file.

***

### Step 5 — Restart IIS

Run:

```
iisreset
```

IIS should now start successfully without throwing HTTP 503 or 500 errors.

***

## Important Notes

* Commenting out a module is a **temporary workaround** that allows IIS to run
* Security features related to the disabled module may not function until the DLL is restored
* This approach is safe for troubleshooting and service restoration

***

## Applies to Other DLL Corruption Issues

The same troubleshooting process applies if **any other IIS module DLL** becomes corrupted or missing, such as:

* `rewrite.dll`
* `aspnetcore.dll`
* `static.dll`
* `caches.dll`
* `defreq.dll`

**Key principle:**

> If IIS cannot load a module DLL, identify it via Event Viewer, repair or disable the reference, and restart IIS.

***

### Summary Checklist

✔️ Check Event Viewer for the failing DLL name\
✔️ Verify DLL exists in `inetsrv` directory\
✔️ Check file permissions\
✔️ Run `sfc /scannow` and `DISM /RestoreHealth`\
✔️ Disable broken module references in `applicationhost.config` if needed\
✔️ Restart IIS

Following this guide will resolve most **HTTP 503 Service Unavailable** errors caused by corrupted or missing IIS DLL files.
