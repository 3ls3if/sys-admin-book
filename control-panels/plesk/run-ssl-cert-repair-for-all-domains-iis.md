---
icon: hammer-brush
---

# Run SSL cert repair for ALL domains (IIS)

### Run SSL cert repair for ALL domains (IIS)

#### 🔹 Step 1: Open elevated Command Prompt

**Very important** — run as **Administrator**.

```cmd
cd "%plesk_bin%"
```

***

#### 🔹 Step 2: Run the global SSL repair

This will:

* Fix broken / missing SSL bindings
* Re-apply correct certs
* Recreate IIS HTTPS bindings with SNI

```cmd
plesk repair web -sslcerts
```

👉 **No domain flag = ALL domains**

***

### Optional (but highly recommended) add-ons

#### 🔹 Repair web config + bindings fully

If things are really messy:

```cmd
plesk repair web -sslcerts -y
```

***

### Target a single domain (for reference)

If you ever want just one domain:

```cmd
plesk repair web -sslcerts example.com
```

***

### After it finishes ✅

Always do this:

```cmd
iisreset
```

Then spot-check:

* IIS → Site → Bindings → HTTPS
* Hostname set
* SNI enabled
* Correct cert assigned

***

### Common gotchas ⚠️

* Broken bindings caused by **manual IIS edits**
* Server domain HTTPS binding without hostname
* Old wildcard cert assigned globally
* Let’s Encrypt cert renewal failed silently

***

### Quick verification (recommended)

```cmd
plesk bin domain --list
```

Then test a few:

```cmd
openssl s_client -connect domain.com:443 -servername domain.com
```
