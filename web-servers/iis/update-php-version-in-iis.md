---
icon: php
---

# Update PHP Version in IIS

## <mark style="color:red;">**Step 1: Check the Current PHP Version**</mark>

1. Open a **Command Prompt** and run:

```cmd
php -v
```



2. Alternatively, create a `phpinfo.php` file in the web root (`C:\inetpub\wwwroot\`):

```php
<?php phpinfo(); ?>
```

Access it via `http://localhost/phpinfo.php` in your browser.



## <mark style="color:red;">**Step 2: Download the Latest PHP Version**</mark>

1. Go to the official **PHP for Windows** site:\
   🔗 [https://windows.php.net/download](https://windows.php.net/download)



2. Download the latest **Non-Thread Safe (NTS) x64** ZIP file (for IIS).



## <mark style="color:red;">**Step 3: Backup the Existing PHP Installation**</mark>

1. Navigate to your current PHP installation directory (e.g., `C:\PHP` or `C:\Program Files\PHP`).
2. Create a backup by copying the folder to a safe location.



## <mark style="color:red;">**Step 4: Extract and Configure PHP**</mark>

1. Extract the downloaded ZIP file to a new directory, e.g., `C:\PHP8`.
2. Copy the `php.ini-development` file and rename it to `php.ini`.
3. Open `php.ini` and configure necessary settings like `extension_dir`:

```ini
iniCopyEditextension_dir = "C:\PHP8\ext"
```



4. Update any required extensions by uncommenting lines (remove `;`):

```ini
iniCopyEditextension=curl
extension=gd
extension=mbstring
extension=mysqli
```



## <mark style="color:red;">**Step 5: Update IIS to Use the New PHP Version**</mark>

<mark style="color:blue;">**Option 1: Update in IIS Manager**</mark>

1. Open **IIS Manager** (`inetmgr`).
2. Go to **Handler Mappings**.
3. Find `*.php`, and double-click it.
4. Change the **Executable Path** to the new PHP location (`C:\PHP8\php-cgi.exe`).
5. Click **OK**, then restart IIS.



<mark style="color:blue;">**Option 2: Update FastCGI in**</mark><mark style="color:blue;">**&#x20;**</mark><mark style="color:blue;">**`fcgi`**</mark><mark style="color:blue;">**&#x20;**</mark><mark style="color:blue;">**Settings**</mark>

1. Open **Command Prompt** as Administrator.
2. Run the following command to update FastCGI settings:

```cmd
C:\Windows\System32\inetsrv\appcmd set config /section:system.webServer/fastCgi /+[fullPath='C:\PHP8\php-cgi.exe']
```



## <mark style="color:red;">**Step 6: Update System PATH Variable**</mark>

1. Open **System Properties** → **Advanced** → **Environment Variables**.
2. In **System Variables**, find **Path** and edit it.
3. Replace the old PHP path with the new one (`C:\PHP8`).
4. Click **OK** and restart the server.



## <mark style="color:red;">**Step 7: Restart IIS and Verify**</mark>

1. Restart IIS:

```cmd
iisreset
```

2. Run:

```cmd
php -v
```

Or refresh `http://localhost/phpinfo.php` to confirm the new version.

