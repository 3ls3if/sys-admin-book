---
icon: sign-post
---

# Create Redirect Rule for Specific Mail ID

{% hint style="warning" %}
#### Available Actions in Mail Flow Rules:

1. **Redirect the message to** — _message goes only to the new recipient (original does not receive it)_
2. **Add recipient > Bcc the message to** — _message is delivered to both the original recipient and the Bcc'd address_
{% endhint %}

## Steps:

1. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Exchange Admin Center**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">`Mail Flow`</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">`Rules`</mark>\ <mark style="color:green;">(</mark>[<mark style="color:green;">https://admin.exchange.microsoft.com</mark>](https://admin.exchange.microsoft.com)<mark style="color:green;">)</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**+ Add a rule**</mark>
3. <mark style="color:green;">Name your rule:</mark>\
   <mark style="color:green;">`Forward RTA Mails to rta@pulselabs.co.in`</mark>
4. <mark style="color:green;">**Conditions:**</mark>
   * <mark style="color:green;">**Apply this rule if...**</mark>
     * <mark style="color:green;">`The recipient is`</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">`info@tankwealth.in`</mark>
     * <mark style="color:green;">`The sender is`</mark> <mark style="color:green;"></mark><mark style="color:green;">→ Add:</mark>
       * <mark style="color:green;">`donotreply@camsonline.com`</mark>
       * <mark style="color:green;">`distributorcare@kfintech.com`</mark>
5. <mark style="color:green;">**Do the following...**</mark>
   * <mark style="color:green;">Choose:</mark>\
     <mark style="color:green;">**"Add recipient"**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Bcc the message to"**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">`rta@pulselabs.co.in`</mark>
6. <mark style="color:green;">Leave audit/logging defaults and save the rule.</mark>

## Result

* <mark style="color:green;">The message is</mark> <mark style="color:green;"></mark><mark style="color:green;">**delivered normally to**</mark><mark style="color:green;">**&#x20;**</mark><mark style="color:green;">**`info@tankwealth.in`**</mark>
* <mark style="color:green;">A</mark> <mark style="color:green;"></mark><mark style="color:green;">**copy is silently Bcc’d to**</mark><mark style="color:green;">**&#x20;**</mark><mark style="color:green;">**`rta@pulselabs.co.in`**</mark>
* <mark style="color:green;">**The original sender is not notified**</mark>

## Enable External Email Forwarding in Microsoft 365

Some tenants have **automatic external forwarding disabled** by default (for security reasons). To allow it:

**Go to:**

[<mark style="color:green;">https://security.microsoft.com</mark>](https://security.microsoft.com) <mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Email & Collaboration**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Policies & Rules**</mark> <mark style="color:green;"></mark><mark style="color:green;">→</mark> <mark style="color:green;"></mark><mark style="color:green;">**Threat policies**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Anti-spam policies**</mark>

**Find the active policy (often named "Default").**

1. <mark style="color:green;">Click the policy →</mark> <mark style="color:green;"></mark><mark style="color:green;">**Edit outbound spam filter policy**</mark>
2. <mark style="color:green;">Scroll to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Automatic forwarding**</mark>
3. <mark style="color:green;">Set to:</mark>\
   <mark style="color:green;">**On - Forwarding is enabled**</mark>
4. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Save**</mark>

## **Add the External Email as a Mail Contact (Optional but Recommended)**

If you want to **use the external address (`rta@pulselabs.co.in`) in mail flow rules**, it’s best to add it as a **mail contact**:

**In Exchange Admin Center (**[**https://admin.exchange.microsoft.com**](https://admin.exchange.microsoft.com)**):**

1. <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Recipients**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Contacts**</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**+ Add a mail contact**</mark>
   * <mark style="color:green;">**Name**</mark><mark style="color:green;">:</mark> <mark style="color:green;"></mark><mark style="color:green;">`RTA Contact`</mark>
   * <mark style="color:green;">**Email**</mark><mark style="color:green;">:</mark> <mark style="color:green;"></mark><mark style="color:green;">`rta@pulselabs.co.in`</mark>
3. <mark style="color:green;">Save</mark>

{% hint style="warning" %}
Now this external address will show up as a selectable recipient in mail flow rules.
{% endhint %}



***

## REFERENCES

[https://learn.microsoft.com/en-us/microsoft-365/admin/email/configure-email-forwarding?view=o365-worldwide](https://learn.microsoft.com/en-us/microsoft-365/admin/email/configure-email-forwarding?view=o365-worldwide)
