---
icon: hexagon-exclamation
---

# How to Fix HTTP Error 500.21 and 403.14 in ASP.NET Core on IIS

## How to Fix HTTP Error 500.21 and 403.14 in ASP.NET Core on IIS

Deploying an ASP.NET Core application on IIS can sometimes lead to confusing errors like **500.21 (Bad Module)** or **403.14 (Directory Listing Denied)**. These errors are usually not caused by your application code, but by server configuration issues.

This guide walks through the exact causes and step-by-step solutions based on a real troubleshooting flow.

***

### 🔴 Common Errors You May See

#### 1. HTTP Error 500.21 – Internal Server Error

**Message:**

> Handler "aspNetCore" has a bad module "AspNetCoreModuleV2"

#### 2. HTTP Error 403.14 – Forbidden

**Message:**

> The Web server is configured to not list the contents of this directory

***

### 🧠 Understanding the Problem

ASP.NET Core apps do not run directly inside IIS like classic ASP.NET apps. Instead:

* IIS uses a module called **AspNetCoreModuleV2**
* This module forwards requests to your application (`.dll`)

If this module is missing or misconfigured, IIS cannot run your app.

***

## ✅ Step-by-Step Fix

***

### ✅ Step 1: Install .NET Hosting Bundle

This is the **most important step**.

#### Why?

The hosting bundle installs:

* ASP.NET Core Runtime
* IIS Integration Module (**AspNetCoreModuleV2**)

#### Fix:

1. Download the correct version of the **.NET Hosting Bundle**
2. Install it as Administrator

> ⚠️ Installing only SDK or Runtime is NOT enough

***

### ✅ Step 2: Restart IIS

After installation:

```
iisreset
```

This ensures IIS loads the new module.

***

### ✅ Step 3: Verify Module Installation

Check if the module exists:

#### Option A: File check

```
C:\Program Files\IIS\Asp.Net Core Module\V2\aspnetcorev2.dll
```

#### Option B: IIS Manager

* Open IIS Manager
* Go to **Server → Modules**
*   Look for:

    ```
    AspNetCoreModuleV2
    ```

***

### ❌ If Module Exists but Not Showing

This means the module is **not registered**.

#### Fix (Manual Registration):

Run Command Prompt as Administrator:

```
cd %windir%\system32\inetsrv
appcmd install module /name:AspNetCoreModuleV2 /image:"C:\Program Files\IIS\Asp.Net Core Module\V2\aspnetcorev2.dll"
```

Then:

```
iisreset
```

***

### ✅ Step 4: Restore Correct web.config

Your `web.config` must include the handler:

```xml
<handlers>
  <add name="aspNetCore"
       path="*"
       verb="*"
       modules="AspNetCoreModuleV2"
       resourceType="Unspecified" />
</handlers>

<aspNetCore processPath="dotnet"
            arguments="Hajri.dll"
            stdoutLogEnabled="false"
            stdoutLogFile=".\logs\stdout"
            hostingModel="inprocess" />
```

> ❌ Removing this handler will break your app

***

### ❌ Step 5: Fix 403.14 Error

If you see:

> Directory Listing Denied

#### Cause:

IIS is treating your app like a static folder.

#### Fix:

Make sure you deployed the **publish output**, not source code.

#### Correct folder should contain:

```
Hajri.dll
Hajri.runtimeconfig.json
Hajri.deps.json
web.config
wwwroot/
```

***

### ✅ Step 6: Publish Correctly

Run:

```
dotnet publish -c Release -o publish
```

Upload contents of `/publish` folder to your IIS site directory.

***

### ⚠️ Common Mistakes to Avoid

* ❌ Installing only .NET SDK
* ❌ Removing `AspNetCoreModuleV2` handler
* ❌ Uploading project files instead of publish output
* ❌ Not restarting IIS after installation
* ❌ Installing hosting bundle before IIS

***

### 🔍 Debugging Tips

#### Enable logs temporarily:

```xml
stdoutLogEnabled="true"
```

Create `/logs` folder and give write permission.

Then check:

```
/logs/stdout_*.log
```

***

### 🧠 Summary

| Problem             | Cause            | Fix                         |
| ------------------- | ---------------- | --------------------------- |
| 500.21              | Module missing   | Install Hosting Bundle      |
| Module not visible  | Not registered   | Use `appcmd install module` |
| 403.14              | App not detected | Deploy publish folder       |
| Static file handler | Handler removed  | Restore web.config          |

***

### 🚀 Final Result

Once everything is configured correctly:

* IIS loads `AspNetCoreModuleV2`
* Requests are forwarded to your app
* Your ASP.NET Core application runs successfully

***

### 🎯 Key Takeaway

> If IIS doesn’t recognize `AspNetCoreModuleV2`, your app will never run — no matter how correct your code is.

***

This issue is purely **environment + IIS configuration**, not an application bug.

***
