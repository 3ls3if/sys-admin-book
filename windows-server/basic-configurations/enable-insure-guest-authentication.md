---
icon: door-open
---

# Enable Insure Guest Authentication

#### **Method 1: Using Registry Editor (Regedit)**

1. Press `Win + R`, type **`regedit`**, and press **Enter**.
2.  Navigate to:

    ```
    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters
    ```
3. Look for **`AllowInsecureGuestAuth`**.
   * If it doesn’t exist, create a **new DWORD (32-bit) Value** with this name.
4. Set its **Value Data** to `1`.
5. Click **OK** and close the Registry Editor.
6. Restart your computer for changes to take effect.

{% hint style="warning" %}
**SECURITY WARNING**

* Enabling this can expose your system to **unauthorized access and malware**.
* If necessary, **restrict guest access** to specific shared folders instead of enabling it system-wide.
* **Always disable it after use** to prevent security risks.
{% endhint %}

