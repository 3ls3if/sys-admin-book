---
icon: paperclip
---

# Increasing Email Attachment Limits in Microsoft 365: A Complete Guide for Administrators

## Increasing Email Attachment Limits in Microsoft 365: A Complete Guide for Administrators

Email remains a critical communication tool in modern organizations, but attachment size limits can often become a bottleneck—especially when sharing large files. By default, Microsoft 365 enforces a message size limit of approximately 25 MB to 35 MB. However, administrators have the flexibility to increase this limit up to 150 MB per email, providing greater convenience for users who need to share larger documents.

This article explains how to increase attachment limits in Microsoft 365, along with key considerations and best practices.

***

### Understanding Attachment Size Limits

In Microsoft 365, the maximum email size includes both the message body and attachments. While administrators can configure the limit up to 150 MB (153600 KB), it’s important to understand that attachments are encoded during transmission, typically increasing their size by around 30%. This means a file that appears to be 115 MB locally may exceed the limit once sent.

***

### Steps to Increase Attachment Limits (Admin Only)

To adjust the message size restriction for a specific mailbox, follow these steps:

1. **Access the Exchange Admin Center**
   * Log in to the Microsoft 365 admin portal.
   * Navigate to the Exchange Admin Center.
2. **Go to Mailbox Settings**
   * Select **Recipients** from the menu.
   * Click on **Mailboxes**.
3. **Select the User Mailbox**
   * Choose the mailbox for which you want to increase the limit.
4. **Modify Message Size Restrictions**
   * Open mailbox settings.
   * Locate and click **Manage message size restriction**.
5. **Set the Maximum Size**
   * Enter the desired limit (up to 153600 KB, which equals 150 MB).
   * Save your changes.

***

### Important Considerations

#### 1. Total Message Size Matters

The configured limit applies to the entire email, not just the attachment. Encoding overhead can cause messages to exceed the limit even if the original file appears smaller.

#### 2. Recipient Limitations

Even if your organization allows 150 MB emails, the recipient’s email system may have stricter limits. This can result in delivery failures.

#### 3. Performance and Reliability

Larger emails may take longer to send and receive, and they can increase the risk of timeouts or failures, especially on slower networks.

***

### Recommended Alternative: Use Cloud Sharing

For files larger than 150 MB—or when reliability is critical—it’s best to avoid attachments altogether. Instead:

* Upload files to OneDrive or SharePoint
* Generate a secure sharing link
* Send the link via email

This approach offers several benefits:

* No size limitations (within storage quotas)
* Faster delivery
* Better version control and collaboration
* Enhanced security with permission settings

***

### Best Practices

* Keep attachment sizes as small as possible using compression tools.
* Use cloud storage for large or frequently updated files.
* Educate users about attachment limits and alternatives.
* Regularly review organizational policies to balance usability and performance.

***

### Conclusion

Increasing the email attachment limit in Microsoft 365 can improve user productivity, but it should be done thoughtfully. While the platform allows up to 150 MB per message, practical constraints such as encoding overhead and recipient limits still apply. Leveraging cloud-based file sharing solutions remains the most efficient and scalable approach for handling large files.

By combining proper configuration with smart usage practices, organizations can ensure seamless and reliable communication.
