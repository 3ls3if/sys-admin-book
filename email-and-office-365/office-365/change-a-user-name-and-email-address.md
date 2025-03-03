---
icon: rotate-reverse
---

# Change a user name and email address

## Change a user's email address

You must be a [user administrator](https://learn.microsoft.com/en-us/microsoft-365/admin/add-users/about-admin-roles?view=o365-worldwide#commonly-used-microsoft-365-admin-center-roles\&preserve-view=true).

1. In the admin center, go to the **Users** > [Active users](https://go.microsoft.com/fwlink/p/?linkid=834822) page.
2. Select the user's name, and then on the **Account** tab select **Manage username and email**.
3. In the first box, type the first part of the new email address. If you added your own domain to Microsoft 365, choose the domain for the new email alias by using the drop-down list. [Learn how to add a domain](https://learn.microsoft.com/en-us/microsoft-365/admin/setup/add-domain?view=o365-worldwide).
4. Select **Done**.

## Change a user's display name

You must be a [user administrator](https://learn.microsoft.com/en-us/microsoft-365/admin/add-users/about-admin-roles?view=o365-worldwide#commonly-used-microsoft-365-admin-center-roles\&preserve-view=true).

1. In the admin center, go to the **Users** > [Active users](https://go.microsoft.com/fwlink/p/?linkid=834822) page.
2. Select the user's name, and then on the **Account** tab select **Manage contact information**.
3. Update the user's name and contact information.
4.  Select **Save changes**.

    If you get the error message "**We're sorry, the user couldn't be edited. Review the user information and try again**, see [Resolve error messages](https://learn.microsoft.com/en-us/microsoft-365/admin/add-users/change-a-user-name-and-email-address?view=o365-worldwide#resolve-error-messages).

## Add an email alias

For more information on adding an email alias, see [Add another email alias for a Microsoft 365 business subscription user](https://learn.microsoft.com/en-us/microsoft-365/admin/email/add-another-email-alias-for-a-user?view=o365-worldwide).

## Set the primary email address

You must be an [Exchange administrator](https://learn.microsoft.com/en-us/microsoft-365/admin/add-users/about-exchange-online-admin-role?view=o365-worldwide).

1. In the admin center, go to the **Users** > [Active users](https://go.microsoft.com/fwlink/p/?linkid=834822) page.
2. Select the user's name, and then on the **Account** tab select **Manage email aliases**.
3. If you're adding a new email address, under **Aliases**, in the blank box, type the first part of the new email address. If you added your own domain to Microsoft 365, choose the domain for the new email alias by using the drop-down list and select **Add**.
4. Under **Aliases**, select the ellipses (...) next to the desired alias and then select **Change to primary email** for the email address that you want to set as the primary email address for that person.
5. Select **Save changes**, then **Close**
6. Give the person the following information:
   * This change could take a while.
   * Their new username. They need it to sign in to Microsoft 365.
   * If they're using Skype for Business Online, they must reschedule any Skype for Business Online meetings that they organized, and tell their external contacts to update their contact information.
   * If they're using OneDrive, the URL to this location has changed. If they have OneNote notebooks in their OneDrive, they might need to close and reopen them in OneNote. If they have shared files from their OneDrive, the links to the files might not work and the user can reshare.
   * If their password changed too, they're prompted to enter the new password on their mobile device, or it won't sync.

A person's previous primary email address is retained as an extra email address. **We strongly recommend that you don't remove the old email address.**

Some people might continue to send email to the person's old email address and deleting it might result in NDR failures. Microsoft automatically routes it to the new one. Also, don't reuse old SMTP email addresses and apply them to new accounts. This can also cause NDR failures or delivery to an unintended mailbox.
