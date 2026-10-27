---
icon: question
---

# Why a True Hybrid Mail Setup Between Microsoft 365 and Hostinger Is Not Possible

### Introduction

Many organizations want to use both **Microsoft 365 (M365)** and **Hostinger Email Hosting** at the same time — often during a migration phase or to save costs by keeping some users on Hostinger and moving others to Microsoft 365.\
The goal seems simple:

> “Let Microsoft 365 handle some mailboxes and Hostinger handle the rest — under the same domain.”

However, while this is technically possible between **two enterprise-grade mail servers** (like Microsoft 365 + on-prem Exchange or Google Workspace), it is **not supported or feasible** between Microsoft 365 and **Hostinger’s shared email platform**.

Below we explain **why this limitation exists**, **what happens when you try**, and **what alternatives are available**.

***

### 1. How Hybrid Mail Normally Works

In a hybrid setup (like Exchange Online Hybrid), both systems:

* **Share a common directory** of all users and mailboxes
* Use **connectors** to route mail internally between systems
* Support **coexistence**, meaning users in both systems can send/receive seamlessly
* Use **custom routing rules** and **accepted domains** to decide where to deliver each message

This requires both mail systems to support **split delivery** or **domain-based routing** at a per-user level.

***

### 2. Hostinger’s Shared Email Service Does Not Support Split Delivery

Hostinger’s shared mail platform is designed for simplicity and affordability — not enterprise routing flexibility.\
Mail routing behavior is completely tied to the **domain’s MX record**.

* If your domain’s MX points to **Hostinger (mx1.hostinger.com)** → Hostinger accepts and delivers all mail locally.
* If your domain’s MX points to **Microsoft 365 (mail.protection.outlook.com)** → Hostinger will not accept any inbound mail for that domain.

There is **no option** in Hostinger’s control panel (hPanel) to override this or to tell Hostinger:

> “Deliver locally for some users, and route others to Microsoft 365.”

This is the critical missing feature needed for hybrid operation.

***

### 3. Why Mail Loops Occur When You Try to Combine Them

When you set MX to Microsoft 365 but still have Hostinger mailboxes, both systems will continuously hand messages back and forth.

Here’s what happens:

1. A message arrives for `user@domain.com`.
2. Microsoft 365 looks up the domain’s MX → sees itself → delivers locally (if mailbox exists).
3. If the user only exists in Hostinger, M365 forwards the mail to Hostinger using a connector.
4. Hostinger receives the message → checks the domain’s MX → sees it points back to M365 → sends it back.
5.  The process repeats until the message fails with:

    ```
    554 5.4.14 Hop count exceeded – possible mail loop
    ```

This error is precisely what you see when trying to force a hybrid setup between Microsoft 365 and Hostinger.

***

### 4. Hostinger’s Updated Policy (2024–2025)

As confirmed by Hostinger support, their mail system **no longer allows local delivery for domains whose MX points elsewhere.**

This means:

* If MX = Microsoft 365 → all mail is routed to Microsoft 365 (no exceptions).
* Local Hostinger mailboxes will not receive or deliver mail internally in that case.

This policy was introduced to simplify routing and reduce spam/backscatter issues but **eliminated the ability to do partial or hybrid mail routing**.

***

### 5. Why Microsoft 365 Can’t Fix It Either

Microsoft 365 is highly flexible, but it expects the **other mail system** (like an on-prem Exchange server) to support connectors and transport rules.\
Since Hostinger does not allow inbound connector configuration or routing rules, Microsoft 365 has no way to identify which users exist locally in Hostinger versus in the cloud.

M365 cannot “split” delivery if the external system (Hostinger) doesn’t respond properly to directory or transport requests.

***

### 6. The Only Supported Alternatives

There are only two practical, supported configurations:

#### 🅰️ Option 1: Full Migration to Microsoft 365

* Change your domain’s MX to Microsoft 365 (`domain-com.mail.protection.outlook.com`)
* Move all mailboxes to M365
* Disable Hostinger mail hosting

✅ This is the cleanest, most reliable solution.

***

#### 🅱️ Option 2: Temporary Forwarding Hybrid (Hostinger → M365)

* Keep MX pointing to Hostinger
* For migrated users, set up **forwarders** in Hostinger to send mail to their M365 mailbox\
  (e.g., `user@domain.com → user@domain.com.mail.onmicrosoft.com`)
* Keep local delivery for remaining Hostinger users

⚠️ This is **not a true hybrid** — it’s a one-way forwarding setup.\
Mail flow is asymmetric and requires manual management per user.

***

### 7. Why a True “M365 → Hostinger” Hybrid Will Never Work

A proper M365 → Hostinger hybrid would require:

* Directory synchronization between both systems
* A trusted mail connector between Hostinger and Exchange Online
* Hostinger’s ability to accept and route only certain users locally

Hostinger’s mail platform does not expose or support any of those capabilities.\
Therefore, a hybrid setup **from Microsoft 365 to Hostinger** is **technically impossible** and **not supported by either vendor**.

***

### 8. Conclusion

A hybrid mail setup between **Microsoft 365 and Hostinger** is **not feasible** because:

| Reason                    | Explanation                                         |
| ------------------------- | --------------------------------------------------- |
| No split-delivery support | Hostinger cannot route mail per user                |
| MX-dependent routing      | Hostinger bases all mail delivery on MX only        |
| No directory sync         | M365 cannot identify local vs cloud users           |
| Policy restriction        | Hostinger blocks local delivery when MX ≠ Hostinger |
| Loop risk                 | Causes 554 5.4.14 hop count exceeded errors         |

For stable and reliable mail flow, organizations must **choose one platform** for primary delivery.\
If coexistence is required temporarily, **use forwarders from Hostinger to M365**, not the other way around.

***

### 🔍 Recommended Reading

* [Microsoft Learn: Hybrid Exchange Deployment](https://learn.microsoft.com/en-us/exchange/exchange-hybrid)
* [Hostinger Help Center: How Email Routing Works](https://support.hostinger.com/)
* Microsoft 365 Mail Flow Configuration Docs
