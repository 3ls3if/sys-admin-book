---
icon: windows
---

# Hybrid Setup: M365 to Hostinger

## Setting up Hybrid Mail Flow Between Microsoft 365 and Hostinger

In many organizations, migrating fully to Microsoft 365 (M365) may not be immediate. Some users’ mailboxes may still be hosted on Hostinger, while others are already migrated to Microsoft 365 Exchange Online. In this scenario, we can configure a **hybrid mail flow**, ensuring that:

* Emails first route to Microsoft 365.
* If the recipient mailbox is not available in M365, the email is forwarded to Hostinger.

This guide explains how to set up mail flow between Microsoft 365 and Hostinger.



## Prerequisites

* **Custom Domain Registered**
  * You should already have your domain (e.g., `example.com`) connected to both Microsoft 365 and Hostinger.
* **Access to Hostinger Email Settings**
  * Ability to configure DNS records and view Hostinger’s mail server details (SMTP, IMAP, MX, etc.).
*   **Microsoft 365 Admin Access**

    * You need to be a Global Admin or Exchange Admin to configure connectors and mail flow.



## Configure DNS MX Record

To make Microsoft 365 the primary email handler:

1. Go to your DNS management (Cloudflare, Hostinger DNS, or wherever your domain is hosted).
2.  Set the **MX record** to point to Microsoft 365:

    ```
    Priority: 0  
    MX: <your-domain>.mail.protection.outlook.com
    ```

    Example:

    ```
    MX: example-com.mail.protection.outlook.com
    ```
3. Remove or lower the priority of Hostinger’s MX record.

{% hint style="success" %}
✅ This ensures all incoming email first goes to Microsoft 365.
{% endhint %}

{% hint style="info" %}
## Differences To Know

* <mark style="color:blue;">**Partner organization connector**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">→ Usually used for external companies. It only routes mail to specific domains or specific recipient addresses you configure. Since you’re adding Hostinger mailboxes manually, Exchange Online will only relay messages for those exact accounts you entered.</mark>
* <mark style="color:blue;">**Your organization’s email server connector + Internal Relay domain**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">→ Smarter, because you don’t have to manually maintain a list of users. Exchange Online first checks if the recipient exists in M365. If not, it automatically forwards to Hostinger for delivery.</mark>



#### <mark style="color:blue;">Why Partner Organization might cause issues:</mark>

* <mark style="color:blue;">You’ll need to</mark> <mark style="color:blue;"></mark><mark style="color:blue;">**keep updating the connector manually**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">whenever a Hostinger mailbox changes.</mark>
* <mark style="color:blue;">If you miss an account, Exchange Online will bounce mail instead of delivering to Hostinger.</mark>



#### <mark style="color:blue;">The recommended setup for hybrid M365 ↔ Hostinger:</mark>

1. <mark style="color:blue;">Set your domain in M365 as</mark> <mark style="color:blue;"></mark><mark style="color:blue;">**Internal Relay**</mark><mark style="color:blue;">.</mark>
2. <mark style="color:blue;">Create a connector from</mark> <mark style="color:blue;"></mark><mark style="color:blue;">**Office 365 → Your organization’s email server**</mark> <mark style="color:blue;"></mark><mark style="color:blue;">pointing to Hostinger SMTP.</mark>
   * <mark style="color:blue;">That way, any non-M365 mailbox gets routed to Hostinger automatically.</mark>
{% endhint %}

## Set Up a Connector in Microsoft 365

We’ll configure Exchange Online to **route non-M365 mailboxes** to Hostinger.

1. Log in to the **Microsoft 365 Exchange Admin Center (EAC)** → https://admin.exchange.microsoft.com
2. Go to **Mail Flow → Connectors**.
3. Click **+ Add a connector**.
   * From: **Office 365**
   * To: **Your organization’s email server** → (this will be Hostinger)
   * Click **Next**.
4. Name the connector:
   * Example: `M365 to Hostinger Fallback`
5. Configure the connector to route to Hostinger’s SMTP servers:
   *   Hostinger typically uses:

       ```
       smtp.hostinger.com (TLS, port 587)
       ```
   * Or your custom Hostinger mail server for the domain (check in Hostinger panel).
6. Set **TLS encryption required**.
7. Validate the connector with a test mail flow.



## Configure Accepted Domains in Microsoft 365

Now, we need to tell M365 that not all mailboxes exist in Exchange Online.

1. In **Exchange Admin Center**, go to **Mail Flow → Accepted Domains**.
2. Select your domain (e.g., `example.com`).
3. Change the domain type from **Authoritative** → **Internal Relay**.

* **Authoritative**: M365 assumes all mailboxes for `example.com` exist in Exchange Online. If the mailbox is missing, the mail is bounced.
* **Internal Relay**: M365 first checks its own mailboxes; if the user does not exist, it routes the mail to another server (Hostinger, in this case).

{% hint style="success" %}
✅ With Internal Relay, emails to unknown mailboxes in M365 are sent to Hostinger via the connector.
{% endhint %}



## Test the Mail Flow

* Send an email to a mailbox hosted on M365 → It should deliver to the M365 inbox.
* Send an email to a mailbox that only exists in Hostinger → M365 will forward it to Hostinger via the connector.
* Check message trace in M365 Admin Center for debugging if needed.



## Summary

* **MX Record** → Points to M365.
* **Accepted Domain** → Set as Internal Relay.
* **Connector** → Configured from M365 → Hostinger.

This setup ensures:

* If the mailbox exists in M365 → Delivered there.
* If the mailbox does not exist in M365 → Routed to Hostinger.



{% hint style="warning" %}
**Note**: Ensure SPF/DKIM/DMARC records are updated for both M365 and Hostinger to avoid mail delivery issues or spam filtering.
{% endhint %}



***

## REFERENCES

* [https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail](https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail)
