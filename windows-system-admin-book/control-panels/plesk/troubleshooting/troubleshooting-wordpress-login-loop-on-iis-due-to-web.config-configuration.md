---
icon: wordpress-simple
---

# Troubleshooting WordPress Login Loop on IIS Due to web.config Configuration

### Overview

When hosting WordPress on IIS, you may encounter a situation where the WordPress admin login page keeps redirecting without showing an error message. Interestingly, the issue disappears if the `web.config` file is renamed or removed.

This indicates that some settings in the `web.config` are interfering with WordPress’ PHP session or authentication handling.

***

### Symptoms

* Attempting to log in to the WordPress admin dashboard redirects back to the login page.
* No error messages are displayed.
* Temporarily renaming or removing `web.config` allows login to succeed.

***

### Cause

The issue is commonly caused by **ASP.NET-specific configurations in `web.config`** that conflict with PHP.

Key culprits include:

* `<modules runAllManagedModulesForAllRequests="true" />`\
  Forces all IIS modules (including ASP.NET) to process every request, even `.php` files.
* `<defaultDocument>` pointing to `Index.aspx` instead of `index.php`.
* `<machineKey>` settings intended for ASP.NET authentication.

These configurations were designed for ASP.NET applications but can interfere with WordPress, which relies on PHP sessions and cookies for authentication.

***

### Solution

#### Step 1: Update the `<modules>` section

In your `web.config`, locate:

```xml
<modules runAllManagedModulesForAllRequests="true" />
```

Replace it with:

```xml
<modules runAllManagedModulesForAllRequests="false" />
```

This prevents ASP.NET modules from hijacking PHP requests.

***

#### Step 2: Correct the default document priority

Ensure that WordPress’ main entry file `index.php` is prioritized. Update the `<defaultDocument>` section:

```xml
<defaultDocument>
  <files>
    <clear />
    <add value="index.php" />
    <add value="Index.aspx" />
  </files>
</defaultDocument>
```

***

#### Step 3: (Optional) Disable `<machineKey>`

If login issues persist, try commenting out or removing the `<machineKey>` section, as it may cause conflicts with PHP session handling.

***

#### Step 4: Test WordPress Admin Login

* Save the updated `web.config`.
* Restart IIS or recycle the application pool.
* Attempt to log in again at `https://yourdomain.com/wp-admin`.

You should now be able to log in without redirect loops.

***

### Preventive Best Practices

* Keep ASP.NET and PHP applications on separate IIS sites when possible.
* Use a **minimal `web.config`** for PHP/WordPress sites, avoiding unnecessary ASP.NET settings.
* Document any changes made for future maintenance.

***

### Conclusion

If WordPress login loops occur on IIS, check for ASP.NET-specific settings in `web.config`. Updating the `<modules>` directive and prioritizing `index.php` typically resolves the issue.

By applying these changes, WordPress authentication functions as expected, and administrators can access the dashboard without interruption.
