---
icon: key
---

# Office 365 Apps Activation Error

## Error: Another account from your organization is already signed in on this computer

{% hint style="success" %}
**Note:** This error is expected if you're already signed in by using another Microsoft 365 account from the same tenant.
{% endhint %}

### Mac Devices

1. <mark style="color:green;">Close all Microsoft 365 apps.</mark>
2.  <mark style="color:green;">Open Terminal, and then run the following command:</mark>



    ```bash
    defaults write com.microsoft.Word ResetOneAuthCreds -bool YES
    ```
3. <mark style="color:green;">Open the Microsoft Word app and continue with the activation steps.</mark>
4. <mark style="color:green;">If the issue persists, try the steps in</mark> [<mark style="color:green;">Can't sign in to an Office 2016 for Mac app</mark>](https://learn.microsoft.com/en-us/microsoft-365/troubleshoot/sign-in/sign-in-to-office-2016-for-mac-fail)<mark style="color:green;">.</mark>

### Windows Devices

1. <mark style="color:green;">Sign out of all Microsoft 365 apps, and then sign in again.</mark>
2. <mark style="color:green;">If the issue still occurs, modify the OneAuth account store on the device:</mark>
   1. <mark style="color:green;">Navigate to the</mark> <mark style="color:red;">`%localappdata%\Microsoft\OneAuth\accounts`</mark> <mark style="color:green;">folder. You'll see one \<GUID> file, or multiple files that have different GUIDs if there are multiple accounts.</mark>
   2. <mark style="color:green;">Open the files by using Notepad, examine the</mark> <mark style="color:green;"></mark><mark style="color:green;">**account\_hints**</mark> <mark style="color:green;"></mark><mark style="color:green;">value, and identify the files that aren't associated with the account that you want to use to sign in.</mark>
   3. <mark style="color:green;">In each file that's identified in step b, locate the</mark> <mark style="color:green;"></mark><mark style="color:green;">**association\_status**</mark> <mark style="color:green;"></mark><mark style="color:green;">entry, change the association status of</mark> <mark style="color:orange;">`com.microsoft.Office`</mark> <mark style="color:green;">to</mark> <mark style="color:orange;">**disassociated**</mark><mark style="color:green;">, and then save the file. For example, change</mark>\
      &#xNAN;_<mark style="color:green;">"</mark><mark style="color:orange;">association\_status": "{\\"</mark><mark style="color:orange;">**com.microsoft.Office**</mark><mark style="color:orange;">\\":\\"</mark><mark style="color:orange;">**associated**</mark><mark style="color:orange;">\\",\\"com.microsoft.Outlook\\":\\"associated\\"}"</mark>_\ <mark style="color:green;">to</mark>\
      &#xNAN;_<mark style="color:orange;">"association\_status": "{\\"</mark><mark style="color:orange;">**com.microsoft.Office**</mark><mark style="color:orange;">\\":\\"</mark><mark style="color:orange;">**disassociated**</mark><mark style="color:orange;">\\",\\"com.microsoft.Outlook\\":\\"associated\\"</mark><mark style="color:green;">}"</mark>_<mark style="color:green;">.</mark>
   4. <mark style="color:green;">Try to sign in again.</mark>
3. <mark style="color:green;">If the issue persists, sign out of all Microsoft 365 apps, remove all folders in the following locations, and then sign in again:</mark>
   * <mark style="color:red;">`%localappdata%/Microsoft/OneAuth`</mark>
   * <mark style="color:red;">`%localappdata%/Microsoft/IdentityCache`</mark>
4. <mark style="color:green;">If the issue persists, try the</mark> [<mark style="color:green;">additional troubleshooting methods</mark>](https://learn.microsoft.com/en-us/office/troubleshoot/activation/another-account-already-signed-in#additional-troubleshooting-methods)<mark style="color:green;">.</mark>

### Using Tools

The solution is to use this tool : [https://office-reset.com](https://office-reset.com/) and select the following option&#x20;

<figure><img src="../../.gitbook/assets/image (8) (1) (1).png" alt=""><figcaption></figcaption></figure>





***

## REFERENCES

* [https://learn.microsoft.com/en-us/office/troubleshoot/activation/another-account-already-signed-in](https://learn.microsoft.com/en-us/office/troubleshoot/activation/another-account-already-signed-in)
* [https://office-reset.com/](https://office-reset.com/)

