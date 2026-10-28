---
icon: globe-pointer
---

# Block Access to Specific Websites

{% hint style="warning" %}
To **block Facebook, Instagram, Twitter, and YouTube** on a **Windows Server (for a VM)**, you can restrict access using one or more of the following methods, depending on your setup and control level.
{% endhint %}

## Method 1: **Edit the Hosts File**

This blocks access at the DNS level for that specific machine.

#### Steps:

1. **Open Notepad as Administrator**
2. Go to: `C:\Windows\System32\drivers\etc\hosts`
3.  Add the following lines at the bottom:

    ```
    127.0.0.1 facebook.com
    127.0.0.1 www.facebook.com
    127.0.0.1 instagram.com
    127.0.0.1 www.instagram.com
    127.0.0.1 twitter.com
    127.0.0.1 www.twitter.com
    127.0.0.1 youtube.com
    127.0.0.1 www.youtube.com
    ```
4. Save the file.
5. Flush DNS with:\
   `ipconfig /flushdns`&#x20;

{% hint style="warning" %}
Note: This method is easy to bypass by tech-savvy users and doesn’t work over HTTPS in all cases.
{% endhint %}

