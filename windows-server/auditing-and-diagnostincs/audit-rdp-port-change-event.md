---
icon: power-off
---

# Audit RDP Port Change Event

## Steps to Audit RDP Port Change (Registry):

{% hint style="warning" %}
## Enable Audit Policy

* Open **Local Security Policy**:
  * Press `Win + R`, type `secpol.msc`, and press Enter.
* Navigate to:
* Double-click **Audit Registry**.
* Check **Success** and/or **Failure** depending on what you want to track.
* Click **Apply** → **OK**.

```
Security Settings → Advanced Audit Policy Configuration → Object Access 
```
{% endhint %}



### **1. Enable GPO Audit Settings**:

* <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">`gpedit.msc`</mark> <mark style="color:green;"></mark><mark style="color:green;">(or use GPMC for domain).</mark>
* <mark style="color:green;">Go to:</mark>\
  <mark style="color:green;">`Computer Configuration > Policies > Windows Settings > Security Settings > Advanced Audit Policy Configuration > System Audit Policies > Object Access`</mark>
*   <mark style="color:green;">Enable:</mark>

    * <mark style="color:green;">**Audit Registry**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Success and Failure</mark>



### 2. **Set auditing on the specific registry key**:

* <mark style="color:green;">Open</mark> <mark style="color:green;"></mark><mark style="color:green;">**regedit**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Go to:</mark>\
  <mark style="color:green;">`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\PortNumber`</mark>
*   <mark style="color:green;">Right-click</mark> <mark style="color:green;"></mark><mark style="color:green;">**PortNumber**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Permissions → Advanced → Auditing tab → Add:</mark>

    * <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**Principal**</mark> <mark style="color:green;"></mark><mark style="color:green;">(e.g., Everyone or Authenticated Users)</mark>
    * <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**Success**</mark> <mark style="color:green;"></mark><mark style="color:green;">for</mark> <mark style="color:green;"></mark><mark style="color:green;">**Set Value**</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">**Write**</mark>



### 3. **Check Event Viewer**:

* <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">`Security`</mark> <mark style="color:green;"></mark><mark style="color:green;">logs.</mark>
* <mark style="color:green;">Look for</mark> <mark style="color:green;"></mark><mark style="color:green;">**Event ID 4657**</mark> <mark style="color:green;"></mark><mark style="color:green;">(A registry value was modified).</mark>
* <mark style="color:green;">It will show:</mark>
  * <mark style="color:green;">**Who**</mark> <mark style="color:green;"></mark><mark style="color:green;">made the change (user ID)</mark>
  * <mark style="color:green;">**What**</mark> <mark style="color:green;"></mark><mark style="color:green;">key was changed</mark>
  * <mark style="color:green;">**Original and new values**</mark>



