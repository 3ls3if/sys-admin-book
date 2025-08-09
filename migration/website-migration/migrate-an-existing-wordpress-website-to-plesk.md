---
icon: wordpress
---

# Migrate an existing WordPress website to Plesk

## What you need before you get started?

* A copy of all the files for your WordPress website, if they are archived in a zipped folder it will be easier to upload.
* Export a copy of your database.
  * Install [WP Migrate DB](https://wordpress.org/plugins/wp-migrate-db/)
  * Follow the instructions for the plugin to export your database with the **correct domain name**
* You’ll need access to your new Plesk account on our cloud hosting.



## Upload Your Files

1\. Log in to Plesk Control Panel. [Click here](https://eggplantdigital.cn/kb/how-do-i-login-to-my-plesk-control-panel-account/) if you are not sure how to do that.

2\. Go to “Files” in the left side menu, open the “httpdocs” folder. This is the folder that holds the website files that will be shown at www.your-domain.com.

![](https://eggplant.b-cdn.net/wp-content/uploads/2021/09/file-manager-httpdocs.jpg)

3\. When your hosting account it created, a basic WordPress installation is installed. But as you are installing an existing WordPress site, you can delete all these files.

4\. If you are sure, go a head and delete these files, or move the files to a sub-folder.

In the screenshot below, we have moved all the files to a sub-folder called “old\_files”

![](https://eggplant.b-cdn.net/wp-content/uploads/2021/09/plesk-move-old-files.gif)

5\. Upload your zipped folder for your WordPress website files to the “httpdocs” folder. Select the folder and click “Archive” > “Extract Files” to unzip the folder.

6\. After unzipping, if your WordPress files are all in a sub-folder, select all the files and use the “Move” button to move them all the “httpdocs” folder.\


## Setting Up Your Database

1\. Click on the lefthand menu “Databases”

![](https://eggplant.b-cdn.net/wp-content/uploads/2021/09/plesk-setting-up-database.jpg)

2\. You may see an existing database here already. Click the “Add Database” button.

3\. Fill in the details:

* **Database name:** give the database a unique name.
* **Related site**: select your website from the list.
* **Database user name:** give the user a unique name.
* **Password**: click the “Generate” button, and then “Show” button.
* Optional – allow this user to access all databases within the selected subscription.
* Before you click “OK”, make sure you have copied all this information to a text document, we’ll need to use it in a moment.
* Click “OK”

![](https://eggplant.b-cdn.net/wp-content/uploads/2021/09/plesk-add-a-database.jpg)

4\. Import your database file. After the successful importing of the database, you can double check it by clicking “phpMyAdmin” to view all the database tables.

![](https://eggplant.b-cdn.net/wp-content/uploads/2021/09/plesk-import-db-dump.jpg)

5\. Click “Files” on the lefthand side menu. Go to “httpdocs”. Click on “wp-config.php” to edit the file.

![](https://eggplant.b-cdn.net/wp-content/uploads/2021/09/plesk-files-edit-wp-config-1.jpg)

6\. In your “wp-config.php” fill in all the database details you copied down from step 3:

1. Database Name
2. Database User
3. Database Password
4. Database Hostname should be set to “localhost” or “localhost:3306”

![](https://eggplant.b-cdn.net/wp-content/uploads/2021/09/plesk-files-add-wp-config-details.jpg)

7\. Now you should be ready to view your website, visit your domain name to see your migrated site.\


***

## REFERENCES

* [https://eggplantdigital.cn/kb/how-do-i-migrate-an-existing-wordpress-website-to-plesk/](https://eggplantdigital.cn/kb/how-do-i-migrate-an-existing-wordpress-website-to-plesk/)
