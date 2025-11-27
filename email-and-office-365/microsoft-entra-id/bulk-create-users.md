---
icon: users
---

# Bulk create users

{% hint style="warning" %}
Microsoft Entra ID, part of Microsoft Entra, supports bulk user create and delete operations and supports downloading lists of users. Just fill out comma-separated values (CSV) template you can download from Microsoft Entra ID.
{% endhint %}

### Understand the CSV template <a href="#understand-the-csv-template" id="understand-the-csv-template"></a>

Download and fill in the bulk upload CSV template to help you successfully create Microsoft Entra users in bulk. The CSV template you download might look like this example:

<figure><img src="https://learn.microsoft.com/en-us/entra/identity/users/media/users-bulk-add/create-template-example.png" alt=""><figcaption></figcaption></figure>



{% hint style="danger" %}
**Warning**

If you are adding only one entry using the CSV template, you must preserve row 3 and add your new entry to row 4. Ensure that you add the `.csv` file extension and remove any leading spaces before `userPrincipalName`, `passwordProfile`, and `accountEnabled`.
{% endhint %}



## CSV template structure

The rows in a downloaded CSV template are as follows:

* **Version number**: The first row containing the version number must be included in the upload CSV.
* **Column headings**: The format of the column headings is <_Item name_> \[PropertyName] <_Required or blank_>. For example, `Name [displayName] Required`. Some older versions of the template might have slight variations.
* **Examples row**: We have included in the template a row of examples of acceptable values for each column. You must remove the examples row and replace it with your own entries.



## To create users in bulk

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [User Administrator](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#user-administrator).
2. Browse to **Entra ID** > **Users** > **Bulk create**.
3.  On the **Bulk create user** page, select **Download** to receive a valid comma-separated values (CSV) file of user properties, and then add users you want to create.



    <figure><img src="https://learn.microsoft.com/en-us/entra/identity/users/media/users-bulk-add/upload-button.png" alt=""><figcaption></figcaption></figure>
4.  Open the CSV file and add a line for each user you want to create. The only required values are **Name**, **User principal name**, **Initial password**, and **Block sign in (Yes/No)**. Then save the file.



    <figure><img src="https://learn.microsoft.com/en-us/entra/identity/users/media/users-bulk-add/add-csv-file.png" alt=""><figcaption></figcaption></figure>
5. On the **Bulk create user** page, under Upload your CSV file, browse to the file. When you select the file and select **Submit**, validation of the CSV file starts.
6. After the file contents are validated, you’ll see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.
7. When your file passes validation, select **Submit** to start the bulk operation that imports the new users.
8. When the import operation completes, you see a notification of the bulk operation job status.



{% hint style="warning" %}
If you experience errors, you can download and view the results file on the **Bulk operation results** page. The file contains the reason for each error. The file submission must match the provided template and include the exact column names. For more information about bulk operations limitations, see [Bulk import service limits](https://learn.microsoft.com/en-us/entra/identity/users/users-bulk-add#bulk-import-service-limits).
{% endhint %}



## Check status

You can see the status of all of your pending bulk requests in the **Bulk operation results** page.

<figure><img src="https://learn.microsoft.com/en-us/entra/identity/users/media/users-bulk-add/bulk-center.png" alt=""><figcaption></figcaption></figure>

Next, you can check to see that the users you created exist in the Microsoft Entra organization either in the Azure portal or by using PowerShell.<br>

## Verify users

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [User Administrator](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#user-administrator).
2. Select Microsoft Entra ID.
3. Select **All users** > **Users**.
4. Under **Show**, select **All users** and verify that the users you created are listed.



## Verify users with PowerShell

```powershell
Get-MgUser -Filter "UserType eq 'Member'"
```

<br>

***

## REFERENCES

* [https://learn.microsoft.com/en-us/entra/identity/users/users-bulk-add](https://learn.microsoft.com/en-us/entra/identity/users/users-bulk-add)
