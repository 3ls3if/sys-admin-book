---
icon: folder-open
---

# How to Use the File Manager - Plesk

## How to Use the File Manager

The file manager is used to upload, remove and organize all website files.

1.  Click **Websites and Domains**.&#x20;

    ![Plesk Websites \&Domains](https://content.hostgator.com/img/plesk18_websites_and_domains.png)
2.  Click on the **File Manager** icon.

    ![Plesk File Manager](https://content.hostgator.com/img/plesk18_file_manager.png)
3.  Navigate to the **httpdocs** directory. (The httpdocs is the same public\_html folder in cPanel. This is where the files are stored.)

    ![Plesk httpdocs](https://content.hostgator.com/img/plesk18_httpdocs.png)



***

## How to add and remove a directory

1. Log in to **Plesk**.
2.  In the Websites & Domains section, navigate to the **File Manager.**

    ![Plesk File manager](https://content.hostgator.com/img/plesk_file_manager_icon.png)
3.  To create a new directory, click the **+** symbol to expand the options.

    ![Plesk expand options](https://content.hostgator.com/img/plesk_file_manager_add_icon.png)
4.  From the dropdown, select the **"Create a Directory"** from the list.

    ![Create a Directory](https://content.hostgator.com/img/plesk18_create_new_directory.png)
5.  Type in the **directory** name and click **OK**. This creates the directory and will automatically direct you inside the directory.

    ![Create a Directory popup](https://content.hostgator.com/img/plesk18_create_directory_popup.png)
6.  If you need to remove a directory, click the check box and hit **Remove**.

    ![Remove Directory](https://content.hostgator.com/img/plesk18_remove_directory.png)
7.  Check the **confirm removal** check box and press **Yes.**

    ![Confirm removal of a directory](https://content.hostgator.com/img/plesk18_confirm_directory_removal.png)



***

How to create a new file\



1. Log in to **Plesk**.
2.  In the Websites & Domains section,  navigate to the **File Manager.**

    ![Plesk File manager](https://content.hostgator.com/img/plesk_file_manager_icon.png)
3.  To create a new file, click the **+** symbol to expand the options.

    ![Add Option Plesk](https://content.hostgator.com/img/plesk18_add_button.png)
4.  &#x20;Select C**reate a file** from the options.

    ![Plesk create file](https://content.hostgator.com/img/plesk18_create_file.png)
5.  Enter the file name you wish to create, then click **OK.**

    ![Create file prompt](https://content.hostgator.com/img/plesk18_create_a_file_popup.png)



***

## How to upload a new file

1. Log in to **Plesk**.
2.  In the Websites & Domains section,  navigate to the **File Manager.**

    ![Plesk File manager](https://content.hostgator.com/img/plesk_file_manager_icon.png)
3.  To create a new file, click the **+** symbol to expand the options.

    ![Add Option Plesk](https://content.hostgator.com/img/plesk18_add_button.png)
4.  &#x20;Select **Upload File** from the options.

    ![Upload a file option](https://content.hostgator.com/img/plesk18_upload_file_option.png)
5. Click on **Choose File.**
6. Browse for the file you want to upload and click **Open,** and then **OK.**



***

## How to change the file permissions

1.  Click on the dropdown on the right side of the file you wish to modify.

    ![Change File Permission](https://content.hostgator.com/img/plesk_change_file_permission.png)
2.  On the dropdown, select **Change Permissions.**

    ![Changing file permission](https://content.hostgator.com/img/plesk18_change_file_permissions.png)
3. Then click on Save.



***

## **Changing the maximum upload file size**

{% hint style="warning" %}
Please note that the following steps are only applicable to Windows VPS/ Dedicated Servers..
{% endhint %}

The maximum file size depends on the Plesk PHP settings in your server. These files can be uploaded via the File Manager.

**Setting the maximum size of a file size limit**

1. Locate the .ini file by opening the /usr/local/psa/admin/conf/php.ini.
2. Set the desired value of the upload\_max\_filesize and post\_max\_size.
3. Run the etc/init.d/psa restart command to restart the webserver.

**Reminder:** that the changes affect both the provider and all customers as it is a server-wide change.



***

## REFERENCES

* [https://www.hostgator.com/help/article/how-to-use-the-file-manager-plesk](https://www.hostgator.com/help/article/how-to-use-the-file-manager-plesk)
