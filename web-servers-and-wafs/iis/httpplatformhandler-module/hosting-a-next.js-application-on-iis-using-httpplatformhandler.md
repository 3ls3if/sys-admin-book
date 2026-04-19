---
icon: node-js
---

# Hosting a Next.js Application on IIS Using HttpPlatformHandler

### Introduction

Running Node.js applications on Windows IIS has traditionally been challenging. While tools like iisnode exist, they often struggle with modern frameworks like Next.js. Microsoft's **HttpPlatformHandler** provides an elegant, reliable solution for hosting any Node.js application (including Next.js) on IIS without the headaches of reverse proxies or compatibility issues.

In this guide, I'll walk through hosting a Next.js standalone application on IIS using HttpPlatformHandler, based on a real-world implementation that successfully resolved persistent 502 errors.

### Why HttpPlatformHandler?

HttpPlatformHandler is Microsoft's modern, officially supported solution for hosting non-.NET applications on IIS. Unlike older solutions:

| Feature                      | HttpPlatformHandler | iisnode       | ARR Reverse Proxy |
| ---------------------------- | ------------------- | ------------- | ----------------- |
| Microsoft Support            | ✅ Active            | ❌ Legacy      | ⚠️ Limited        |
| Next.js Compatibility        | ✅ Perfect           | ❌ Problematic | ⚠️ Complex        |
| Automatic Process Management | ✅ Yes               | ✅ Yes         | ❌ No              |
| Crash Recovery               | ✅ Yes               | ✅ Yes         | ❌ No              |
| Setup Complexity             | Low                 | Medium        | High              |

### Prerequisites

Before starting, ensure you have:

