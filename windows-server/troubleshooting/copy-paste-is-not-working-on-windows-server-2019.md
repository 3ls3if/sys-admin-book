---
icon: paste
---

# Copy-Paste is not working on windows server 2019

Copy-paste not working on **Windows Server 2019** is usually caused by **RDP settings, clipboard service issues, or group policy restrictions**. Follow these steps **in order** — most issues are fixed in the first few steps.

***

### 1️⃣ Check RDP Clipboard Is Enabled (Client Side)

On your **local machine** (before connecting):

1. Open **Remote Desktop Connection (mstsc)**
2. Click **Show Options**
3. Go to **Local Resources**
4. Under **Local devices and resources**:
   * ✔ Clipboard is **checked**
5. Reconnect to the server

***

### 2️⃣ Restart Clipboard Process on Server (Fast Fix)

Inside the **Windows Server 2019 session**:

1. Open **Task Manager**
2.  End task:

    ```
    rdpclip.exe
    ```
3.  Open **Run (Win + R)** and type:

    ```
    rdpclip
    ```
4. Press Enter

✅ Copy-paste usually starts working immediately.

***

### 3️⃣ Restart Remote Desktop Services

If Step 2 doesn’t work:

1. Open **Services (services.msc)**
2. Restart:
   * **Remote Desktop Services**
   * **Remote Desktop Services UserMode Port Redirector**

⚠️ This may disconnect active users.

***

### 4️⃣ Check Group Policy (Server Side)

On the server:

1.  Run:

    ```
    gpedit.msc
    ```
2.  Navigate to:

    ```
    Computer Configuration
    → Administrative Templates
    → Windows Components
    → Remote Desktop Services
    → Remote Desktop Session Host
    → Device and Resource Redirection
    ```
3. Set these to **Not Configured** or **Disabled**:
   * **Do not allow Clipboard redirection**
   * **Do not allow drive redirection**
4.  Run:

    ```
    gpupdate /force
    ```



### ✅ Quick Summary (Most Effective Fixes)

✔ Enable clipboard in RDP client\
✔ Restart `rdpclip.exe`\
✔ Verify Group Policy allows clipboard\
✔ Restart RDS services
