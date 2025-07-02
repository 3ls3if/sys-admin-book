---
icon: bucket
---

# Bulk Delete Users

{% hint style="warning" %}
Using the admin center in Microsoft Entra ID, part of Microsoft Entra, you can remove a large number of members to a group by using a comma-separated values (CSV) file to bulk delete users.
{% endhint %}

## To bulk delete users

1. <mark style="color:green;">Sign in to the</mark> [<mark style="color:green;">Microsoft Entra admin center</mark>](https://entra.microsoft.com/) <mark style="color:green;">as at least a</mark> [<mark style="color:green;">User Administrator</mark>](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#user-administrator)<mark style="color:green;">.</mark>
2. <mark style="color:green;">Select Microsoft Entra ID.</mark>
3.  <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Users**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**All users**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Bulk operations**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Bulk delete**</mark><mark style="color:green;">.</mark>



    <figure><img src="https://learn.microsoft.com/en-us/entra/identity/users/media/users-bulk-delete/users-bulk-delete.png" alt=""><figcaption></figcaption></figure>
4. <mark style="color:green;">On the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Bulk delete user**</mark> <mark style="color:green;"></mark><mark style="color:green;">page, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Download**</mark> <mark style="color:green;"></mark><mark style="color:green;">to download the latest version of the CSV template.</mark>
5. <mark style="color:green;">Open the CSV file and add a line for each user you want to delete. The only required value is</mark> <mark style="color:green;"></mark><mark style="color:green;">**User principal name**</mark><mark style="color:green;">. Save the file.</mark>
6. <mark style="color:green;">On the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Bulk delete user**</mark> <mark style="color:green;"></mark><mark style="color:green;">page, under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Upload your csv file**</mark><mark style="color:green;">, browse to the file. When you select the file and select submit, validation of the CSV file starts.</mark>
7. <mark style="color:green;">When the file contents are validated, you’ll see</mark> <mark style="color:green;"></mark><mark style="color:green;">**File uploaded successfully**</mark><mark style="color:green;">. If there are errors, you must fix them before you can submit the job.</mark>
8. <mark style="color:green;">When your file passes validation, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Submit**</mark> <mark style="color:green;"></mark><mark style="color:green;">to start the bulk operation that deletes the users.</mark>
9. <mark style="color:green;">When the deletion operation completes, you see a notification that the bulk operation succeeded.</mark>



## CSV template structure

The rows in the example downloaded CSV template below are as follows:

* <mark style="color:green;">**Version number**</mark><mark style="color:green;">: The first row containing the version number must be included in the upload CSV.</mark>
* <mark style="color:green;">**Column headings**</mark><mark style="color:green;">:</mark> <mark style="color:green;"></mark><mark style="color:green;">`User name [userPrincipalName] Required`</mark><mark style="color:green;">. Older versions of the template might vary.</mark>
* <mark style="color:green;">**Examples row**</mark><mark style="color:green;">: We have included in the template an example of an acceptable value.</mark> <mark style="color:green;"></mark><mark style="color:green;">`Example: chris@contoso.com`</mark> <mark style="color:green;"></mark><mark style="color:green;">You must remove the example row and replace it with your own entries.</mark>

<figure><img src="https://learn.microsoft.com/en-us/entra/identity/users/media/users-bulk-delete/delete-csv-file.png" alt=""><figcaption></figcaption></figure>



## Check status

You can see the status of all of your pending bulk requests in the **Bulk operation results** page.

<figure><img src="https://learn.microsoft.com/en-us/entra/identity/users/media/users-bulk-delete/bulk-center.png" alt=""><figcaption></figcaption></figure>

Next, you can check to see that the users you deleted exist in the Microsoft Entra organization either in the portal or by using PowerShell.



## Verify deleted users

1. <mark style="color:green;">Sign in to the</mark> [<mark style="color:green;">Microsoft Entra admin center</mark>](https://entra.microsoft.com/) <mark style="color:green;">as at least a</mark> [<mark style="color:green;">User Administrator</mark>](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#user-administrator)<mark style="color:green;">.</mark>
2. <mark style="color:green;">Select Microsoft Entra ID.</mark>
3. <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**All users**</mark> <mark style="color:green;"></mark><mark style="color:green;">only and verify that the users you deleted are no longer listed.</mark>



***

## REFERENCES

* [https://learn.microsoft.com/en-us/entra/identity/users/users-bulk-delete](https://learn.microsoft.com/en-us/entra/identity/users/users-bulk-delete)
* [https://www.manageengine.com/microsoft-365-management-reporting/kb/how-to-bulk-delete-users-in-entra-id.html](https://www.manageengine.com/microsoft-365-management-reporting/kb/how-to-bulk-delete-users-in-entra-id.html)