* **Windows Server** (2012 R2 or later) or **Windows 10/11** with IIS enabled
* **Node.js** installed (download from [nodejs.org](https://nodejs.org/))
* **IIS** with the following features enabled:
  * IIS Management Console
  * IIS 6 Metabase Compatibility (for some configurations)
* Your **Next.js application** built as a standalone output

### Step 1: Prepare Your Next.js Application for Standalone Output

First, configure Next.js to produce a standalone build. In your `next.config.mjs` or `next.config.js`:

```
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  // other configuration options...
}

export default nextConfig
```

Build your application:

```
npm run build
```

This creates a `.next/standalone` folder containing everything needed to run your app independently.

### Step 2: Modify Your Server Entry Point

If you're using the default Next.js standalone server, add this line at the very top of your server file (usually `server.js`):

```
// Add this at the VERY TOP - before any other code
process.env.PORT = process.env.PORT || process.env.HTTP_PLATFORM_PORT || '3000';

// Rest of your server code follows...
const path = require('path');
// ... your existing code
```

This ensures your app uses the dynamic port provided by HttpPlatformHandler.

### Step 3: Install HttpPlatformHandler on IIS

Download and install HttpPlatformHandler from Microsoft:

**Download URL:** [https://www.iis.net/downloads/microsoft/httpplatformhandler](https://www.iis.net/downloads/microsoft/httpplatformhandler)

After installation, restart IIS:

cmd

```
iisreset
```

Verify installation by opening IIS Manager and checking for **"HTTP Platform Handler"** in the server modules list.

### Step 4: Create the Complete web.config

Place this `web.config` file in your website's root directory (the same folder containing your `server.js`):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.webServer>
        <!-- Remove unnecessary headers -->
        <httpProtocol>
            <customHeaders>
                <remove name="X-Powered-By" />
            </customHeaders>
        </httpProtocol>

        <!-- Handler configuration - path="*" is critical for Next.js assets -->
        <handlers>
            <add name="httpPlatformHandler" 
                 path="*" 
                 verb="*" 
                 modules="httpPlatformHandler" 
                 resourceType="Unspecified" 
                 requireAccess="Script" />
        </handlers>

        <!-- HttpPlatform configuration - manages your Node.js process -->
        <httpPlatform 
            stdoutLogEnabled="true" 
            stdoutLogFile=".\logs\node.log"
            startupTimeLimit="60" 
            startupRetryCount="3"
            processesPerApplication="1"
            requestTimeout="00:02:00"
            processPath="C:\Program Files\nodejs\node.exe" 
            arguments=".\server.js">
            
            <!-- Environment variables passed to your Node.js app -->
            <environmentVariables>
                <environmentVariable name="PORT" value="%HTTP_PLATFORM_PORT%" />
                <environmentVariable name="NODE_ENV" value="production" />
                <environmentVariable name="HOSTNAME" value="0.0.0.0" />
            </environmentVariables>
        </httpPlatform>

        <!-- Disable IIS compression - Next.js handles its own -->
        <urlCompression doStaticCompression="false" doDynamicCompression="false" />
    </system.webServer>
</configuration>
```

#### Configuration Breakdown

| Element                       | Purpose                                                              |
| ----------------------------- | -------------------------------------------------------------------- |
| `<handlers path="*">`         | Routes ALL requests (including static assets) to HttpPlatformHandler |
| `<httpPlatform processPath>`  | Path to your Node.js executable                                      |
| `<httpPlatform arguments>`    | Your application's entry point                                       |
| `startupTimeLimit="60"`       | Gives your app up to 60 seconds to start                             |
| `startupRetryCount="3"`       | Retries 3 times if startup fails                                     |
| `stdoutLogEnabled`            | Creates log files for debugging                                      |
| `PORT="%HTTP_PLATFORM_PORT%"` | Maps IIS's dynamic port to your app's PORT variable                  |

### Step 5: Configure IIS Application Pool

For optimal performance, configure your application pool correctly:

1. Open **IIS Manager**
2. Find your website's **Application Pool**
3. Right-click → **Advanced Settings**
4. Set these values:

| Setting                    | Value                                                             |
| -------------------------- | ----------------------------------------------------------------- |
| .NET CLR Version           | `No Managed Code`                                                 |
| Enable 32-Bit Applications | `False` (unless you have 32-bit Node.js)                          |
| Managed Pipeline Mode      | `Integrated`                                                      |
| Process Model → Identity   | `ApplicationPoolIdentity` (or a specific user with folder access) |
| Idle Time-out (minutes)    | `0` (prevents app pool from shutting down)                        |

### Step 6: Set Folder Permissions

Your application needs write access to create log files:



```
# Run as Administrator
icacls "C:\inetpub\wwwroot\your-app-folder" /grant "IIS AppPool\YourAppPoolName:(OI)(CI)M" /T
```

Also create the logs folder:

```
mkdir C:\inetpub\wwwroot\your-app-folder\logs
```

Replace `your-app-folder` and `YourAppPoolName` with your actual values.

### Step 7: Deploy Your Application

Copy your entire standalone build to the IIS website folder:

```
C:\inetpub\wwwroot\your-app\
├── server.js (or .next/standalone/server.js)
├── web.config
├── logs\
├── .next\
└── public\
```

### Step 8: Test the Setup

1.  **Restart IIS**:



    ```
    iisreset
    ```
2. **Check the log file** at `\logs\node.log` - it should show your app starting successfully
3. **Browse to your website** (e.g., `http://localhost` or your domain)
4. **Verify your app loads** - you should see your Next.js application with no 502 errors

### How HttpPlatformHandler Works (Behind the Scenes)

Understanding the architecture helps with troubleshooting:

```
Browser Request (Port 80)
         ↓
    IIS Listener
         ↓
   HttpPlatformHandler Module
         ↓
   Spawns node.exe process
         ↓
   Assigns dynamic port (e.g., 54321)
         ↓
   Forwards request to http://localhost:54321
         ↓
   Your Next.js App processes request
         ↓
   Response returns through same path
```

HttpPlatformHandler does two critical jobs:

1. **Process Management**: Automatically starts your Node.js app, monitors it, and restarts it if it crashes
2. **Reverse Proxy**: Forwards HTTP requests from IIS to your app on a dynamic port

The magic of `%HTTP_PLATFORM_PORT%` is that HttpPlatformHandler picks an available port, stores it in this environment variable, and your app listens on that exact port - no manual port configuration needed.

### Troubleshooting Common Issues

#### 502.3 Bad Gateway with Error Code 0x8007000d

**Cause**: HttpPlatformHandler not installed or not properly registered

**Solution**: Reinstall HttpPlatformHandler and restart IIS

#### Application Doesn't Start

**Check the log file** at `\logs\node.log`. Common issues include:

* Incorrect Node.js path in `processPath`
* Missing npm modules
* Syntax errors in your code

#### Slow First Request

**Cause**: Node.js app takes time to start

**Solution**: Increase `startupTimeLimit` to `120` or higher

#### Static Assets Not Loading (CSS/JS 404)

**Cause**: Handler path is set to a specific file instead of `*`

**Solution**: Ensure your handler has `path="*"` not `path="server.js"`

### Why This Approach Beats iisnode and ARR

| Issue                     | iisnode/ARR                  | HttpPlatformHandler |
| ------------------------- | ---------------------------- | ------------------- |
| Next.js WebSocket support | Broken                       | Works               |
| Process crashes           | Manual restart needed        | Automatic restart   |
| Configuration complexity  | High (proxy + rewrite rules) | Low (single config) |
| Logging                   | Limited                      | Full stdout logging |
| Microsoft support         | Deprecated                   | Active              |

### Conclusion

HttpPlatformHandler provides a clean, reliable way to host Next.js applications on IIS. Unlike older solutions that require complex reverse proxy configurations or struggle with modern frameworks, HttpPlatformHandler handles process management and request routing automatically.

The complete setup requires just:

1. A properly built Next.js standalone app
2. One line added to your server entry point
3. The `web.config` file provided above
4. The HttpPlatformHandler module installed

Once configured, your Next.js app runs seamlessly on IIS, benefiting from IIS's robust security, SSL management, and multi-site hosting capabilities while performing as if it were running natively.

***

**Related Resources:**

* [HttpPlatformHandler Download](https://www.iis.net/downloads/microsoft/httpplatformhandler)
* [Next.js Standalone Output Documentation](https://nextjs.org/docs/app/api-reference/next-config-js/output)
* [IIS Configuration Reference](https://docs.microsoft.com/en-us/iis/configuration/)
