---
icon: ban
---

# Block Access to the Control Panel for All Users

## Block Access to the Control Panel for All Users

First, open the group policy management console.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/gpo-management-console.webp" alt="open group policy management console" height="604" width="326"><figcaption></figcaption></figure>

Find the organizational unit that contains your user accounts, for me, this is my “ADPRO Users” OU.

Right-click the OU and select “**Create a GPO in this domain, and Link it here**“

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/create-new-user-gpo.webp" alt="create a new gpo" height="507" width="664"><figcaption></figcaption></figure>

Give the new GPO a name. For example, User – Block Control Panel.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/name-new-gpo.webp" alt="name gpo" height="210" width="432"><figcaption></figcaption></figure>

At this point, there is a new GPO linked to all the users but the GPO has no policies set. Right-click on the GPO and select edit.

Browse to **User Configuration -> Policies -> Administrative Templates -> Control Panel**

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/gpo-user-policy-admin-control-panel.webp" alt="gpo block access to control panel" height="337" width="840"><figcaption></figcaption></figure>

Right-click the policy and select “Edit”.

Change the policy setting to “Enabled” and click “OK”.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/enabl-gpo-control-panel-setting.webp" alt="enable the gpo setting" height="404" width="804"><figcaption></figcaption></figure>

To verify the GPO is working, reboot a computer and log in with a domain user account.

When you try to open the control panel you should get a pop up message like the one below.

<figure><img src="https://activedirectorypro.com/wp-content/uploads/2022/09/control-panel-blocked-message.webp" alt="control panel restrictions block message" height="404" width="804"><figcaption></figcaption></figure>

Remember this was a user configuration and only applies when a user logs into the computer. In the next example, I’ll go over a computer GPO.
