---
icon: user
---

# Create a User in PostgreSQL

How to Create a User/Role in Postgres Using pgAdmin?

To create a user via pgAdmin, firstly, launch the pgAdmin, expand the “Servers” tree and follow the below-listed steps:

Step 1: Select Login/Group Roles

In pgAdmin, search for the “Login/Group Roles” under the “Servers” tree. Once you find the “Login/Group roles” option, right-click on it, then hover over the “Create” option and click on the “Login/Group Roles”:

<figure><img src="https://www.commandprompt.com/media/images/image_voXXVeM.width-1200.png" alt=""><figcaption></figcaption></figure>

Clicking on the “Login/Group roles” option will pop up a new window.

Step 2: Specify User’s Name

In the “Create-Login/Group roles” window, specify the name of the role:

<figure><img src="https://www.commandprompt.com/media/images/image_vh5PNKr.width-1200.png" alt=""><figcaption></figcaption></figure>

Step 3: Select Definition Tab

Now switch to the definition tab, and provide the password and its validity date:

<figure><img src="https://www.commandprompt.com/media/images/image_wOs2l1e.width-1200.png" alt=""><figcaption></figcaption></figure>

In the above snippet, we specified a password that will expire on “2022-12-31 11:59:00 +05:00”.

Step 4: Assign Privileges

Select the "Privileges" tab and select the attributes that you want to assign to the role:

<figure><img src="https://www.commandprompt.com/media/images/image_5NOQoZn.width-1200.png" alt=""><figcaption></figcaption></figure>

The above snippet indicates that the specified role is a superuser.

Step 5: Check SQL Query

To see the respective SQL query for the specified role, select the “SQL” tab:

<figure><img src="https://www.commandprompt.com/media/images/image_lflesww.width-1200.png" alt=""><figcaption></figcaption></figure>

Click on the Save button to create a user named “example\_role” with superuser privileges.

Step 5: Verify User’s Creation

Expand the “Login/Group roles” and search for the newly created user:

<figure><img src="https://www.commandprompt.com/media/images/image_jSM34kb.width-1200.png" alt=""><figcaption></figcaption></figure>

The output snippet authenticates that the user named “example\_role” has been created successfully.



***

## REFERENCES

* [https://www.commandprompt.com/education/how-to-create-a-user-in-postgresql/](https://www.commandprompt.com/education/how-to-create-a-user-in-postgresql/)
