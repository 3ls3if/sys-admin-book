---
icon: key
---

# Setting up Email Signing (DKIM) for a Domain

Email Signing, also known as DKIM, is one way (along with SPF records) to verify the authenticity of a message and a sending domain, and can be used to protect recipients from phishing schemes or spam checks. It is a widely accepted security feature for email servers, one that all major providers (I.e., Gmail, Microsoft, etc.) now require when sending messages through their services.\
To enable and set up Email Signing for a domain, do the following:

1. Log in as a domain administrator.
2. Go to **Domain Settings**.
3. Go to the **General** settings page for the domain.
4. Look for the **Email Signing** card and click the **Enable** button. When you do, a modal window will appear that displays the default DKIM settings SmarterMail sets for the domain. While these can be edited, when initially setting up DKIM these settings are perfectly fine.
5. The **TXT Record Name** and **TXT Record Value** are the entries you will add as Text records to the DNS for your domain.  BE SURE TO SAVE THE SETTINGS IN THE MODAL before you close it. If you accidentally close the modal BEFORE saving, you can just click the Enable button again to get your TXT record values. If you close it after saving, but before you copy the TXT records, on the Email Signing card you can simply click the box that shows your DKIM selector. (It will be alphanumeric characters.\_domainKey on the card).&#x20;
6. Be sure to save the changes you've made on the page. Otherwise, you'll need to do all of this again.
7. Go ahead and add the TXT Record Name and TXT Record Value to your DNS, if you haven't already.
8. Once you've added these records to your DNS, you can then modify the Canonicalization settings and others, as needed. (Though, generally, the defaults are fine.)&#x20;
9. Again, if you've made additional changes, be sure to save this page before you move off of it.&#x20;

Please be aware that, even though DNS propagation is pretty fast these days, it make take awhile for those changes to take effect.

Once you're all set, you can use a tool like the [Domain Scanner at EasyDMARC](https://easydmarc.com/tools/domain-scanner) to check for any possible issues.

<br>

***

## REFERENCES

* [https://portal.smartertools.com/kb/a3711/setting-up-email-signing-dkim-for-a-domain.aspx](https://portal.smartertools.com/kb/a3711/setting-up-email-signing-dkim-for-a-domain.aspx)

