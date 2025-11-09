---
icon: tablets
---

# Restricting Email Communication to One Domain in Google Workspace (Gmail)

#### Objective

Allow **`cart@example.in`** to **send and receive emails only** with the domain **`icicibank.com`**.\
Block all other inbound and outbound email communication.

***

#### Steps to Configure in Google Admin Console

**1. Login**

* Go to [https://admin.google.com](https://admin.google.com)
* Sign in with your **super admin** account.

***

**2. Open Gmail Settings**

* Navigate to:\
  **Apps → Google Workspace → Gmail → Compliance**

***

#### INBOUND Restriction (Receiving emails)

**3. Add a Routing Rule**

* Scroll down to **Routing** section.
* Click **“Configure”** (or **“Add Another”** if rules already exist).

**Name:**\
`Allow inbound only from icicibank.com (cart@example.in)`

**Emails to affect:**

* Choose **Inbound**, **Internal - receiving**, and **Outbound (optional)** if needed.

**Envelope recipient:**

* Specify → `cart@example.in`

**Add Expression:**

* _If the sender’s domain is not_ → `icicibank.com`

**Action:**

* **Reject the message**.
* Add a custom rejection notice, e.g.\
  `"This mailbox only accepts messages from @icicibank.com."`

**Save** the rule.

***

#### OUTBOUND Restriction (Sending emails)

**4. Create another rule under Outbound**

* Go to: **Apps → Google Workspace → Gmail → Compliance**
* Scroll down to **“Outbound” section** and click **“Configure”**.

**Name:**\
`Allow outbound only to icicibank.com (cart@example.in)`

**Emails to affect:**

* Choose **Outbound** and **Internal - sending**.

**Envelope sender:**

* Specify → `cart@example.in`

**Add Expression:**

* _If the recipient’s domain is not_ → `icicibank.com`

**Action:**

* **Reject the message**.
* Add a rejection notice, e.g.\
  `"This mailbox is restricted to send only to @icicibank.com domain."`

**Save** the rule.

***

#### 5. Verify & Test

* From `cart@example.in`, send:
  * ✅ To `user@icicibank.com` → should succeed.
  * ❌ To `user@gmail.com` → should be rejected.
* From an external account:
  * ✅ From `user@icicibank.com` → should arrive.
  * ❌ From `user@yahoo.com` → should be rejected with your custom message.

***

#### Summary Table

| Direction | Allowed Domain   | Blocked    | Affected User     |
| --------- | ---------------- | ---------- | ----------------- |
| Inbound   | `@icicibank.com` | All others | `cart@example.in` |
| Outbound  | `@icicibank.com` | All others | `cart@exmaple.in` |

***

#### Notes & Best Practices

* These rules apply **only to the specified user** (`cart@example.in`).
* Be careful if multiple routing rules exist — Google Workspace processes them in order.
* Always **save and test** after changes.
* Consider documenting the setup for audit purposes.
