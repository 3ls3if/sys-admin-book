---
icon: circle-user
---

# Setting up an email alias in SmarterMail

### **If You’re a Domain Admin**

An **alias** is an alternative email address that forwards mail to one or more existing mailboxes (it doesn’t have its own inbox).

#### 🔹 Step-by-Step:

1. **Log in to SmarterMail** as the **Domain Administrator.**
   * URL: typically something like `https://mail.yourdomain.com`
   * Use your admin credentials.
2. In the **left navigation pane**, click on **Domain Settings** (⚙️ icon).
3. Go to **Accounts → Aliases.**
4. Click the **➕ (New)** button to create a new alias.
5. Fill in the details:
   * **Alias Name:** the alias email address (e.g., `support@yourdomain.com`)
   * **Email Address(es):** one or more actual email addresses where incoming mail should be forwarded (e.g., `john@yourdomain.com, mary@yourdomain.com`)
   * Optionally, check **Enable alias** if there’s a toggle.
   * You can also choose whether replies come from the original sender’s address (depends on version).
6. Click **Save.**

✅ Done! The alias is now active. Any emails sent to the alias address will automatically be forwarded to the addresses you specified.

***

### **If You’re a System Admin (for multiple domains)**

1. Log in as **System Administrator.**
2. Go to **Manage → Domains.**
3. Select the specific domain.
4. Then follow the same steps as above under **Domain Admin** to add aliases for that domain.

***

### **Notes:**

* Aliases **don’t consume a license** (they’re not real mailboxes).
* You can assign multiple recipients to one alias.
* Aliases **can’t send emails**, only receive/forward them.
  * If you want users to _send as_ the alias, you’ll need to configure that in their email client (e.g., Outlook or webmail settings under “From” address).



***

## REFERENCES

* [https://help.smartertools.com/smartermail/current/topics/domainadmin/settings/aliases](https://help.smartertools.com/smartermail/current/topics/domainadmin/settings/aliases)
