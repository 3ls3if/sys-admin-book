---
icon: trash
---

# Uninstall windows update

### Method 1: Uninstall a specific Windows update (most common)

1. **Open Settings**
   * Press **Windows + I**
2. Go to:
   * **Windows 11:** `Windows Update` → `Update history`
   * **Windows 10:** `Update & Security` → `Windows Update` → `View update history`
3. Click **Uninstall updates**
4. Find the update (usually labeled **KB######**)
5. Select it → **Uninstall**
6. Restart your PC

✔ Best for removing a buggy or recent update.

***

### Method 2: Uninstall via Control Panel

1. Press **Windows + R**
2. Type `appwiz.cpl` → Enter
3. Click **View installed updates**
4. Select the update → **Uninstall**
5. Restart

***

### Method 3: Uninstall a feature update (major version rollback)

If a **major Windows version upgrade** caused problems:

1. Open **Settings**
2. Go to:
   * **System → Recovery**
3. Under **Recovery options**, select **Go back**

⚠️ This option is only available for **10 days after upgrading**.

***

### Method 4: Uninstall update using Command Prompt (advanced)

1. Open **Command Prompt as Administrator**
2.  Run:

    ```cmd
    wusa /uninstall /kb:1234567
    ```

    (Replace `1234567` with the KB number)
3. Restart when prompted

***

### Prevent the update from reinstalling

#### Pause updates temporarily

* Settings → Windows Update → **Pause updates**

#### Block a specific update (recommended)

* Use Microsoft’s **“Show or hide updates” troubleshooter**
* This prevents Windows from reinstalling a problematic update

***

### Important notes ⚠️

* **Security updates** are sometimes mandatory and may reinstall automatically.
* Removing updates can reduce system security.
* If your PC won’t boot after an update, use **Advanced Startup → Uninstall Updates**.
