---
icon: clock
---

# How to Change Date Format (Windows Server 2012 / 2016 / 2019 / 2022)

### **Method 1 — Using Control Panel (GUI)**

1. Open **Control Panel**
2. Go to **Clock and Region**
3. Click **Region**
4. In the **Formats** tab:
   * Change **Short date** to:\
     **MM/dd/yyyy**
   * Change **Long date** to your preferred format.
5. Click **Apply** → **OK**

***

### **Method 2 — Using Settings (Windows Server 2019/2022)**

1. Open **Settings**
2. Go to **Time & Language**
3. Select **Region**
4. Under **Regional format**, click **Change data formats**
5. Update **Short date** to:\
   **MM/dd/yyyy**

***

### **Method 3 — Using PowerShell**

If you want to change it programmatically:

```powershell
Set-Culture en-US
```

Or change only the date format:

```powershell
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -Value "MM/dd/yyyy"
```

Then restart Explorer:

```powershell
Stop-Process -Name explorer -Force
```

***

## **Important Notes**

* Changing date format applies **per user account**, not system-wide.\
  Each user may need to log in and set the same format.
* Some applications read **regional settings** only at startup — they must be restarted.
* If the server is domain-joined, **Group Policy** may override these settings.
