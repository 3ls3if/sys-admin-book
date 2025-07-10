---
icon: user-clock
---

# SMTP server error:  User is locked by your organization's security defaults policy

{% hint style="warning" %}
## ERROR

SMTP server error: 5.7.57 Client not authenticated to send mail.Error: 535 5.7.139 Authentication unsuccessful, user is locked by your organization's security defaults policy.
{% endhint %}

{% hint style="warning" %}
### Meaning:

Your **Office 365 account (`info@example.com`) is blocked from using SMTP AUTH** due to **Security Defaults or Conditional Access policies** in your Microsoft 365 tenant.
{% endhint %}

### Steps to Fix the Issue

#### **Option 1: Disable Security Defaults (Tenant Level)**

1. <mark style="color:green;">Log in to the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Microsoft Entra (Azure AD) Portal**</mark><mark style="color:green;">:</mark>\
   &#x20;[<mark style="color:green;">https://entra.microsoft.com/</mark>](https://entra.microsoft.com/)
2. <mark style="color:green;">Go to:</mark>\
   <mark style="color:green;">`Identity`</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">`Overview`</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Properties**</mark>
3. <mark style="color:green;">Scroll to bottom, and look for:</mark>\
   <mark style="color:green;">**"Security defaults"**</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Set to</mark> <mark style="color:green;"></mark><mark style="color:green;">**"No"**</mark>
4. <mark style="color:green;">Save changes.</mark>

{% hint style="success" %}
&#x20;This disables strict security defaults and allows SMTP login using username/password.
{% endhint %}

***

#### **Option 2: Enable SMTP AUTH for the Specific Mailbox**

1. <mark style="color:green;">Go to:</mark>\
   [<mark style="color:green;">https://admin.microsoft.com</mark>](https://admin.microsoft.com)
2. <mark style="color:green;">Navigate to:</mark>\
   <mark style="color:green;">`Users`</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">`Active Users`</mark> <mark style="color:green;"></mark><mark style="color:green;">→ click</mark> <mark style="color:green;"></mark><mark style="color:green;">`info@extrakamai.com`</mark>
3. <mark style="color:green;">In the right pane, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Mail → Manage email apps**</mark>
4. <mark style="color:green;">Ensure</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Authenticated SMTP"**</mark> <mark style="color:green;"></mark><mark style="color:green;">is enabled</mark>&#x20;



***

## REFERENCES

* [https://learn.microsoft.com/en-us/answers/questions/681904/smtp-authenication-failure-5-7-57-and-5-7-139](https://learn.microsoft.com/en-us/answers/questions/681904/smtp-authenication-failure-5-7-57-and-5-7-139)
* [https://stackoverflow.com/questions/24947434/setting-up-phpmailer-with-office365-smtp](https://stackoverflow.com/questions/24947434/setting-up-phpmailer-with-office365-smtp)
