---
icon: rotate
---

# How to Rotate IP Addresses in SmarterMail for Better Email Deliverability

### How to Rotate IP Addresses in SmarterMail for Better Email Deliverability

Managing email deliverability is critical for any organization that relies on consistent outbound communication. One effective way to protect sender reputation and reduce the risk of blacklisting is by rotating IP addresses. SmarterMail provides built-in functionality that allows administrators to distribute outgoing emails across multiple IPs, ensuring better performance and reliability.

This article walks you through the process of configuring SMTP outbound IP rotation in SmarterMail.

***

#### Why IP Rotation Matters

When all outbound emails are sent from a single IP address, that IP can quickly develop a poor reputation if flagged for spam or excessive volume. By rotating multiple IPs:

* You distribute sending load more evenly
* Reduce the risk of blacklisting
* Improve overall deliverability rates
* Maintain a healthier sender reputation

***

#### Step 1: Bind IP Addresses

Before configuring rotation, ensure that all desired IP addresses are properly bound to your server.

**Steps:**

1. Go to **Settings**
2. Navigate to **Bindings**
3. Select **IP Addresses**
4. Add and verify all IPs you want to include in rotation

This step ensures that SmarterMail recognizes and can use the IPs for outbound traffic.

***

#### Step 2: Configure SMTP Outbound IP Rotation

Once your IPs are bound, you can configure how SmarterMail rotates them.

**Steps:**

1. Go to **Settings**
2. Click on **Protocols**
3. Select **SMTP Out**
4. Locate the **Rotate IP List** section

Here, you can:

* Add or remove IP addresses from the rotation pool
* Control how SmarterMail selects which IP to use

***

#### Step 3: Set the Rotate List Fail Ratio

The **Rotate List Fail Ratio** determines when SmarterMail switches to another IP based on success and failure rates.

For example:

0.5

A value of 0.5 means that if 50% of attempts from an IP fail, SmarterMail will rotate to another IP in the list.

**Tips:**

* Lower values = faster switching (more aggressive rotation)
* Higher values = slower switching (more tolerance for failures)

Choose a value that balances stability and responsiveness.

***

#### Step 4: Bind Specific Domains to IPs (Optional)

If you want more granular control, you can assign specific domains to specific IP addresses.

**Steps:**

1. Navigate to **Manage**
2. Select **Domains**
3. Choose a domain
4. Go to the **Options** tab
5. Set **Outbound IPv4/IPv6** to:
   * A specific IP, or
   * **Automatic** (to use rotation settings)

This is useful for separating transactional and marketing emails across different IPs.

***

#### Step 5: Enable RBL Tracking (Optional)

Real-time Blackhole List (RBL) tracking helps monitor whether your IPs are being flagged.

**Steps:**

1. Go to the **Rotate IP List** tab
2. Configure **RBL Providers**
3. Enable tracking for your outbound IPs

With RBL tracking, SmarterMail can help identify problematic IPs and adjust rotation accordingly.

***

#### Best Practices

* Regularly monitor IP reputation and delivery reports
* Use warmed-up IPs for high-volume sending
* Avoid sudden spikes in email volume
* Combine IP rotation with proper authentication (SPF, DKIM, DMARC)

***

#### Conclusion

Configuring IP rotation in SmarterMail is a powerful way to improve email deliverability and protect your sender reputation. By distributing outgoing traffic across multiple IP addresses and monitoring performance through fail ratios and RBL tracking, you can create a more resilient and efficient email system.

Implement these steps carefully, and your outbound email infrastructure will be better equipped to handle both scale and reliability.
