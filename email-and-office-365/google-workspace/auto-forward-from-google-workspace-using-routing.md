---
icon: forward
---

# Auto-forward From Google Workspace Using Routing

## Auto-forward From Google Workspace Using Routing

Using routing at Google Workspace (formerly known as G Suite) allows you to redirect an email address to Help Scout without going to a Gmail inbox first. This eliminates the need for an additional user at Google Workspace for that address.&#x20;

Keep in mind that means you will not have a persistent copy of the email in a Gmail inbox and you cannot apply conditional forwarding — it's all or nothing when using routing. If you want to keep a copy of your email at Gmail or want to only forward certain emails, you'll want to set up [traditional forwarding](https://docs.helpscout.com/article/54-g-suite) instead.&#x20;

{% hint style="warning" %}
**Note:** [Google Workspace's log search tool](https://support.google.com/a/answer/2618874?hl=en) allows you to reference routed emails for up to 30 days if you find you need to trace anything!
{% endhint %}

1\.  You can head right to the Default routing settings for your Gmail service here: [https://admin.google.com/ac/apps/gmail/defaultrouting](https://admin.google.com/ac/apps/gmail/defaultrouting) Make sure you are logged in as the Google Workspace administrator. Forward these instructions to your Google Workspace admin if that isn't you!

Alternatively, you can log in to the [Google Admin Panel](http://admin.google.com/), then click on **Apps**. Choose **Google Workspace > Gmail > Default routing.**&#x20;

<figure><img src="https://d33v4339jhl8k0.cloudfront.net/docs/assets/524448053e3e9bd67a3dc68a/images/5ff6ac6ffd168b77735325e3/file-GlVzFjrQsT.gif" alt=""><figcaption></figcaption></figure>

2 Click **ADD ANOTHER RULE**.

![](https://d33v4339jhl8k0.cloudfront.net/docs/assets/524448053e3e9bd67a3dc68a/images/5ff6ad3db5efec03af3f0bbf/file-HzuYpNgBfm.png)

3 Under  _1. Specify envelope recipients to match_, select **Single Recipient**, then type the email address you're redirecting to Help Scout into the **Email address:** field.

![](https://d33v4339jhl8k0.cloudfront.net/docs/assets/524448053e3e9bd67a3dc68a/images/5ff6c35eb5efec03af3f0bee/file-vrixT853LB.png)

4 Under _2. If the envelope matches the above, do the following_, select the option to **Modify Message**, and scroll down to the _Envelope recipient_ header. Check the **Change Envelope Recipient** box. In the **Replace Recipient** option, enter the Help Scout Inbox address. This is the address you find in the Inbox settings, ending in either helpscout.net or helpscoutapp.com.&#x20;

![](https://d33v4339jhl8k0.cloudfront.net/docs/assets/524448053e3e9bd67a3dc68a/images/5ff6c36cb5efec03af3f0bef/file-YLNekAeHOM.png)

_Optional_: We recommend also checking **Bypass spam filter for this message** under the Spam header in this section. Google will not route email its filter designates as spam otherwise, which can result in valid email not reaching your Help Scout Inbox without any warning to your team. Help Scout's spam filter will still apply when the emails reach your Inbox. See [Manage Spam and Unwanted Email](https://docs.helpscout.com/article/307-manage-spam-and-unwanted-email) for more.

![](https://d33v4339jhl8k0.cloudfront.net/docs/assets/524448053e3e9bd67a3dc68a/images/61f4106d39e5d05141b641fd/file-wu6LAikglf.png)

5 Finally, under _3. Options_ check the **Perform this action on non-recognized and recognized addresses** option and select **Save**. You're all set on the Google side!

![](https://d33v4339jhl8k0.cloudfront.net/docs/assets/524448053e3e9bd67a3dc68a/images/5ff6c432551e0c2853f39fc3/file-dWU2z5Dyon.png)

6&#x20;

Next steps: Set up [DKIM](https://docs.helpscout.com/article/666-use-dkim-to-help-with-email-delivery) to allow Help Scout servers to send email on your behalf. This step is important to help with email deliverability, so don't skip it!&#x20;



***

## REFERENCES

* [https://docs.helpscout.com/article/1330-auto-forward-from-google-workspace-using-routing](https://docs.helpscout.com/article/1330-auto-forward-from-google-workspace-using-routing)
