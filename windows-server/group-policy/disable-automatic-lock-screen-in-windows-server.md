---
icon: lock
---

# Disable Automatic Lock Screen in Windows Server

## Steps to Disable Automatic Lock Screen in Windows Server

1. <mark style="color:green;">**Open Group Policy Management Console (GPMC)**</mark>\
   <mark style="color:green;">`gpmc.msc`</mark>
2. <mark style="color:green;">**Create a new GPO or edit an existing one**</mark>\ <mark style="color:green;">Link it to the appropriate OU where your server or computers are located.</mark>

## Computer Configuration > Policies > Administrative Templates > Control Panel > Personalization

* <mark style="color:green;">**Enable screen saver**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Set to: Disabled**</mark>\
  &#xNAN;_<mark style="color:green;">(This stops the screen saver from running)</mark>_
* <mark style="color:green;">**Screen saver timeout**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Set to: Disabled**</mark>\
  &#xNAN;_<mark style="color:green;">(Prevents any timeout from activating the screen saver)</mark>_

## **User Configuration > Administrative Templates > Control Panel > Personalization**

* <mark style="color:green;">**Enable screen saver**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Set to: Disabled**</mark>
* <mark style="color:green;">**Screen saver timeout**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Set to: Disabled**</mark>
* <mark style="color:green;">**Password protect the screen saver**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Set to: Disabled**</mark>
* <mark style="color:green;">**Prevent changing screen saver**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Optional — leave it</mark> <mark style="color:green;"></mark><mark style="color:green;">**Not Configured**</mark> <mark style="color:green;"></mark><mark style="color:green;">unless you want to lock settings.</mark>

## Disable Lock via Registry using GPO

If you want to go further and ensure no lock screen via registry:

**Navigate to:**\
`Computer Configuration > Preferences > Windows Settings > Registry`

**Add a new registry item:**

* <mark style="color:green;">Hive:</mark> <mark style="color:green;"></mark><mark style="color:green;">`HKEY_LOCAL_MACHINE`</mark>
* <mark style="color:green;">Key Path:</mark> <mark style="color:green;"></mark><mark style="color:green;">`SOFTWARE\Policies\Microsoft\Windows\Personalization`</mark>
* <mark style="color:green;">Value name:</mark> <mark style="color:green;"></mark><mark style="color:green;">`NoLockScreen`</mark>
* <mark style="color:green;">Value type:</mark> <mark style="color:green;"></mark><mark style="color:green;">`REG_DWORD`</mark>
* <mark style="color:green;">Value data:</mark> <mark style="color:green;"></mark><mark style="color:green;">`1`</mark>&#x20;

## Power Settings (if you don’t want the screen to turn off)

**Computer Configuration > Administrative Templates > System > Power Management > Sleep Settings**

* <mark style="color:green;">**Sleep after (plugged in)**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disabled**</mark>
* <mark style="color:green;">**Turn off the display (plugged in)**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disabled**</mark>
* <mark style="color:green;">**Allow hybrid sleep (plugged in)**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disabled**</mark>
* <mark style="color:green;">**Allow applications to prevent automatic sleep**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enabled**</mark> _<mark style="color:green;">(optional)</mark>_



{% hint style="warning" %}
* Make sure to **force group policy update** with `gpupdate /force`.
* If the lock screen still shows up, check for **Active Directory domain policies**, **local GPO overrides**, or **third-party management tools (like SCCM/Intune)**.
{% endhint %}

***

## REFERENCES

* [https://www.isunshare.com/windows-server/disable-enable-windows-server-2012-lock-screen.html](https://www.isunshare.com/windows-server/disable-enable-windows-server-2012-lock-screen.html)
* [https://community.spiceworks.com/t/gpo-lock-screen-turn-off-screen-disable-sleep/950820/2](https://community.spiceworks.com/t/gpo-lock-screen-turn-off-screen-disable-sleep/950820/2)
