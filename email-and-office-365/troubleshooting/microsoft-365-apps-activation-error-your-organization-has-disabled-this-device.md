---
icon: laptop
---

# Microsoft 365 Apps activation error: “Your organization has disabled this device”

{% hint style="warning" %}
When trying to activate Microsoft 365 apps, you might encounter the following error:

> Your organization has disabled this device
{% endhint %}

## Enable the device in Microsoft Entra ID

1. <mark style="color:green;">Sign in to the</mark> [<mark style="color:green;">Azure portal</mark>](https://portal.azure.com/)<mark style="color:green;">.</mark>
2. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Microsoft Entra ID**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Devices**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Check the disabled devices list in</mark> <mark style="color:green;"></mark><mark style="color:green;">**Devices**</mark><mark style="color:green;">, by searching on the user name or device name.</mark>
4. <mark style="color:green;">Select the device, and then select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Enable**</mark><mark style="color:green;">.</mark>

**If the device has been deleted in Microsoft Entra ID, you need to re-register it.**

1. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Settings**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Accounts**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Access Work or School**</mark><mark style="color:green;">.</mark>
2. <mark style="color:green;">Select the account and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Disconnect**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Connect**</mark> <mark style="color:green;"></mark><mark style="color:green;">and register the device again by going through the sign in process.</mark>



***

## REFERENCES

* [https://learn.microsoft.com/en-us/office/troubleshoot/activation/your-organization-disabled-this-device](https://learn.microsoft.com/en-us/office/troubleshoot/activation/your-organization-disabled-this-device)
