---
icon: user-magnifying-glass
---

# Disable Multiple Session for Single User

## Prevent Multiple Sessions

To **prevent multiple sessions** for a single user in **Windows Server** using **Group Policy (GPO)**, follow these steps:

### **Method 1: Using Group Policy (GPO)**

1. **Open Group Policy Management**
   * <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`gpedit.msc`</mark><mark style="color:green;">, and press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enter**</mark><mark style="color:green;">.</mark>\
     &#xNAN;_<mark style="color:green;">(For a domain environment, open</mark> <mark style="color:green;"></mark><mark style="color:green;">`gpmc.msc`</mark><mark style="color:green;">.)</mark>_
2.  **Navigate to the Policy Location**

    ```
    Computer Configuration → Administrative Templates → Windows Components → Remote Desktop Services → Remote Desktop Session Host → Connections
    ```
3. **Modify the Policy**
   * <mark style="color:green;">Double-click</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Restrict Remote Desktop Services users to a single Remote Desktop Services session"**</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Set it to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enabled**</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Apply**</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>
4. **Apply the Policy**
   *   <mark style="color:green;">Run the following command to enforce the policy:</mark>

       ```
       gpupdate /force
       ```



***

### **Method 2: Using Local Group Policy (Secpol.msc)**

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Local Security Policy**</mark> <mark style="color:green;"></mark><mark style="color:green;">(</mark><mark style="color:green;">`secpol.msc`</mark><mark style="color:green;">).</mark>
2.  <mark style="color:green;">Navigate to:</mark>

    ```
    Local Policies → Security Options
    ```
3.  <mark style="color:green;">Find and</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enable**</mark><mark style="color:green;">:</mark>

    ```
    "Limit number of concurrent sessions to 1"
    ```



***

### **Method 3: Using Registry Editor (Alternative)**

If you don’t want to use GPO, modify the registry:

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Registry Editor**</mark> <mark style="color:green;"></mark><mark style="color:green;">(</mark><mark style="color:green;">`regedit`</mark><mark style="color:green;">).</mark>
2.  <mark style="color:green;">Navigate to:</mark>

    ```
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server
    ```
3. <mark style="color:green;">Find</mark> <mark style="color:green;"></mark><mark style="color:green;">**"fSingleSessionPerUser"**</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">If it doesn’t exist, create a</mark> <mark style="color:green;"></mark><mark style="color:green;">**DWORD (32-bit) Value**</mark> <mark style="color:green;"></mark><mark style="color:green;">with this name.</mark>
   * <mark style="color:green;">Set its value to</mark> <mark style="color:green;"></mark><mark style="color:green;">**1**</mark> <mark style="color:green;"></mark><mark style="color:green;">(1 = Single session per user).</mark>
4. <mark style="color:green;">Restart the server for changes to take effect.</mark>



***

{% hint style="success" %}
#### **Effect of This Policy**

* A user who is already logged in **won’t be able to start another session**.
* If they try to log in again, the existing session will be reconnected instead.
{% endhint %}

