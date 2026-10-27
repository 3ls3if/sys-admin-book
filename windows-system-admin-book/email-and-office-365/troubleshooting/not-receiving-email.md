---
icon: circle-exclamation
---

# Not receiving email

{% hint style="success" %}
If you're waiting for an important email that hasn't arrived, noticing a lack of messages in your inbox, or your colleague's getting an error after trying to send a message to you, we've got you covered. If your Microsoft 365 account isn't receiving email, let's troubleshoot by walking through some common issues.
{% endhint %}

## Check that your email is still active

If there was an issue with your billing or if your email account was deleted, you will not receive email.

1. Go to your [Email & Office Dashboard](https://www.godaddy.com/en-in/help/access-my-email-office-dashboard-26409).
2. Under **Users**, check if your email account is listed. You might need to scroll down to see **Users**. If your account is not listed, you can [restore the user](https://www.godaddy.com/en-in/help/restore-microsoft-365-user-email-accounts-40160) or [purchase a new plan](https://godaddy.com/email).



## Check your DNS

When someone sends you a message, your email server is identified using your domain name, which must be translated into an IP address through DNS to deliver the message. Your MX, or Mail Exchanger, records determine how your domain manages email delivery. If there's an issue with the MX records on your DNS, you won't receive email.

1. <mark style="color:green;">Go to your</mark> [<mark style="color:green;">Email & Office Dashboard</mark>](https://www.godaddy.com/en-in/help/access-my-email-office-dashboard-26409)<mark style="color:green;">.</mark>
2. <mark style="color:green;">(Optional) At the top of your dashboard, if you see a banner saying that your email can't receive mail yet, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Help me fix this**</mark><mark style="color:green;">. Skip steps 3-5 and follow the on-screen prompts.</mark>
3. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Users**</mark><mark style="color:green;">, next to your account, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Manage**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Setup**</mark><mark style="color:green;">, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Recheck DNS**</mark><mark style="color:green;">.</mark>
5. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Recheck DNS**</mark><mark style="color:green;">. If there’s an issue with your DNS,</mark> [<mark style="color:green;">update your MX records</mark>](https://www.godaddy.com/en-in/help/edit-an-mx-record-19235)<mark style="color:green;">.</mark>

If your domain is with another company, contact them for help [updating your MX records](https://www.godaddy.com/en-in/help/set-mail-destination-for-my-domain-at-another-company-9216) with them or [transfer your domain to GoDaddy](https://www.godaddy.com/en-in/help/transfer-my-domain-to-godaddy-1592).



## Check if there’s an issue with your email client

**Check if you're receiving email, but it's not showing up in your client**

1. <mark style="color:green;">Sign in to</mark> [<mark style="color:green;">Outlook on the web</mark>](https://outlook.office.com/mail/inbox)<mark style="color:green;">. Use your Microsoft 365 email address and password.</mark>
2. <mark style="color:green;">Check for new messages in your inbox.</mark>
3. <mark style="color:green;">(Optional) Send yourself an email from a different account to see if it's delivered in Outlook on the web.</mark>
4. <mark style="color:green;">If you see new messages in Outlook on the web but not on your client, try to</mark> [<mark style="color:green;">set up your email</mark>](https://www.godaddy.com/en-in/help/update-my-email-settings-to-exchange-32395) <mark style="color:green;">on your client again.</mark>

{% hint style="warning" %}
&#x20;**Required:** If you're currently using POP settings, data like your messages, folders, calendars and contacts only exist on your email client and the device you use to check your email. Before switching to Exchange settings, back up your data so you can either import it into your account or reference it later. For instructions, please refer to your client provider.
{% endhint %}

**Check if your email client is using POP or IMAP settings**

You might be impacted by Microsoft's retirement of POP and IMAP settings for Microsoft 365 email accounts. If you're using POP or IMAP settings, your account's data only exists on your email client and the device you use to check your email. [Update your email client to Exchange settings](https://productivity.godaddy.com/app/basicauthupdate/#/).

**Check if you’re using a supported email client with modern authentication**

Microsoft is no longer supporting older versions of email clients and has disabled Basic authentication. Make sure you're using a supported email client that is using modern authentication. Check Microsoft's [list of changes](https://learn.microsoft.com/en-us/deployoffice/endofsupport/microsoft-365-services-connectivity) that may affect your client.



## Check with the sender if there was an error

If the sender entered your email address incorrectly, it may prevent the message from being delivered. If they received a bounceback or error after sending the message, [try to resolve it](https://www.godaddy.com/en-in/help/what-does-my-email-bounce-mean-3568). You can also try sending yourself a message from a different email account to see if you get an error.



## Check if mail is going to spam or junk folders

Make sure your email is not being caught by a filter that's sending it to your spam or junk folder.

1. <mark style="color:green;">Sign in to</mark> [<mark style="color:green;">Outlook on the web</mark>](https://outlook.office.com/mail/inbox)<mark style="color:green;">. Use your Microsoft 365 email address and password (your GoDaddy username and password won't work here).</mark>
2. <mark style="color:green;">In the upper-right corner, select</mark> ![Settings gear button](https://images.ctfassets.net/7y9uzj0z4srt/5rWTJR2201WXR1lF0cUuZ8/289aeeb7ae5fbc1ab0db6ad150f589bd/image-article-2863-01.png) <mark style="color:green;">**Settings**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Mail**</mark><mark style="color:green;">, and then</mark> <mark style="color:green;"></mark><mark style="color:green;">**Junk email**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Blocked senders and domains**</mark><mark style="color:green;">, next to the sender you want to receive mail from, select</mark> ![Trash can button](https://images.ctfassets.net/7y9uzj0z4srt/1Sc15uOezDR8ycJTMinVNk/c81532af4758a63eaed13b4e82558300/image-article-2863-02.png) <mark style="color:green;">**Delete**</mark><mark style="color:green;">.</mark>
5. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Filters**</mark><mark style="color:green;">, clear any checkboxes for ones that you no longer want.</mark>
6. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Save**</mark><mark style="color:green;">.</mark>



## Check your mailbox rules

Make sure you don't have any rules preventing you from receiving email.

1. <mark style="color:green;">Sign in to</mark> [<mark style="color:green;">Outlook on the web</mark>](https://outlook.office.com/mail/inbox)<mark style="color:green;">. Use your Microsoft 365 email address and password.</mark>
2. <mark style="color:green;">In the upper-right corner, select</mark> ![Settings gear button](https://images.ctfassets.net/7y9uzj0z4srt/5rWTJR2201WXR1lF0cUuZ8/289aeeb7ae5fbc1ab0db6ad150f589bd/image-article-2863-01.png) <mark style="color:green;">**Settings**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Mail**</mark><mark style="color:green;">, and then</mark> <mark style="color:green;"></mark><mark style="color:green;">**Rules**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Remove any rules you no longer want by selecting</mark> ![Trash can button](https://images.ctfassets.net/7y9uzj0z4srt/1Sc15uOezDR8ycJTMinVNk/c81532af4758a63eaed13b4e82558300/image-article-2863-02.png) <mark style="color:green;">**Delete**</mark><mark style="color:green;">, and then</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>



## Check your storage capacity

Make sure your storage isn't too full and preventing you from receiving new email.

1. <mark style="color:green;">Sign in to</mark> [<mark style="color:green;">Outlook on the web</mark>](https://outlook.office.com/mail/inbox)<mark style="color:green;">. Use your Microsoft 365 email address and password.</mark>
2. <mark style="color:green;">In the upper-right corner, select</mark> ![Settings gear button](https://images.ctfassets.net/7y9uzj0z4srt/5rWTJR2201WXR1lF0cUuZ8/289aeeb7ae5fbc1ab0db6ad150f589bd/image-article-2863-01.png) <mark style="color:green;">**Settings**</mark><mark style="color:green;">.</mark>
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**General**</mark><mark style="color:green;">, and then</mark> <mark style="color:green;"></mark><mark style="color:green;">**Storage**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Next to the folder you want to empty, select</mark> ![trash can empty folder button](https://images.ctfassets.net/7y9uzj0z4srt/73vXPcpZQBNx6tDj5KaYjJ/cf830791ada72c29797c13f6ce821a4a/image-article-2863-03.png) <mark style="color:green;">**Empty**</mark><mark style="color:green;">, and then</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>

To keep all of your content, [upgrade to a plan with more storage](https://www.godaddy.com/en-in/help/upgrade-my-email-plan-32048).







