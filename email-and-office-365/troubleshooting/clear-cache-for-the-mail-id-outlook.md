---
icon: windows
---

# Clear cache for the mail id  (Outlook)

### **For Outlook Desktop (MSI or Microsoft 365 version)**

#### Step 1: Close Outlook completely

Before running any command, make sure Outlook is fully closed.

You can do this from CMD:

```cmd
taskkill /IM outlook.exe /F
```

***

#### Step 2: Locate and delete the OST cache file

Each Outlook account (like `info@lead2money.com`) has a corresponding OST file in:

```
%LOCALAPPDATA%\Microsoft\Outlook\
```

To delete the cache for just that account:

```cmd
del "%LOCALAPPDATA%\Microsoft\Outlook\info@lead2money.com.ost"
```

Or if the filename has a GUID (common in M365), you can delete all OST files to rebuild cleanly:

```cmd
del "%LOCALAPPDATA%\Microsoft\Outlook\*.ost"
```

> 💡Outlook will automatically recreate the OST file when you reopen it — no data loss, since emails are stored on the server.

***

#### Step 3: Clear additional Outlook cache folders

You can also clear cached temp files Outlook uses:

```cmd
rd /s /q "%LOCALAPPDATA%\Microsoft\Outlook"
rd /s /q "%APPDATA%\Microsoft\Outlook"
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\Content.Outlook"
```

> ⚠️ These remove cached attachments and temporary data — safe to delete, but they’ll rebuild.

***

#### Step 4: Restart Outlook

Once done, reopen Outlook:

```cmd
start outlook.exe
```

Outlook will rebuild its local cache for `info@lead2money.com`.

***

### **Optional: Run All Commands at Once**

You can run this batch in an **elevated CMD** (Run as Administrator):

```cmd
taskkill /IM outlook.exe /F
del "%LOCALAPPDATA%\Microsoft\Outlook\info@lead2money.com.ost"
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\Content.Outlook"
start outlook.exe
```

***

### Notes

* This only works for cached (OST) accounts — Exchange, Microsoft 365, or IMAP.
* If your account is **POP3**, Outlook uses a **PST file**, which you shouldn’t delete (that’s your actual data).
* Always confirm the email account’s data file path in **File → Account Settings → Data Files** before deletion.
