---
icon: play-pause
---

# Run a message trace in the Exchange admin center

{% hint style="success" %}
A message trace will show email sent into, out of, and within an email [organization](https://www.godaddy.com/en-in/help/what-are-linked-domains-in-an-organization-41309), which means you can track what happens to all emails involving your users and if they were successfully delivered.
{% endhint %}

1. Sign in to the [Exchange admin center](https://admin.exchange.microsoft.com/#/homepage). Use your Microsoft 365 email address and password.
2.  Select **Mail flow** > **Message trace**.\


    <figure><img src="https://images.ctfassets.net/7y9uzj0z4srt/2aC6FVR3w5zTNQmase7XcN/97e5b318f0f78ce6894e2087288cfd25/image-article-41252-01.png" alt=""><figcaption></figcaption></figure>
3. Select **+ Start a trace**. The message trace page will open.
4. Filter messages by senders or recipients:
   * To find messages sent _by_ a user, select or enter their email address under **Senders**.
   * To find messages sent _to_ a user, select or enter their email address under **Recipients**.
   *

       <figure><img src="https://images.ctfassets.net/7y9uzj0z4srt/1tV6zbXMggrSM9SCbiZXTs/a85af403371bd5e120e052a5846c7fa1/Screen_Shot_2022-06-22_at_9.19.06_AM.png" alt=""><figcaption></figcaption></figure>
5.  Under **Time range**, use the slider to select a time range of up to **10** days.\


    <figure><img src="https://images.ctfassets.net/7y9uzj0z4srt/7dpwxSN9e169Y0N1Bd5gbi/b1dbd8973db859d4c4d750ae3f245177/image-article-41252-02.png" alt=""><figcaption></figcaption></figure>
6.  Under **Report type**, select **Summary report**.\


    <figure><img src="https://images.ctfassets.net/7y9uzj0z4srt/5tiputKtmwfYcPZ9fsAmQv/b2e4478bc1b450090b1c031c7357f116/image-article-41252-03.png" alt=""><figcaption></figcaption></figure>
7. To run the report, select **Search**. The **Message trace search results** will open.

Next to each message, you can verify its delivery status, including **Delivered**, **Failed**, **Pending**, and **Filtered as spam**.

* **Delivered**: The message was successfully delivered to the intended destination.
* **Pending**: The message is being attempted or re-attempted to be delivered. The status might be unknown.
* **Quarantined**: The message was quarantined. This might happen if it’s been identified as spam, bulk, or phishing.
* **Filtered as spam**: The message was identified as spam and was rejected or blocked (but not quarantined).

### Related step

* After running a message trace, [view the details](https://www.godaddy.com/en-in/help/view-message-trace-details-41307) of each message to see what happened to it.

### More info

* [I’m not receiving email](https://www.godaddy.com/en-in/help/im-not-receiving-email-2863)
* [Fix Microsoft 365 email not working](https://www.godaddy.com/en-in/help/fix-microsoft-365-email-not-working-19308)
