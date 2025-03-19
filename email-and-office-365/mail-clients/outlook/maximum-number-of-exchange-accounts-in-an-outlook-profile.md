---
icon: square-user
---

# Maximum number of Exchange accounts in an Outlook profile

## Maximum number of Exchange accounts in an Outlook profile

Beginning with Microsoft Outlook 2010, you can open more than one Exchange account in your Outlook profile.

So how many Exchange Accounts can you add to an Outlook 2010, Outlook 2013, 2106, or Outlook 2019 profile?

In Microsoft Outlook 2013 and newer, the default is 10 accounts and the maximum allowed is 9999 accounts. Outlook 2010 supports up to 15 accounts in your profiles, but, by default it is limited to 5 accounts.

If the administrator wants to allow more (or less) than the default number of accounts, he or she needs to edit the registry or apply a group policy.

The relevant Group Policy key for all supported versions of **Outlook** is:

```
HKEY_CURRENT_USER\Software\Policies\Microsoft\Exchange
DWORD: MaxNumExchange

Outlook 2010 values: a decimal value between 1 and 15
Outlook 2013 values: a decimal value between 1 and 9999
Outlook 2016 values: a decimal value between 1 and 9999
Outlook 2019 values: a decimal value between 1 and 9999
```

<figure><img src="../../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

In the Group policy editor, the setting is under **Outlook** > **Account Settings** > **Exchange** > _Set maximum number of accounts per profile._

{% hint style="success" %}
If you prefer not to add it as a policy, use these keys instead. Note: if you are using the consumer or Business version of Outlook 2013 and newer, you may need to use these keys instead.
{% endhint %}

```
HKEY_CURRENT_USER\Software\Microsoft\Exchange
DWORD: MaxNumExchange

Outlook 2010 values: a decimal value between 1 and 15
Outlook 2013 values: a decimal value between 1 and 9999
Outlook 2016 values: a decimal value between 1 and 9999
Outlook 2019 values: a decimal value between 1 and 9999
```

<figure><img src="../../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>



***

## REFERENCES

* [https://www.slipstick.com/exchange/maximum-number-exchange-accounts-outlook-profile/](https://www.slipstick.com/exchange/maximum-number-exchange-accounts-outlook-profile/)

