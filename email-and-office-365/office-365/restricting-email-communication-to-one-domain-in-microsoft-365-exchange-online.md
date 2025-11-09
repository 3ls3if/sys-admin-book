---
icon: tablets
---

# Restricting Email Communication to One Domain in Microsoft 365 (Exchange Online)

#### Objective

Allow **`cart@example.in`** to **send and receive emails only** to/from **`@icicibank.com`**.\
All other email communications (inbound or outbound) should be blocked.

***

#### Steps to Configure in Exchange Admin Center (EAC)

**1. Login**

* Go to [https://admin.exchange.microsoft.com](https://admin.exchange.microsoft.com)
* Sign in with your admin credentials.

***

**2. Go to Mail Flow**

* Navigate to **Mail flow** → **Rules**.

***

**3. Create a New Rule for Inbound Mail (Receiving)**

* Click **“Add a rule” → “Create a new rule”**.

**Name:**\
`Allow only icicibank.com to send to cart@example.in`

**Apply this rule if...**

* _The recipient is_ → `cart@example.in`

**Do the following...**

* _Reject the message with the explanation:_\
  “This mailbox accepts mail only from @icicibank.com domain.”

**Except if...**

* _The sender domain is_ → `icicibank.com`

**Mode:**

* Enforce (Active)

Save the rule.

***

**4. Create a New Rule for Outbound Mail (Sending)**

* Click **Add a rule** again.

**Name:**\
`Allow cart@example.in to send only to icicibank.com`

**Apply this rule if...**

* _The sender is_ → `cart@example.in`

**Do the following...**

* _Reject the message with the explanation:_\
  “This mailbox is restricted to send only to @icicibank.com domain.”

**Except if...**

* _The recipient domain is_ → `icicibank.com`

**Mode:**

* Enforce

Save the rule.

***

**5. Test**

* Try sending an email from `cart@example.in` to:
  * ✅ `user@icicibank.com` → Should go through.
  * ❌ `user@gmail.com` → Should be rejected.
* Test inbound by sending:
  * ✅ From `user@icicibank.com` → Should arrive.
  * ❌ From `user@yahoo.com` → Should bounce with your custom error.

***

**6. Optional: Audit & Documentation**

* Record the rule names and descriptions.
* Note the date/time of implementation.
* Optionally, export the rules from Exchange Admin Center for backup.

***

#### Summary

| Direction | Allowed Domain   | Blocked    | Mailbox Affected  |
| --------- | ---------------- | ---------- | ----------------- |
| Inbound   | `@icicibank.com` | All others | `cart@example.in` |
| Outbound  | `@icicibank.com` | All others | `cart@example.in` |
