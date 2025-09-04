---
icon: triangle-exclamation
---

# Warning in Plesk interface: Another user with the same username (admin) is already logged in to ...

### Symptoms

* The following warning is shown after login into Plesk:

{% hint style="warning" %}
Another user with the same username (admin) is already logged in to Plesk.
{% endhint %}

### Cause

This behavior is expected if **Profile & Preferences > Allow multiple sessions under this account** option is enabled and several logins to Plesk UI were performed:\


<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>



### Resolution

If it is required to disable multiple sessions perform the following steps:

1. [Log into Plesk.](https://plesk-new.zendesk.com/hc/en-us/articles/12377667582743-How-to-login-to-Plesk-)
2. Go to **Profile & Preferences >** disable **Allow multiple sessions under this account:**

<figure><img src="../../../.gitbook/assets/image (60).png" alt=""><figcaption></figcaption></figure>





***

## REFERENCES

* [https://support.plesk.com/hc/en-us/articles/12377288473367-Warning-in-Plesk-interface-Another-user-with-the-same-username-admin-is-already-logged-in-to-Plesk](https://support.plesk.com/hc/en-us/articles/12377288473367-Warning-in-Plesk-interface-Another-user-with-the-same-username-admin-is-already-logged-in-to-Plesk)
