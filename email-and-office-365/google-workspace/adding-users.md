---
icon: users
---

# Adding Users

## Adding Users

For people in your organization to use your Google Workspace services, you must give each person a **user account** and a **Google Workspace license**. An account gives each user:

* A name and password for signing in to Google services.
* An email address at any of your domains (if you're using Gmail).&#x20;
* A profile or contact name, which you can easily change later.

{% hint style="success" %}
**Users can be added in two ways:**

* **One at a time:** This is the easiest way to add users if you don’t have a large team. This method can only be used to add new users and identifies whether a username you want to create matches an existing account.&#x20;
* **In bulk:** You can add up to 150,000 users at once by uploading their names in a CSV file.
{% endhint %}

***



## Exercise directions: Part 1

**Add Alex Bell**



**Step 1**

If you are not already signed in, sign in to your domain as the Administrator at [admin.google.com](http://admin.google.com/).



**Step 2**

From the main menu, navigate to **Directory**, then click **Users**.\


**Step 3**

Click **Add new user**.



**Step 4**

In the dialog box that appears, create your company's IT Manager user account as follows:

* First name: **Alex**
* Last name: **Bell**
* Primary email: **alex.bell@yourdomain**



**Tip:** If your account has multiple domains associated with it, you will see a domain list so you can choose the correct domain for each new user. The domain is the part of the user's email address that appears after the @ symbol.



* Each user is assigned to an organizational unit. At this stage of the course, we have just one single top level organization, so Alex will be placed into that organization by default. We will discuss organizational structure later in this course.
* Leave the secondary email and phone number fields empty.
* You can assign a temporary, randomly generated password or manually enter a temporary password. Note: Passwords must be at least 8 characters long and cannot exceed 100 characters. Either way, it’s best practice to ensure that the new user changes this when signing in for the first time so ensure that 'Ask for a password change at next sign in' is enabled. For this exercise, allow Google Workspace to generate the temporary password.\


**Step 5**

Click **ADD NEW USER** to create Alex's account.



Congratulations! You've added your first user in your new domain.\


Notice the eye icon in the dialog box. This allows you to see the temporary password generated. You can also copy the password to your clipboard using the **COPY PASSWORD** link.&#x20;



From here, you can use the **PREVIEW AND SEND** button to email sign in instruction



**Step 6**

Click **DONE**.



***



## Exercise directions: Part 2

**Add the list of users in bulk**



**Step 1**

If you are not already signed in, sign in to your domain as the Administrator at [admin.google.com](http://admin.google.com/).



**Step 2**

From the main menu, navigate to **Directory**, then click **Users**.\


**Step 3**

Click **Bulk update users**, and then click **DOWNLOAD BLANK CSV TEMPLATE**. This will download a blank file with all the required columns to your local machine. Leave this dialog box open to upload the file after editing.  \


**Step 4**

Open the CSV file in a spreadsheet application or a text editor if you prefer.\


**Step 5**

Populate the file with a row for each user using the information from the table Alex provided.\


The file contains a column for each attribute that appears on the user profile in the admin console and in Gmail contacts.\


The following columns are mandatory:

* First Name
* Last Name
* Email Address
* Password (enter hellohello1)
* Org Unit Path (For this exercise, enter the forward slash symbol / into this column. This represents the root organization.)

If you prefer, you can use the example CSV file below as your starting point. Simply edit this file, and change the domain part of the email address to match your domain:

[users-for-upload.csv](https://storage.googleapis.com/cloud-training/T-INTROD-B/users-for-upload.csv)\


**Step 6**

Save a copy of your own file or the users-for-upload.csv file to your local machine. Alternatively, if you have created your own file in Google Sheets, click **File**, then **Download As**, and **Comma Separated Values (.csv, current sheet)**.



**Step 7**

Return to the **Bulk update users** dialog box. Click **ATTACH CSV FILE** and browse to your file, then click **UPLOAD** to initiate the creation of the user accounts.

* If your file has formatting errors, a warning prompts that you may need to re-edit the file.
* If successful, the upload progress will be reported in the Tasks list at the top of the page. You'll also receive an email report later.



**Step 8**

The new users may take a couple of minutes to appear in the user list. If you don’t see them right away, try refreshing the screen. Review the list of users and explore the user settings.



