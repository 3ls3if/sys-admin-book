---
icon: user
---

# Create and configure a user in MSSQL

## Create and configure a user in MSSQL

Use the following steps to create and configure a user in MSSQL®:

1. <mark style="color:green;">Open the Microsoft ®</mark> <mark style="color:green;"></mark><mark style="color:green;">**SQL Server® Management Studio**</mark> <mark style="color:green;"></mark><mark style="color:green;">(SSMS).</mark>
2. <mark style="color:green;">Connect to SQL Server by using your login information.</mark>
3. <mark style="color:green;">In the left-hand panel, expand</mark> <mark style="color:green;"></mark><mark style="color:green;">**Security > Logins**</mark><mark style="color:green;">.</mark>
4. <mark style="color:green;">Right-click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Logins**</mark> <mark style="color:green;"></mark><mark style="color:green;">and select</mark> <mark style="color:green;"></mark><mark style="color:green;">**New Login**</mark> <mark style="color:green;"></mark><mark style="color:green;">from the drop-down menu.</mark>
5.  <mark style="color:green;">Assign a login name and select the authentication method and default database or language.</mark>

    <mark style="color:green;">If you are using SQL authentication, you must enter an initial password and choose the</mark>\ <mark style="color:green;">enforcement options for password policy and expiration as well as whether or not the user</mark>\ <mark style="color:green;">needs to change their password when they log in.</mark>



    <figure><img src="https://assets.docs.rackspace.com/support/how-to/cloud-servers/create-and-configure-a-user-in-mssql/ssmsnewlogin1.png" alt=""><figcaption></figcaption></figure>
6. I<mark style="color:green;">n the left-hand panel, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Server Roles**</mark> <mark style="color:green;"></mark><mark style="color:green;">to assign any server roles you want</mark>\ <mark style="color:green;">this user to have, including</mark> <mark style="color:green;"></mark><mark style="color:green;">**bulkadmin**</mark><mark style="color:green;">,</mark> <mark style="color:green;"></mark><mark style="color:green;">**dbcreator**</mark><mark style="color:green;">,</mark> <mark style="color:green;"></mark><mark style="color:green;">**public**</mark><mark style="color:green;">, and so on.</mark>
7.  <mark style="color:green;">In the left-hand panel, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Securables**</mark> <mark style="color:green;"></mark><mark style="color:green;">and then click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Search**</mark><mark style="color:green;">.</mark>

    <mark style="color:green;">The</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add Objects**</mark> <mark style="color:green;"></mark><mark style="color:green;">dialog box displays, where you can choose specific objects, objects of a</mark>\ <mark style="color:green;">certain type, or the server itself. Select one and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark><mark style="color:green;">.</mark>
8.  <mark style="color:green;">On the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Securables**</mark> <mark style="color:green;"></mark><mark style="color:green;">page, select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Grant**</mark><mark style="color:green;">,</mark> <mark style="color:green;"></mark><mark style="color:green;">**With Grant**</mark><mark style="color:green;">, or</mark> <mark style="color:green;"></mark><mark style="color:green;">**Deny**</mark> <mark style="color:green;"></mark><mark style="color:green;">as necessary for any of the</mark>\ <mark style="color:green;">objects in the explicit box.</mark>

    <mark style="color:green;">**Grant**</mark> <mark style="color:green;"></mark><mark style="color:green;">gives access to the securable,</mark> <mark style="color:green;"></mark><mark style="color:green;">**With Grant**</mark> <mark style="color:green;"></mark><mark style="color:green;">allows the user to grant access to the</mark>\ <mark style="color:green;">securable, and</mark> <mark style="color:green;"></mark><mark style="color:green;">**Deny**</mark> <mark style="color:green;"></mark><mark style="color:green;">expressly denies permission to the securable no matter what roles or</mark>\ <mark style="color:green;">permissions the user might have.</mark>



    <figure><img src="https://assets.docs.rackspace.com/support/how-to/cloud-servers/create-and-configure-a-user-in-mssql/ssmsnewlogin3.png" alt=""><figcaption></figcaption></figure>
9. <mark style="color:green;">In the left-hand panel, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Status**</mark> <mark style="color:green;"></mark><mark style="color:green;">to grant or deny permission to the database engine,</mark>\ <mark style="color:green;">enable or disable the login, and to unlock the account should it get</mark>\ <mark style="color:green;">locked out.</mark>

When you have finished modifying the settings, click **OK** to create the user and exit the new login creation window.[\
](https://docs.rackspace.com/edit/create-and-configure-a-user-in-mssql)

***

## REFERENCES

* [https://docs.rackspace.com/docs/create-and-configure-a-user-in-mssql](https://docs.rackspace.com/docs/create-and-configure-a-user-in-mssql)



