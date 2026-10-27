---
icon: node-js
---

# Node-windows Library

{% hint style="warning" %}
To run a **Node.js application as a Windows service**, you can use a tool like **`nssm` (Non-Sucking Service Manager)** or **`node-windows`** (a Node.js library). Both are great, but here's how you can do it **step-by-step** using Node.js library methods:
{% endhint %}

## Using `node-windows` (JavaScript approach)

### Step 1: Install `node-windows`&#x20;

Inside your project:

```bash
npm install -g node-windows
```

Or locally:

```bash
npm install node-windows
```

### Step 2: Create a Service Script (e.g., `service.js`)

```javascript
const Service = require('node-windows').Service;

// Create a new service object
const svc = new Service({
  name: 'My Node App',
  description: 'Node.js App running as a service',
  script: 'C:\\myapp\\app.js',
  nodeOptions: [
    '--harmony',
    '--max_old_space_size=4096'
  ]
});

// Listen for the "install" event
svc.on('install', () => {
  console.log('Service installed');
  svc.start();
});

svc.install();

```

### Step 3: Run the Script to Install the Service

```
node service.js
```

### Step 4: Check Services

You can now manage the service from:

* `services.msc`
* `net start "My Node App"` / `net stop "My Node App"`
