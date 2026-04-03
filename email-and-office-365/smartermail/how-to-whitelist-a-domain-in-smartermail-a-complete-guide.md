---
icon: list
---

# How to Whitelist a Domain in SmarterMail: A Complete Guide

Email filtering is essential for protecting inboxes from spam, phishing, and malicious content. However, there are situations where legitimate emails may be mistakenly flagged as spam or blocked entirely. In such cases, whitelisting a domain in SmarterMail ensures that trusted senders can deliver messages reliably.

This guide explains what domain whitelisting is, why it matters, and how to properly configure it in SmarterMail.

***

### What Does Whitelisting a Domain Mean?

Whitelisting a domain means marking a specific domain (e.g., `example.com`) as a trusted sender. Once whitelisted, emails from that domain are allowed to bypass certain spam filters and are more likely to be delivered directly to the recipient’s inbox.

***

### Why Whitelist a Domain?

There are several common scenarios where whitelisting becomes necessary:

* Ensuring delivery of emails from trusted clients or partners
* Preventing important system or application emails from being blocked
* Allowing internal services or automated tools to send emails reliably
* Reducing false positives in spam filtering

***

### Methods to Whitelist a Domain in SmarterMail

SmarterMail provides multiple ways to whitelist domains, depending on your level of access and requirements.

***

#### 1. Server-Level Whitelisting (System Administrator)

This method provides the highest level of trust and is typically used for fully trusted sources.

**Steps:**

1. Log in to SmarterMail as a **System Administrator**
2. Navigate to **Security → Blacklist / Whitelist**
3. Select the **Whitelist** tab
4. Click **New**
5. Choose **Domain Name** as the source
6. Enter the domain (e.g., `example.com`)
7. Enable optional settings such as:
   * Bypass spam checks
   * Bypass greylisting
   * Bypass SMTP authentication (if required)
8. Save the configuration

**Use Case:**\
Best for trusted mail servers, gateways, or internal systems where strict filtering is unnecessary.

***

#### 2. Domain-Level Trusted Senders (Domain Administrator)

This is the safer and more commonly used method for general whitelisting.

**Steps:**

1. Log in as a **Domain Administrator**
2. Go to **Settings → Domain Spam Filtering**
3. Open the **Trusted Senders** section
4. Add the domain (e.g., `example.com`)
5. Save changes

**Use Case:**\
Ideal for allowing emails from clients, vendors, or third-party services while maintaining overall spam protection.

***

### Important Considerations

While whitelisting improves deliverability, it should be used carefully:

* **SPF, DKIM, and DMARC checks still apply:**\
  Whitelisting does not completely bypass authentication protocols.
* **Domains can be spoofed:**\
  Attackers can forge sender domains, so relying solely on domain-based trust can be risky.
* **IP whitelisting is more secure:**\
  If possible, whitelist the sending server’s IP address instead of just the domain.

***

### Best Practices

To maintain both security and deliverability, follow these recommendations:

* Prefer **Trusted Senders** over full server-level bypass unless absolutely necessary
* Use **IP whitelisting** for internal systems or known mail servers
* Regularly review whitelist entries to ensure they are still valid
* Monitor email headers and logs to troubleshoot delivery issues
* Avoid overusing bypass options, as they weaken spam protection

***

### Troubleshooting Whitelisting Issues

If emails are still being marked as spam after whitelisting:

* Verify that the correct domain or IP has been added
* Check email headers for spam scores and filtering reasons
* Ensure SPF, DKIM, and DMARC records are properly configured
* Confirm that no conflicting blacklist rules exist

***

### Conclusion

Whitelisting a domain in SmarterMail is a straightforward process that can significantly improve email reliability when configured correctly. By choosing the appropriate method—server-level or domain-level—and following best practices, administrators can strike the right balance between security and usability.

Always remember: whitelisting should be used selectively and monitored regularly to maintain a secure email environment.
