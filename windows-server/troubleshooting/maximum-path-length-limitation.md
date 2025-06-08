---
icon: gauge-max
---

# Maximum Path Length Limitation

{% hint style="warning" %}
To enable **long file paths** in **Windows Server**, you need to modify a Group Policy or registry setting to allow paths longer than 260 characters (MAX\_PATH). This feature is available on **Windows Server 2016** and newer (as well as Windows 10/11) and only works with applications that support the `\\?\` prefix.
{% endhint %}

## Option 1: Enable via Group Policy

* <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`gpedit.msc`</mark><mark style="color:green;">, and press Enter to open the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Local Group Policy Editor**</mark><mark style="color:green;">.</mark>
*   <mark style="color:green;">Navigate to:</mark>

    ```
    Computer Configuration > Administrative Templates > System > Filesystem
    ```
*   <mark style="color:green;">Find and</mark> <mark style="color:green;"></mark><mark style="color:green;">**double-click**</mark><mark style="color:green;">:</mark>

    ```
    Enable Win32 long paths
    ```
* <mark style="color:green;">Set it to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enabled**</mark><mark style="color:green;">, then click</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Restart your system (or reboot the server) to apply the change.</mark>

***

## Option 2: Enable via Registry Editor

1. <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`regedit`</mark><mark style="color:green;">, and press Enter.</mark>
2.  <mark style="color:green;">Navigate to:</mark>

    ```
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem
    ```
3.  <mark style="color:green;">Look for a value named:</mark>

    ```
    LongPathsEnabled
    ```

    * <mark style="color:green;">If it doesn't exist, right-click on the right panel, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**New > DWORD (32-bit) Value**</mark><mark style="color:green;">, name it</mark> <mark style="color:green;"></mark><mark style="color:green;">`LongPathsEnabled`</mark><mark style="color:green;">.</mark>
4.  <mark style="color:green;">Set the value to:</mark>

    ```
    1
    ```
5. <mark style="color:green;">Restart your system to apply the changes.</mark>



{% hint style="warning" %}
#### Notes:

* The application **must be manifest-aware** and use the correct APIs or `\\?\` syntax to support long paths.
* Some older applications will still not support long paths, even with this enabled.
* Make sure your **Windows version is updated** (this feature is supported from Server 2016, Windows 10 v1607+).
{% endhint %}



***

## REFERENCES

* [https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry)
