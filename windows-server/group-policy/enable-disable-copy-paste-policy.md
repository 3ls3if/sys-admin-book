---
icon: toggle-on
---

# Enable / Disable Copy-Paste Policy

## How to Disable Copy and Paste in Windows: For Local Machines and VMs

**Copy and paste functionality can be a major security risk.**

It allows unauthorized data transfer between a local machine and a Virtual Machine (VM), potentially exposing sensitive information or violating security protocols. This is especially critical in environments where compliance with strict data protection policies is required.

**The solution? Disable copy and paste for all users.**

Whether you’re managing a team or ensuring your VM stays secure, this guide will walk you through step-by-step instructions for disabling clipboard redirection. You’ll learn how to block copy and paste for all users, including administrators, using the Windows Group Policy Editor.

## **How to Disable Copy and Paste for All Users**

To disable copy and paste between a local machine and a Virtual Machine (VM), you’ll need to adjust settings in the Windows Group Policy Editor. This process ensures all users, including administrators, cannot transfer data through clipboard redirection.

## Method 1: Using Group Policy Editor (GPO)

#### **Step 1: Open Group Policy Editor**

1. <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`gpedit.msc`</mark><mark style="color:green;">, and press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enter**</mark><mark style="color:green;">.</mark>
2.  <mark style="color:green;">Navigate to the following path:</mark>

    <pre><code><strong>|-> Computer Configuration 
    </strong>|
    |-----> Administrative Templates 
    |
    |--------> Windows Components 
    |
    |-----------> Remote Desktop Services 
    |
    |---------------> Remote Desktop Session Host 
    <strong>|
    </strong>|--------------------> Device and Resource Redirection
    </code></pre>

***

#### **Step 2: Configure the Clipboard Redirection Policy**

1. <mark style="color:green;">Find the policy</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Do not allow clipboard redirection"**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">**To Disable Copy-Paste (Block):**</mark>
   * <mark style="color:green;">Double-click the policy.</mark>
   * <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enabled**</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Apply**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">**To Enable Copy-Paste (Allow):**</mark>
   * <mark style="color:green;">Double-click the policy.</mark>
   * <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disabled**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**Not Configured**</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Apply**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>

***

#### **Step 3: Apply Changes**

1.  <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Command Prompt**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**PowerShell**</mark> <mark style="color:green;"></mark><mark style="color:green;">and run:</mark>

    ```bash
    gpupdate /force
    ```
2. <mark style="color:green;">Restart the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Remote Desktop Session Host**</mark> <mark style="color:green;"></mark><mark style="color:green;">or the server for the changes to take effect.</mark>



***

## Method 2: Using Windows Registry

#### **Step 1: Open Registry Editor**

1. <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`regedit`</mark><mark style="color:green;">, and press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enter**</mark><mark style="color:green;">.</mark>

#### **Step 2: Navigate to the Registry Path**

```plaintext
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
```

#### **Step 3: Create or Edit the Key**

1. <mark style="color:green;">**Create a DWORD (32-bit) Value**</mark> <mark style="color:green;"></mark><mark style="color:green;">named</mark> <mark style="color:green;"></mark><mark style="color:green;">**"fDisableClipboard"**</mark> <mark style="color:green;"></mark><mark style="color:green;">if it doesn’t exist.</mark>
2. <mark style="color:green;">**Set the Value:**</mark>
   * <mark style="color:green;">`1`</mark> <mark style="color:green;"></mark><mark style="color:green;">— To</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disable**</mark> <mark style="color:green;"></mark><mark style="color:green;">copy-paste (Block).</mark>
   * <mark style="color:green;">`0`</mark> <mark style="color:green;"></mark><mark style="color:green;">— To</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enable**</mark> <mark style="color:green;"></mark><mark style="color:green;">copy-paste (Allow).</mark>
3. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark> <mark style="color:green;"></mark><mark style="color:green;">and close the Registry Editor.</mark>

***

## Method 3: Using Remote Desktop Services (RDS)

For environments using RDS, follow these steps:

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Server Manager**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Remote Desktop Services**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Collections**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Select your</mark> <mark style="color:green;"></mark><mark style="color:green;">**Session Collection**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Tasks**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Edit Properties**</mark><mark style="color:green;">.</mark>
5. <mark style="color:green;">Under the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Client Settings**</mark> <mark style="color:green;"></mark><mark style="color:green;">tab:</mark>
   * <mark style="color:green;">**Uncheck**</mark> <mark style="color:green;">**Clipboard**</mark> <mark style="color:green;"></mark><mark style="color:green;">to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disable**</mark> <mark style="color:green;"></mark><mark style="color:green;">copy-paste.</mark>
   * <mark style="color:green;">**Check**</mark> <mark style="color:green;">**Clipboard**</mark> <mark style="color:green;"></mark><mark style="color:green;">to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enable**</mark> <mark style="color:green;"></mark><mark style="color:green;">copy-paste.</mark>
6. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Apply**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>



***

## Method 4: Using PowerShell (Script-Based Approach)

You can automate this with PowerShell:

* **To Disable Copy-Paste:**

```powershell
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "fDisableClip" -Value 1
```

* **To Enable Copy-Paste:**

```powershell
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "fDisableClip" -Value 0
```

* Restart RDP service to apply changes:

```powershell
Restart-Service TermService -Force
```



***

## Method 5: Disable Copy-Paste in RDP Client (Local Machine)

For individual users connecting to the server:

1. <mark style="color:green;">**Open Remote Desktop Connection (mstsc)**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Show Options**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Local Resources**</mark> <mark style="color:green;"></mark><mark style="color:green;">tab.</mark>
3. <mark style="color:green;">**Uncheck**</mark> <mark style="color:green;">**Clipboard**</mark> <mark style="color:green;"></mark><mark style="color:green;">under "Local devices and resources".</mark>
4. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Connect**</mark><mark style="color:green;">.</mark>

***

## REFERENCES

* [https://v2cloud.com/blog/how-to-disable-copy-and-paste-in-windows](https://v2cloud.com/blog/how-to-disable-copy-and-paste-in-windows)

