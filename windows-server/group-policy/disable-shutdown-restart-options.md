---
icon: eclipse
---

# Disable Shutdown, Restart Options

{% hint style="success" %}
Yo**u can shut down a Windows system using the command line with the `shutdown` command. Here are different ways to use it:**



#### <mark style="color:purple;">**Basic Shutdown Command**</mark>

```cmd
shutdown /s /t 0
```



#### <mark style="color:purple;">**Shutdown Using PowerShell**</mark>

```powershell
Stop-Computer -Force
```



#### <mark style="color:purple;">**Shutdown with a Custom Message**</mark>

```cmd
shutdown /s /t 30 /c "System maintenance in progress. Please save your work."
```



#### <mark style="color:purple;">**Shutdown a Remote Computer**</mark>

```cmd
shutdown /s /m \\RemoteComputerName /t 0
```
{% endhint %}



## Disable Shutdown, Restart

To disable the **Shutdown** and **Restart** options in Windows Server using **Group Policy (GPO)**, follow these steps:

### **Method 1: Using Group Policy Editor (GPO)**

1.  **Open Group Policy Management**

    * <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">**`gpedit.msc`**</mark><mark style="color:green;">, and press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enter**</mark><mark style="color:green;">.</mark>\
      &#xNAN;_<mark style="color:green;">(If you're using a domain environment, open</mark> <mark style="color:green;"></mark><mark style="color:green;">`gpmc.msc`</mark> <mark style="color:green;"></mark><mark style="color:green;">instead.)</mark>_


2. **Navigate to the Policy Location**

*   <mark style="color:green;">Go to:</mark>

    ```
    User Configuration → Administrative Templates → Start Menu and Taskbar
    ```



3. **Enable the Policy to Remove Shutdown and Restart**

* <mark style="color:green;">Find</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Remove and prevent access to the Shut Down, Restart, Sleep, and Hibernate commands"**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Double-click it, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enabled**</mark><mark style="color:green;">, then click</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>



4. **Apply and Enforce the Policy**

*   <mark style="color:green;">Run the following command in</mark> <mark style="color:green;"></mark><mark style="color:green;">**Command Prompt**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**PowerShell**</mark> <mark style="color:green;"></mark><mark style="color:green;">to apply changes:</mark>

    ```
    gpupdate /force
    ```



***

### **Method 2: Using Group Policy Management (For Domain Environments)**

If managing via Active Directory, apply the same setting through **Group Policy Management** (`gpmc.msc`) by editing the appropriate **GPO** linked to user groups or organizational units (OUs).

#### **Result**

* <mark style="color:green;">The</mark> <mark style="color:green;"></mark><mark style="color:green;">**Shutdown**</mark><mark style="color:green;">,</mark> <mark style="color:green;"></mark><mark style="color:green;">**Restart**</mark><mark style="color:green;">,</mark> <mark style="color:green;"></mark><mark style="color:green;">**Sleep**</mark><mark style="color:green;">, and</mark> <mark style="color:green;"></mark><mark style="color:green;">**Hibernate**</mark> <mark style="color:green;"></mark><mark style="color:green;">options will be removed from the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Start Menu**</mark><mark style="color:green;">,</mark> <mark style="color:green;"></mark><mark style="color:green;">**Ctrl+Alt+Del screen**</mark><mark style="color:green;">, and</mark> <mark style="color:green;"></mark><mark style="color:green;">**Alt+F4 shutdown dialog**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Users will no longer be able to shut down or restart the server via the GUI.</mark>

#### <mark style="color:red;">**Alternative: Disable Shutdown via Permissions**</mark>

If you want to prevent shutdown via the command line as well:

1. <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**Local Security Policy**</mark> <mark style="color:green;"></mark><mark style="color:green;">(</mark><mark style="color:green;">`secpol.msc`</mark><mark style="color:green;">).</mark>
2.  <mark style="color:green;">Navigate to:</mark>

    ```
    Security Settings → Local Policies → User Rights Assignment
    ```
3. <mark style="color:green;">Find</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Shutdown the system"**</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">**remove all non-admin users**</mark><mark style="color:green;">.</mark>

This ensures only administrators can shut down the system.

