---
icon: node-js
---

# Running a Node.js Application as a Windows Service Using PM2 + NSSM

## Running a Node.js Application as a Windows Service Using PM2 + NSSM

Combining **PM2** (a powerful Node.js process manager) with **NSSM (Non-Sucking Service Manager)** gives you the best of both worlds:

* PM2 handles process management, clustering, auto-restart, logs
* NSSM ensures your app runs as a native Windows service

This setup is especially useful for production environments where reliability and uptime matter.

***

### Why Use PM2 with NSSM?

While NSSM alone can run your app as a service, it lacks advanced Node.js features. PM2 adds:

* Auto-restart on crash
* Load balancing (cluster mode)
* Log management
* Monitoring tools
* Zero-downtime reloads

NSSM then ensures PM2 itself runs in the background as a Windows service.

***

### Prerequisites

Make sure you have:

* Node.js installed
* A working Node.js project
* NSSM downloaded
* PM2 installed globally

Install PM2 if needed:

```bash
npm install -g pm2
```

***

### Step 1: Test PM2 Manually

Before creating a service, confirm PM2 can run your app:

```bash
cd C:\inetpub\wwwroot\sgmpcollege.com\sgmpcollege.com
pm2 start npm --name sgmpcollege -- start
```

Check status:

```bash
pm2 list
```

Save the process list:

```bash
pm2 save
```

This ensures PM2 remembers your app configuration.

***

### Step 2: Locate PM2 Path

Find where PM2 is installed:

```bash
where pm2
```

Example output:

```
C:\Users\Administrator\AppData\Roaming\npm\pm2.cmd
```

You’ll need this path for NSSM.

***

### Step 3: Open NSSM

Run Command Prompt as Administrator and navigate to NSSM:

```bash
cd C:\Users\Administrator\Downloads\nssm\nssm-2.24\win64
nssm install pm2-service
```

***

### Step 4: Configure NSSM

#### 🔹 Application Tab

**Path:**

```
C:\Windows\System32\cmd.exe
```

**Startup Directory:**

```
C:\inetpub\wwwroot\sgmpcollege.com\sgmpcollege.com
```

**Arguments:**

```
/c "C:\Users\Administrator\AppData\Roaming\npm\pm2.cmd" resurrect
```

#### Why `pm2 resurrect`?

* It restores all previously saved processes (`pm2 save`)
* Ensures your app starts automatically with the service

***

### Step 5: Optional (Recommended Settings)

#### 🔹 I/O Tab (Logs)

Set log files for troubleshooting:

* Output:\
  `C:\logs\pm2-out.log`
* Error:\
  `C:\logs\pm2-error.log`

***

### Step 6: Install and Start Service

Click **Install Service**, then:

```bash
services.msc
```

* Find `pm2-service`
* Start it
* Set Startup Type to **Automatic**

***

### Step 7: Verify Everything

After starting:

* Run `pm2 list` → your app should be running
* Restart the server → app should auto-start
* Check logs if anything fails

***

### Alternative: Start App via Ecosystem File

Instead of `npm start`, you can define a **PM2 ecosystem file**:

#### ecosystem.config.js

```javascript
module.exports = {
  apps: [
    {
      name: "sgmpcollege",
      script: "npm",
      args: "start",
      instances: "max",
      exec_mode: "cluster",
      env: {
        NODE_ENV: "production"
      }
    }
  ]
};
```

Start it:

```bash
pm2 start ecosystem.config.js
pm2 save
```

This is cleaner and more scalable.

***

### Common Issues

#### ❌ PM2 not found

* Use full path to `pm2.cmd`
* Avoid relying on PATH in services

#### ❌ App not starting after reboot

* Ensure `pm2 save` was executed
* Use `pm2 resurrect` in NSSM

#### ❌ Permission issues

* Run NSSM and service as Administrator
* Check service "Log On" tab

***

### Best Practices

* Use PM2 cluster mode for better performance
* Regularly run `pm2 logs` to monitor issues
* Backup your ecosystem config
* Keep Node.js and PM2 updated

***

### Conclusion

Using PM2 with NSSM creates a robust production setup for Node.js on Windows:

* PM2 manages your app intelligently
* NSSM ensures it runs as a system-level service

This combination provides high reliability, automatic recovery, and better scalability compared to running Node.js directly.

***

If you want, I can also guide you on:

* Setting up HTTPS (SSL) with Node.js
* Deploying updates without downtime
* Monitoring PM2 with a dashboard
