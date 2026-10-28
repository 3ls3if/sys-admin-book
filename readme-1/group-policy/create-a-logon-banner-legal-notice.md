---
icon: square-exclamation
---

# Create a Logon Banner (Legal Notice)

## Create a Logon Banner (Legal Notice)

In this example, you will create a new GPO that presents a banner message to users before logging into a computer. Many organizations require this for legal purposes. This will be a computer configuration GPO.

First, determine the OU that contains the computers you want the policy applied to. In my domain, all computers are located in the “ADPRO Computers” OU, all sub-OUs will inherit this policy.

Right-click the OU and select **Create a GPO in this domain, and link it here**.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/new-gpo-example2.webp" alt="create a computer gpo" height="404" width="804"><figcaption></figcaption></figure>

Give the new GPO a name, for example Computer – Logon Banner.

Browse to **Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Local Policies – > Security Options.**

On the right open the policy “Interactive logon: Message title for users attempting to log on”.

<figure><img src="data:image/svg+xml,%3Csvg%20xmlns=&#x27;http://www.w3.org/2000/svg&#x27;%20width=&#x27;936&#x27;%20height=&#x27;430&#x27;%20viewBox=&#x27;0%200%20936%20430&#x27;%3E%3C/svg%3E" alt="interactive logon title gpo" height="430" width="936"><figcaption></figcaption></figure>

Now select “**Define this policy setting” and enter your message**. This message is often provided by HR or your legal department.

<figure><img src="data:image/svg+xml,%3Csvg%20xmlns=&#x27;http://www.w3.org/2000/svg&#x27;%20width=&#x27;421&#x27;%20height=&#x27;515&#x27;%20viewBox=&#x27;0%200%20421%20515&#x27;%3E%3C/svg%3E" alt="define the gpo policy" height="515" width="421"><figcaption></figcaption></figure>

Next, open the policy “**Interactive logon: Message title for users attempting to log on**” and enter a title for the banner.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/gpo-logon-message-title.webp" alt="enter message title for gpo" height="509" width="421"><figcaption></figcaption></figure>

Next, reboot a computer, and when you logon you should be prompted with the GPO logon banner message.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/test-gpo-logon-banner.webp" alt="windows 10 logon banner example" height="404" width="804"><figcaption></figcaption></figure>

<br>
