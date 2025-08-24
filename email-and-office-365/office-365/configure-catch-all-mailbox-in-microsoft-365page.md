---
icon: gears
---

# Configure Catch all Mailbox in Microsoft 365Page

## Configure Catch all Mailbox in Microsoft 365

The catch all mailbox is a special mailbox that receives all the email messages that were sent to non-existing organization recipients. A catch all mailbox is an excellent solution to find out which messages are sent to your organization but were not received by the recipients. In this article, you will learn to configure catch all mailbox in the Exchange admin center (EAC).



## Table of contents

* [Catch all mailbox in Exchange Online](https://o365info.com/catch-all-mailbox/#h-catch-all-mailbox-in-exchange-online)
  * [Catch all mailbox risks](https://o365info.com/catch-all-mailbox/#h-catch-all-mailbox-risks)
  * [Authoritative vs. Internal Relay domain](https://o365info.com/catch-all-mailbox/#h-authoritative-vs-internal-relay-domain)
  * [Internal Relay](https://o365info.com/catch-all-mailbox/#h-internal-relay)
  * [Transport rule](https://o365info.com/catch-all-mailbox/#h-transport-rule)
* [How to configure catch all mailbox in Exchange Online](https://o365info.com/catch-all-mailbox/#h-how-to-configure-catch-all-mailbox-in-exchange-online)
  * [Step 1. Create shared mailbox](https://o365info.com/catch-all-mailbox/#h-step-1-create-shared-mailbox)
  * [Step 2. Create dynamic distribution group](https://o365info.com/catch-all-mailbox/#h-step-2-create-dynamic-distribution-group)
  * [Step 3. Convert domain to Internal Relay](https://o365info.com/catch-all-mailbox/#h-step-3-convert-domain-to-internal-relay)
  * [Step 4. Create mail flow transport rule](https://o365info.com/catch-all-mailbox/#h-step-4-create-mail-flow-transport-rule)
* [Verify catch all mailbox configuration](https://o365info.com/catch-all-mailbox/#h-verify-catch-all-mailbox-configuration)
* [Conclusion](https://o365info.com/catch-all-mailbox/#h-conclusion)



## Catch all mailbox in Exchange Online

The catch all mailbox in your Exchange Online server can benefit your organization. A catch-all mailbox collects any emails addressed to non-existent email addresses within the domain instead of bouncing them back to the sender as undeliverable. The catch-all mailbox routes any email sent to a non-existent or misspelled email address within the domain. This feature is particularly useful in preventing the loss of legitimate emails due to typos or misconfiguration.

An excellent way to understand the catch all mailbox is with an example outlined below.

Let’s say that the manager of our HR department has the following email address _**Amanda.Hansen@m365info.com**_. If someone sends an email message to this address _**Amanda.Heinz@m365info.com**_, the mail server (Exchange Online) will reject this message. The mail server will reply with a non-delivery report (NDR) to notify the source sender that there is no such recipient and that it could not deliver the message.

Microsoft sends a **How to Fix It** template in the NDR message.

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-NDR-.png" alt="Email message did not deliver NDR" height="869" width="1223"><figcaption></figcaption></figure>

To avoid the above scenario, you can configure the catch all mailbox that will accept all these email messages.

The Exchange administrator or another organization user will have access permission to that specific catch all mailbox. From time to time, they can look into the catch all mailbox and check for legitimate mail that was supposed to be sent to a specific recipient organization.

## Catch all mailbox risks

The catch all mailbox is not a supported solution by Microsoft 365. Therefore, Microsoft has not published formal information about the catch all mailbox feature. It’s to avoid the fact that the catch all mailbox can increase spam emails in Microsoft 365 mail server.\


{% hint style="warning" %}
**Note:** Exchange Online does not have the catch-all mailbox feature enabled by default.



**Note:** It’s important to understand that the catch all mailbox can’t be used or implemented in an Exchange Hybrid environment. But only on a “cloud only” environment, meaning the organization’s mail infrastructure is hosted only by Exchange Online, and no other mail infrastructure is involved.
{% endhint %}

## Authoritative vs. Internal Relay domain

Before we go through the steps, let’s explain why you must change the domain default settings from _Authoritative_ to _Internal Relay_.

When we register our public domain name in Microsoft 365, it’s considered an accepted domain. For this accepted domain, you can choose between two different authorities:

* **Authoritative:** Email is delivered only to valid recipients in this Exchange organization. All email for unknown recipients is rejected.
* **Internal Relay:** Email is delivered to recipients in this Exchange organization or relayed to an email server at another physical or logical location.

By default, the accepted domain is set to _Authoritative_. It means that the Exchange Online server has the authority of this accepted domain.

When someone sends an email from a registered public domain to a recipient’s email address, the Exchange Online server will first look into the _Global Address List (GAL)_. Exchange automatically creates this built-in list and includes every mail-enabled object in the Active Directory.



{% hint style="warning" %}
**Note:** If the recipient’s email address does not appear in the GAL, the Exchange Online server will reply with an NDR message. It will inform the source sender that the recipient does not exist.
{% endhint %}



## Internal Relay

To share the authority with the Exchange Online server and another mail server, you must configure **Internal Relay** for your accepted domain.

If someone sends an email from a registered public domain to a recipient’s email address, the Exchange Online server will go through the recipient list (GAL).

{% hint style="warning" %}
**Note:** If the recipient’s email address does not appear in the GAL, the Exchange Online server will forward the mail to the other mail server.
{% endhint %}



## Transport rule

Each time Exchange Online gets a request for delivering an email message to a non-existing Exchange Online recipient, it will look for the other mail infrastructure MX records by default.

To change this behavior, we must set up a transport rule in Exchange Online that will enforce Exchange Online to deliver the email message to the designated catch all mailbox.



## How to configure catch all mailbox in Exchange Online

To configure the catch all mailbox in Exchange admin center (EAC), we need to follow these steps:

1. Create a **shared mailbox** to catch all mailbox
2. Create a **dynamic distribution group**
3. Change accepted domain from Authoritative to **Internal Relay**
4. Create an Exchange Online **transport rule**



## Step 1. Create shared mailbox

The first step is to create a shared mailbox to use as the catch all mailbox. It is better to receive the non-existing emails of your domain in one mailbox.

We recommend creating a [shared mailbox](https://o365info.com/shared-mailbox-powershell-commands/) because of the following reasons:

* There are no licenses required
* Share with other members
* Assign _Send as_ or _Full Access_ permissions



If you already have a shared mailbox you want to use as the catch all mailbox, then you can skip this step.

Create a shared mailbox in Exchange admin center:

1. Sign in to [Exchange admin center](https://admin.cloud.microsoft/exchange#/)
2. Click **Recipients > Mailboxes**
3. Click **Add a shared mailbox**
4. Type **Display name** Catch All
5. Type **Email address** Catch.All
6. Select **Domain** m365info.com
7. Click **Create**

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-shared-1.png" alt="Create shared mailbox" height="553" width="1186"><figcaption></figcaption></figure>

{% hint style="warning" %}
**Note:** You will get a notification saying the shared mailbox was created. It may take a few minutes before you can add members. Close the pane.
{% endhint %}

Add members and assign permissions to the created shared mailbox:

8. Click on the created shared mailbox (**Catch All**) from the list
9. Select **Delegation**
10. Go to Read and manage (Full Access) > Click **Edit**



<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-shared-2.png" alt="assign full access permission shared mailbox" height="674" width="1175"><figcaption></figcaption></figure>

11. Click **Add members**

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-shared-3.png" alt="Add member to shared mailbox" height="674" width="1175"><figcaption></figcaption></figure>

12. **Select users**
13. Click **Save**

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-shared-4.png" alt="" height="674" width="1175"><figcaption></figcaption></figure>

14. Click **Confirm**
15. **Close** the pane

A notification will show that the mailbox permissions and selected users were added successfully. The changes are saved and will appear within minutes.

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-shared-5.png" alt="" height="664" width="1175"><figcaption></figcaption></figure>

If you want to add _Send as_ permission to users in the shared mailbox, you can follow the steps shown above.

## Step 2. Create dynamic distribution group

The next step is to create a dynamic distribution group including all the existing organization recipients. This is to let the catch all mailbox understand which email addresses already exist within the organization domain.

Create a dynamic distribution group in EAC:

1. Sign in to [Exchange admin center](https://admin.cloud.microsoft/exchange#/)
2. Click **Recipients > Groups**
3. Click **Add a group**

<figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-dynamic-distribution-1.png" alt="Create a dynamic distribution group in Exchange admin center" height="663" width="969"><figcaption></figcaption></figure>

\
Choose a group type.

4. Select **Dynamic distribution**
5. Click **Next**

<figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-dynamic-distribution-2.png" alt="Create a dynamic distribution group in Exchange admin center" height="810" width="1044"><figcaption></figcaption></figure>

Set up the basics.

6. Fill in the **Name**, e.g., _All Microsoft 365 recipients_
7. Click **Next**

<figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-dynamic-distribution-3.png" alt="Create a dynamic distribution group in Exchange admin center to catch all mailbox" height="724" width="1042"><figcaption></figcaption></figure>

\


Assign users.

8. Select **All recipient types**
9. Click **Next**

<figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-dynamic-distribution-4.png" alt="Create a dynamic distribution group in Exchange admin center" height="875" width="1328"><figcaption></figcaption></figure>



Edit settings.

10. Type the **email address**
11. Select the **domain**
12. Click **Next**

<figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-dynamic-distribution-5.png" alt="Create a dynamic distribution group in Exchange admin center" height="669" width="1040"><figcaption></figcaption></figure>

Review and finish adding the group.

13. Click **Create group**

<figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-dynamic-distribution-6.png" alt="Create a dynamic distribution group in Exchange admin center" height="787" width="1132"><figcaption></figcaption></figure>

The group _All Microsoft 365 recipients_ is created, but it isn’t ready to use yet.

14. Click **Close**

<figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-dynamic-distribution-7.png" alt="Create a dynamic distribution group in Exchange admin center" height="791" width="1194"><figcaption></figcaption></figure>

{% hint style="warning" %}
**Note:** It might take up to two hours to prepare the group for use.
{% endhint %}



## Step 3. Convert domain to Internal Relay

Convert the accepted domain default settings from Authoritative to Internal Relay by following the steps below.

1. Go to the **Exchange admin center**
2. Click **Mail flow > Accepted domains**
3. Click on the **default domain**

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-Internal-Relay-1.png" alt="Mail flow accepted domains internal relay" height="649" width="1354"><figcaption></figcaption></figure>

The accepted domain (m365info.com) pane opens.

4. Select **Internal Relay**
5. Select **Allow mail to be sent from this domain**
6. Click **Save**

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-Internal-Relay-2.png" alt="Internal Relay and Allow mail to be sent from this domain" height="689" width="1192"><figcaption></figcaption></figure>

\
You can see that the accepted default domain type has changed to Internal Relay.

{% hint style="warning" %}
**Note:** An organization with multiple public domain names in Microsoft 365 will need to change the default settings from _Authoritative_ to _Internal Relay_ to each of the domains separately.
{% endhint %}

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-Internal-Relay-3.png" alt="Mail flow accepted domains internal relay" height="650" width="1358"><figcaption></figcaption></figure>

To configure the catch all mailbox, we need to create a new rule in the next step.



## Step 4. Create mail flow transport rule

\
Time needed: 15 minutes

Create a new transport rule in Exchange admin center.

1.  **Go to the** [**Exchange admin center**](https://admin.cloud.microsoft/exchange#/)

    Click _Mail flow > Rules_\
    Click _Add a rule_\
    Select _Create a new rule_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-rule-1.png" alt=""><figcaption></figcaption></figure>
2.  **Set rule conditions**

    Type the name _Catch all rule_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-rule-2.png" alt=""><figcaption></figcaption></figure>
3.  **Apply this rule if**

    Select > _The sender_\
    Select > _is external/internal_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-rule-3.png" alt=""><figcaption></figcaption></figure>
4.  **Select sender location**

    Select > _Outside the organization_\
    Click _Save_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-rule-4.png" alt=""><figcaption></figcaption></figure>
5.  **Do the following**

    Select > _Redirect the message to_\
    Select > _these recipients_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-rule-5.png" alt=""><figcaption></figcaption></figure>
6.  **Select members**

    Search and select the created shared mailbox from the list\
    Click _Save_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-rule-6.png" alt=""><figcaption></figcaption></figure>
7.  **Except if**

    Select > _The recipient_\
    Select > _is a member of this group_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-rule-7.png" alt=""><figcaption></figcaption></figure>
8.  **Select members**

    Select the created dynamic distribution group > _All Microsoft 365 recipients_\
    Click _Save_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-rule-8.png" alt=""><figcaption></figcaption></figure>
9.  **Name and set conditions for your transport rule results**

    Click _Next_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-rule-9.png" alt=""><figcaption></figcaption></figure>
10. **Set rule settings**

    Leave the default settings & click _Next_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-rule-10.png" alt=""><figcaption></figcaption></figure>
11. **Review and finish**

    Click _Finish_\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-rule-11.png" alt=""><figcaption></figcaption></figure>
12. **Transport rule created successfully**

    Click _Done_ to close the pane\
    \


    <figure><img src="https://o365info.com/wp-content/uploads/2023/05/Catch-all-mailbox-rule-12.png" alt=""><figcaption></figcaption></figure>

\
The transport rule is disabled by default. Therefore you must go to the _Catch all_ rule you created. Select the new rule and set the toggle to **Enabled**. Wait a few minutes to update the changes.

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Catch-all-mailbox-rule-13.png" alt="Catch All transport rule enabled" height="794" width="1266"><figcaption></figcaption></figure>

\
You did configure the catch all mailbox rule, but we need to check if the catch all mailbox configuration works in the next step.



## Verify catch all mailbox configuration

Email a non-existing recipient from the internal domain _m365info.com_.

{% hint style="warning" %}
**Important:** Give it 15 minutes before you test the Catch all mailbox rule, as it needs time to propagate in the Exchange Online environment.
{% endhint %}

In our example, we will use Amanda’s (_Amanda.Morgan@m365info.com_) to send an email message to the following email address: _Unknown456@m365info.com_.

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Verify-catch-all-mailbox-outlook-web-1.png" alt="verify sent to catch all mailbox" height="507" width="1163"><figcaption></figcaption></figure>

You can see the email Amanda sent to the non-existing recipient _Unknown456@m365info.com_, but it was redirected and delivered to the Catch All shared mailbox.

When we open the folder **Catch All > Inbox**, we see the email message was delivered. Even though the email address did not belong to anyone from the recipient list (GAL), the email message was sent with the help of the mail flow transport rule.

<figure><img src="https://o365info.com/wp-content/uploads/2023/06/Verify-catch-all-mailbox-outlook-web-2.png" alt="verify sent to catch all mailbox" height="517" width="1501"><figcaption></figcaption></figure>

The table below shows where your email will be received if an internal (organization domain) or external (Hotmail, Gmail, or other domain) email address sends it.

| From     | To                         | **Receive**              |
| -------- | -------------------------- | ------------------------ |
| Internal | Existing email address     | Existing recipient       |
| Internal | Non-existing email address | Catch all shared mailbox |
| External | Existing email address     | Existing recipient       |
| External | Non-existing email address | Catch all shared mailbox |

You did successfully configure the catch all mailbox rule in Exchange admin center!



## Conclusion

You learned how to configure a catch all mailbox for your organization in Exchange admin center. It solves the problem of missing important emails because of spelling errors. Remember that this is not a solution for every organization, as it can cause an increase in spam emails. But it’s an excellent way to control every message sent to the organization that didn’t reach the recipient’s mailbox.

\




***

## REFERENCES

* [https://o365info.com/catch-all-mailbox/](https://o365info.com/catch-all-mailbox/)
