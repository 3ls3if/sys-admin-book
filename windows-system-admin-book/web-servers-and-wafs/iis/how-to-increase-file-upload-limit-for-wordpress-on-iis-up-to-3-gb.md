---
icon: folder-arrow-up
---

# How to Increase File Upload Limit for WordPress on IIS (Up to 3 GB)

## How to Increase File Upload Limit for WordPress on IIS (Up to 3 GB)

When hosting WordPress on **IIS (Internet Information Services)**, large file uploads—such as a **2.5 GB backup file**—often fail even if PHP and WordPress limits are set correctly. This happens because **IIS enforces its own upload restrictions**, independent of WordPress.

The good news: on IIS, this issue **is fixable at the server level**.

***

### Why Large Uploads Fail on IIS

By default, IIS limits uploads to around **30 MB**. When you try to upload a large WordPress file, the request is blocked **before PHP or WordPress ever runs**.

#### Where the limit comes from

The restriction exists in multiple IIS-related layers:

* **Request Filtering** (IIS)
* **ASP.NET `maxRequestLength`**
* **`web.config`**
* IIS-level security rules

Because of this, increasing limits in:

* `wp-config.php`
* `php.ini`

**will not work on their own**.

***

### The Correct Way to Fix It on IIS (Works Reliably)

To allow uploads up to **3 GB**, you must update both IIS settings and the site’s `web.config`.

***

### Step 1: Increase IIS Request Size

1. Open **IIS Manager**
2. Select your **website**
3. Open **Request Filtering**
4. Click **Edit Feature Settings…**
5. Set **Maximum allowed content length (Bytes)** to:

```
3221225472
```

(This equals **3 GB**)

6. Click **OK**

***

### Step 2: Update `web.config`

In your site’s root directory, edit or create a file named **`web.config`** and add the following:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.web>
    <!-- 3 GB (value is in KB) -->
    <httpRuntime
      executionTimeout="1800"
      maxRequestLength="3145728" />
  </system.web>

  <system.webServer>
    <security>
      <requestFiltering>
        <!-- 3 GB (value is in BYTES) -->
        <requestLimits maxAllowedContentLength="3221225472" />
      </requestFiltering>
    </security>
  </system.webServer>
</configuration>
```

***

### ⚠️ Important: Units Matter

This is a common source of errors:

* `maxRequestLength` → **Kilobytes (KB)**
* `maxAllowedContentLength` → **Bytes**

Using the wrong unit will cause uploads to fail silently.

***

### Step 3: Restart IIS

Apply the changes by restarting IIS:

#### Option 1: From IIS Manager

* Restart the website or application pool

#### Option 2: Command line (Administrator)

```
iisreset
```

***

### Step 4: Confirm PHP Limits (Recommended)

Make sure PHP limits are equal to or higher than IIS limits:

```
upload_max_filesize = 5120M
post_max_size = 5120M
max_execution_time = 1800
max_input_time = 1800
```

***

### Result

After completing these steps:

* ✅ 2.5 GB WordPress uploads work
* ✅ All-in-One WP Migration uploads succeed
* ✅ No WordPress plugin limitations
* ✅ No need to purchase “Unlimited Upload” extensions

***

### Final Notes

* These changes require **IIS access** (VPS, dedicated server, or admin privileges).
* On shared Windows hosting, the provider may need to apply these settings.
* If a reverse proxy or firewall is in front of IIS, additional limits may apply.
