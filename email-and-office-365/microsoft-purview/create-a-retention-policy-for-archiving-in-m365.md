# Create a Retention Policy for Archiving in M365

## Create retention tags – rules for email archiving

1. Sign in to the [Microsoft Purview compliance portal](https://compliance.microsoft.com/) with an account belonging to an eligible role group (Global Administrator, Compliance Administrator, Organization Management, etc.).
2. In the navigation menu, go to **Data lifecycle management** > **Exchange (legacy)**, select the **MRM Retention tags** tab, and click **New tag** – a new retention tag wizard will open.

* Click **+ Add** → Choose **"Applied automatically to entire mailbox (default)"**
* **Name** it something like: `Move to Archive after 3 Months`
* Set **Retention action** to: `Move to Archive`
* Set **Retention period** to: `90 days` (approx. 3 months)
* Save

## Create a Retention Policy

* Go to **Retention Policies** → Click **+ Add**
* Name the policy: e.g., `Archive after 3 Months`
* Click **+ Add** to include the retention tag you just created
* Save the policy

## Apply the Policy to Users

Assign the new policy to user mailboxes:

* Go to **Recipients** → **Mailboxes**
* Select a mailbox → Under **Mailbox features** → **Retention Policy**, click **View details**
* Select the new policy you created



***

## REFERENCES

* [https://www.nucleustechnologies.com/how-to/setup-archive-and-deletion-policies-for-office-365-mailboxes.html](https://www.nucleustechnologies.com/how-to/setup-archive-and-deletion-policies-for-office-365-mailboxes.html)
* [https://www.codetwo.com/admins-blog/archive-policy-in-microsoft-365/](https://www.codetwo.com/admins-blog/archive-policy-in-microsoft-365/)
