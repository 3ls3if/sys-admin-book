---
icon: file-user
---

# Another account from your organization is already signed in on this computer

## Microsoft 365 apps activation error "Another account from your organization is already signed in on this computer"

{% hint style="warning" %}
**Note:** This error is expected if you're already signed in by using another Microsoft 365 account from the same tenant.
{% endhint %}

## MAC Devices

*   For Mac devices, follow these steps:

    1. Close all Microsoft 365 apps.
    2.  Open Terminal, and then run the following command:

        BashCopy

        ```bash
        defaults write com.microsoft.Word ResetOneAuthCreds -bool YES
        ```
    3. Open the Microsoft Word app and continue with the activation steps.
    4. If the issue persists, try the steps in [Can't sign in to an Office 2016 for Mac app](https://learn.microsoft.com/en-us/microsoft-365/troubleshoot/sign-in/sign-in-to-office-2016-for-mac-fail).



## Windows Devices

1. Sign out of all Microsoft 365 apps, and then sign in again.
2. If the issue still occurs, modify the OneAuth account store on the device:
   1. Navigate to the <mark style="color:orange;">`%localappdata%\Microsoft\OneAuth\account`</mark>`s` folder. You'll see one \<GUID> file, or multiple files that have different GUIDs if there are multiple accounts.
   2. Open the files by using Notepad, examine the <mark style="color:red;">**account\_hints**</mark> value, and identify the files that aren't associated with the account that you want to use to sign in.
   3. In each file that's identified in step b, locate the <mark style="color:red;">**association\_status**</mark> entry, change the association status of <mark style="color:orange;">`com.microsoft.Office`</mark> to <mark style="color:red;">**disassociated**</mark>, and then save the file. For example, change\
      &#xNAN;_<mark style="color:orange;">"association\_status": "{\\"</mark><mark style="color:orange;">**com.microsoft.Office**</mark><mark style="color:orange;">\\":\\"</mark><mark style="color:orange;">**associated**</mark><mark style="color:orange;">\\",\\"com.microsoft.Outlook\\":\\"associated\\"}"</mark>_\ <mark style="color:orange;">to</mark>\
      &#xNAN;_<mark style="color:orange;">"association\_status": "{\\"</mark><mark style="color:orange;">**com.microsoft.Office**</mark><mark style="color:orange;">\\":\\"</mark><mark style="color:orange;">**disassociated**</mark><mark style="color:orange;">\\",\\"com.microsoft.Outlook\\":\\"associated\\"}"</mark>_.
   4. Try to sign in again.
3. If the issue persists, sign out of all Microsoft 365 apps, remove all folders in the following locations, and then sign in again:
   * <mark style="color:orange;">`%localappdata%/Microsoft/OneAuth`</mark>
   * <mark style="color:orange;">`%localappdata%/Microsoft/IdentityCache`</mark>
4. If the issue persists, try the [additional troubleshooting methods](https://learn.microsoft.com/en-us/troubleshoot/office/activation/another-account-already-signed-in#additional-troubleshooting-methods).



***

## REFERENCES

* [https://learn.microsoft.com/en-us/troubleshoot/office/activation/another-account-already-signed-in](https://learn.microsoft.com/en-us/troubleshoot/office/activation/another-account-already-signed-in)
