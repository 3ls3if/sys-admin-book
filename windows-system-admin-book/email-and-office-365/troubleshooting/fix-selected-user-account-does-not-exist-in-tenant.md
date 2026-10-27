---
icon: users-slash
---

# Fix Selected user account does not exist in tenant

To resolve this issue, you need to add the user account as an external user in the tenant. This can be done by following these steps:

1. Log in to the Azure portal using an account that has the necessary permissions to add external users.
2. Navigate to the Azure Active Directory blade.
3. Click on the 'Users' blade.
4. Click on the 'New guest user' button.
5. Fill in the required details for the new user and invite them to the tenant.
6. Once the user has accepted the invitation and their account has been created in the tenant, they should be able to access the application using their account.

{% hint style="warning" %}
Note that adding external users to a tenant may have certain security and compliance implications, so you should ensure that you have the necessary policies and procedures in place to manage external access to your tenant and applications.
{% endhint %}

