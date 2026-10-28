---
icon: windows
---

# RDP: This problem can occur if the remote PC is running a version of Windows that is not configured

{% hint style="danger" %}
This problem can occur if the remote PC is running a version of Windows that is not configured to support server authentication.
{% endhint %}

That message usually means **the remote computer can’t complete the security handshake required by the client that’s trying to connect** (most commonly with Remote Desktop / RDP).

#### What it means (plain English)

Your local PC is trying to connect using **modern, secure authentication** (Network Level Authentication / CredSSP / TLS), but the **remote PC is too old or misconfigured** to support it.

This often happens when:

* The remote PC is running an **older version of Windows**
* Remote Desktop is enabled, but **Network Level Authentication (NLA)** isn’t supported or is disabled
* The remote system hasn’t been updated with required security patches

#### Common scenarios

* Connecting from **Windows 10/11 → Windows XP, Vista, or very old Windows 7**
* Connecting to a **legacy server** that hasn’t been updated
* Using a **third-party RDP client** with stricter security defaults

#### Ways to fix it (choose what applies)

**✅ Option 1: Enable modern authentication on the remote PC (best)**

On the **remote computer**:

1. Open **System Properties**
2. Go to **Remote**
3. Check **“Allow connections only from computers running Remote Desktop with Network Level Authentication”**
4. Apply and reboot

(Only works if the OS supports NLA.)



**⚠️ Option 2: Lower security on the client (temporary workaround)**

On the **client PC**:

1. Open **Remote Desktop Connection**
2. Click **Show Options → Advanced**
3. Under **Connect from anywhere**, set security to **RDP Security Layer** (if available)

Or via Group Policy:

* `Computer Configuration → Administrative Templates → Windows Components → Remote Desktop Services → Remote Desktop Session Host → Security`
* Set **“Require use of specific security layer”** to **RDP**

⚠️ This reduces security and should only be used on trusted networks.

***

**🔄 Option 3: Update the remote system**

* Install **Windows Updates** on the remote PC
* Old Windows versions often lack required authentication support until patched

***

**🧓 Option 4: Use a compatible OS**

If the remote PC is running something like **Windows XP or unpatched Vista**, modern Windows versions may simply refuse to connect securely. In that case:

* Upgrade the OS, or
* Use a legacy RDP client in a controlled environment
