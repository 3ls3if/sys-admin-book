---
icon: node-js
---

# Creating a Windows Service for a Node.js Project Using NSSM

## Creating a Windows Service for a Node.js Project Using NSSM

Running a Node.js application as a background service on Windows is a common requirement for production environments. One of the simplest and most reliable ways to achieve this is by using **NSSM (Non-Sucking Service Manager)**. It allows you to wrap your Node.js app (or any script) into a Windows service without modifying your code.

This guide walks you through setting up a Node.js project as a Windows service using NSSM, including best practices and common pitfalls.

***

### Why Use NSSM?

By default, Node.js applications run in a terminal session. This creates several limitations:

* The app stops when the terminal is closed
* No automatic restart on crash
* No integration with Windows Service Manager

NSSM solves these problems by:

* Running your app in the background
* Automatically restarting it if it crashes
* Allowing control via Services (start/stop/restart)
* Logging output for debugging

***

### Prerequisites

Before starting, make sure you have:

* Node.js installed
* A working Node.js project (with `npm start` configured)
* NSSM downloaded and extracted

***

### Step 1: Open Command Prompt as Administrator

Administrative privileges are required to create Windows services.

Navigate to your NSSM installation directory:

```
cd C:\Users\Administrator\Downloads\nssm\nssm-2.24\win64
```

***

### Step 2: Launch NSSM Interface

Run the following command to open the NSSM GUI:

```
nssm install sgmpcollege
```

Here, `sgmpcollege` is the name of your service. You can replace it with any meaningful name.

***

### Step 3: Configure the Service

#### 🔹 Application Tab

Fill in the fields as follows:

**Path:**

```
C:\Windows\System32\cmd.exe
```

**Startup Directory:**

```
C:\inetpub\wwwroot\domain.com\domain.com
```

**Arguments:**

```
/c "C:\Program Files\nodejs\npm.cmd" start
```

#### Why Use `cmd.exe`?

Instead of directly running Node or npm, we use `cmd.exe` with `/c` to execute the command. This ensures:

* Proper handling of paths with spaces (like "Program Files")
* Compatibility with npm scripts
* Better reliability in Windows environments

***

### Step 4: Configure Optional Settings

#### 🔹 Details Tab

* Set Display Name (user-friendly name)
* Add description for clarity

#### 🔹 I/O Tab (Recommended)

You can log output for debugging:

* **Output (stdout):**\
  `C:\logs\sgmpcollege-out.log`
* **Error (stderr):**\
  `C:\logs\sgmpcollege-error.log`

#### 🔹 Shutdown Tab

* Choose "Graceful shutdown" if your app supports it

***

### Step 5: Install the Service

Click **Install Service** in the NSSM window.

If successful, you should see a confirmation message.

***

### Step 6: Start the Service

Open Services Manager:

```
services.msc
```

Find your service (`sgmpcollege`), then:

* Click **Start**
* Set Startup Type to **Automatic** (recommended)

***

### Step 7: Verify It’s Working

Check:

* Your application is accessible (via browser/API)
* Logs are being written (if configured)
* Service remains running after reboot

***

### Common Issues & Fixes

#### ❌ Service starts then stops immediately

* Check log files for errors
* Ensure `npm start` works manually

#### ❌ Path issues with Node/npm

* Always use full absolute paths
* Wrap paths with spaces in quotes

#### ❌ Environment variables not loaded

* Define them in NSSM under the **Environment** tab
* Or use a `.env` loader in your app

***

### Best Practices

* Use a process manager like PM2 in combination if needed for clustering
* Keep logs rotated to avoid disk issues
* Use environment-specific configs (development vs production)
* Monitor service health periodically

***

### Conclusion

Using NSSM is one of the easiest ways to turn a Node.js application into a reliable Windows service. It requires minimal setup and works seamlessly with existing npm scripts.

With proper configuration, your Node.js app can run continuously, restart automatically, and integrate cleanly with the Windows ecosystem.

***

If you want, I can also show how to:

* Run Node directly (without npm)
* Use PM2 with NSSM
* Auto-deploy updates without stopping the service
