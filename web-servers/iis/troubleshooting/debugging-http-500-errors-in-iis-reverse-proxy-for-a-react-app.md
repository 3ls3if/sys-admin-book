---
icon: u-turn-up-left
---

# Debugging HTTP 500 Errors in IIS Reverse Proxy for a React App

## Debugging HTTP 500 Errors in IIS Reverse Proxy for a React App

Setting up a React application behind IIS using a reverse proxy can seem straightforward—until you hit a frustrating **HTTP 500 error**. This article walks through a real-world debugging process, highlighting common pitfalls and the exact fixes that resolve them.

***

### 🚧 The Problem

After configuring IIS as a reverse proxy for a React frontend, accessing the domain resulted in:

```
HTTP ERROR 500
```

However, the React app itself was running perfectly:

```
http://localhost:3000
```

This immediately tells us something critical:

> The issue is not with React — it’s with IIS or the reverse proxy configuration.

***

### 🔍 Step 1: Confirm React is Working

Running the app via:

```
npm start
```

And accessing:

```
http://localhost:3000/login
```

worked fine.

Even though the console showed warnings like:

```
React Hook useEffect has a missing dependency
```

these are **ESLint warnings**, not runtime errors. They do not cause HTTP 500 issues.

***

### ⚙️ Step 2: Inspect IIS Configuration

Initial `web.config` looked like this:

```
<rule name="ReverseProxyInboundRule1" stopProcessing="true">
  <match url="(.*)" />
  <action type="Rewrite" url="http://localhost:3000/{R:1}" />
</rule>
```

This is mostly correct—but a few subtle issues can break everything.

***

### ❌ Common Mistakes Identified

#### 1. Using `localhost` Instead of `127.0.0.1`

IIS sometimes fails to resolve `localhost` properly when proxying.

✅ Fix:

```
url="http://127.0.0.1:3000/{R:1}"
```

***

#### 2. React Dev Server Not Exposed

By default, React binds to `localhost`, meaning IIS cannot access it.

✅ Fix:

```
set HOST=0.0.0.0
npm start
```

***

#### 3. Missing ARR Proxy Enablement

IIS requires **Application Request Routing (ARR)** to be enabled.

Steps:

* Open IIS Manager
* Go to **Application Request Routing Cache**
* Click **Server Proxy Settings**
*   Enable:

    ```
    Enable Proxy ✔️
    ```

***

#### 4. Overcomplicated Outbound Rules

The original config included outbound rules rewriting URLs:

```
<outboundRules>
  ...
</outboundRules>
```

These often:

* Cause rewrite loops
* Break responses
* Trigger HTTP 500 errors

✅ Fix: Remove them entirely for React dev setups.

***

### 💥 Step 3: A New Error Appears (500.50)

After adding proxy headers, IIS returned:

```
HTTP Error 500.50 - URL Rewrite Module Error
The server variable "HTTP_X_FORWARDED_PROTO" is not allowed to be set
```

#### Root Cause:

IIS blocks setting certain server variables unless explicitly allowed.

***

### ✅ Fix Options

#### ✔️ Option 1 (Recommended)

Remove the `serverVariables` section:

```
<action type="Rewrite" url="http://127.0.0.1:3000/{R:1}" />
```

***

#### ✔️ Option 2 (Advanced)

Allow the variable in IIS:

* Go to **URL Rewrite**
* Click **View Server Variables**
*   Add:

    ```
    HTTP_X_FORWARDED_PROTO
    ```

***

### 🧪 Final Working Configuration

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
    <rewrite>
      <rules>
        <rule name="ReactProxy" stopProcessing="true">
          <match url="(.*)" />
          <action type="Rewrite" url="http://127.0.0.1:3000/{R:1}" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
</configuration>
```

***

### ⚠️ Important Architecture Decision

During debugging, another issue surfaced:

```
Physical Path: ...\frontend\build
```

This means IIS was pointing to a **production build**, while also trying to reverse proxy to a **development server**.

👉 This is a bad mix.

***

### 🧠 Choose One Approach Only

#### ✔️ Option A (Production – Recommended)

*   Run:

    ```
    npm run build
    ```
* Serve `/build` directly via IIS
* No proxy needed

***

#### ✔️ Option B (Development)

*   Use:

    ```
    npm start
    ```
* Reverse proxy via IIS to port 3000

***

### 🚀 Key Takeaways

* HTTP 500 in this setup is almost always **IIS-related**, not React
* React warnings do not cause server errors
* Use `127.0.0.1` instead of `localhost` in proxy rules
* Always enable ARR proxy
* Avoid unnecessary outbound rewrite rules
* Don’t mix production build and dev server setups
* IIS error codes like **500.50** are extremely helpful—read them carefully

***

### 🎯 Final Thought

Debugging IIS reverse proxy issues can feel opaque, but once you isolate the layers (React vs IIS), the problem becomes much clearer. Most errors come down to configuration—not code.

***

If you follow the steps above, you’ll go from a vague **HTTP 500 error** to a fully working setup with confidence.
