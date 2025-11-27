---
icon: users
---

# Add several users at the same time to Microsoft 365

{% hint style="warning" %}
You can download [this sample spreadsheet](https://www.microsoft.com/download/details.aspx?id=45485) as a starting point. Remember that Microsoft 365 requires column headings in the first row so don't replace them with something else.<br>

**Save the file with a new name, and specify CSV format.**

<img src="https://learn.microsoft.com/en-us/microsoft-365/media/35a86ebe-63ab-4b4d-9a92-e177de33ebae.png?view=o365-worldwide" alt="An image of how to save a file in Excel in CSV format." data-size="original">

**When you save the file, you'll probably get a prompt that some features in your workbook will be lost if you save the file in CSV format. This is okay. Click Yes to continue.**

<img src="https://learn.microsoft.com/en-us/microsoft-365/media/51032a81-690c-45ef-bfc5-09ea7f790e98.png?view=o365-worldwide" alt="A picture of the prompt you might get from Excel asking if you really want to save the file as a CSV format." data-size="original">
{% endhint %}

### Add multiple users in the Microsoft 365 admin center <a href="#add-multiple-users-in-the-microsoft-365-admin-center" id="add-multiple-users-in-the-microsoft-365-admin-center"></a>

1. Sign in to Microsoft 365 with your work or school account.
2. In the admin center, choose **Users** > [**Active users**](https://go.microsoft.com/fwlink/p/?linkid=834822).
3. Select **Add multiple users**.
4. On the **Import multiple users** panel, you can optionally download a sample CSV file with or without sample data filled in.

{% hint style="warning" %}
Your spreadsheet needs to include the **exact same column headings** as the sample one (User Name, First Name, and so on). If you use the template, open it in a text editing tool, like Notepad, and consider leaving all the data in row 1 alone, and only entering data in rows 2 and below.

Your spreadsheet also needs to include values for the user name (like bob@contoso.com) and a display name (like Bob Kelly) for each user.
{% endhint %}

```console
User Name,First Name,Last Name,Display Name,Job Title,Department,Office Number,Office Phone,Mobile Phone,Fax,Alternate email address,Address,City,State or Province,ZIP or Postal Code,Country or Region
chris@contoso.com,Chris,Green,Chris Green,IT Manager,Information Technology,123451,123-555-1211,123-555-6641,123-555-6700,chris@contoso.com,1 Microsoft way,Redmond,Wa,98052,United States
```

1.  Enter a file path into the box, or choose **Browse** to browse to the CSV file location, then choose **Verify**.

    If there are problems with the file, the problem is displayed in the panel. You can also download a log file.
2. On the **Set user options** dialog you can set the sign-in status and choose the product license that will be assigned to all users.
3. On the **View your result** dialog you can choose to send the results to either yourself or other users (passwords will be in plain text) and you can see how many users were created, and if you need to purchase more licenses to assign to some of the new users.



***

## REFERENCES

* [https://learn.microsoft.com/en-us/microsoft-365/enterprise/add-several-users-at-the-same-time?view=o365-worldwide](https://learn.microsoft.com/en-us/microsoft-365/enterprise/add-several-users-at-the-same-time?view=o365-worldwide)
