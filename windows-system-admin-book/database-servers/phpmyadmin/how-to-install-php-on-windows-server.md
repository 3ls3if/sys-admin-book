---
icon: windows
---

# How to install PHP on Windows Server

### How to install PHP on Windows Server.

For all of the following steps, it is assumed that the IIS, PHP, and MySQL programs are already installed and running.

Let's get started with the installation.

1\. In the folder C:\inetpub\wwwroot, create a folder called phpmyadmin

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/01/image-20230702024817-2.jpg" alt=""><figcaption></figcaption></figure>

2\. Go to  [Download phpMyAdmin](https://www.phpmyadmin.net/downloads/)  and download the multi-language package \*.all-languages.zip

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/01/image-20230702024533-1.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

3\. Unzip the downloaded archive into the previously created folder C:\inetpub\wwwroot\phpmyadmin

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/01/image-20230702025958-3.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

4\. Installation is complete. Open the page http://localhost/phpmyadmin/, you should see the standard phpmyadmin panel login form

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/10/image-20230710232928-2.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

4.1 _Installation Note._

At this point, when you open the page http://localhost/phpmyadmin/, the following errors may occur:

4.1.1 Error 1. Handler not found. The error page looks like this:

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/10/image-20230710233412-3.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

Solution: create a php file handler for the web server. The screenshots below show how this can be done.



***

### How to configure PHP on Windows Server.

### &#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/10/image-20230710235854-9.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/10/image-20230710234120-5.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

4.1.2 Error 2. PHP extension (module) not found. For example, mysqli (as in the screenshot)

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/10/image-20230710234515-6.jpg" alt=""><figcaption></figcaption></figure>

Solution: enable the required extension in the php.ini file and restart the IIS web server. The php.ini file is located in the folder where PHP  was previously installed (in our example it is C:\php\\). To enable the extension you need, you need to find it by name in the php.ini file and uncomment (remove the ;; character from the beginning of the line) the line with the extension name.

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/10/image-20230710235207-7.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

After saving the php.ini file, you must restart the web server

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/07/10/image-20230710235419-8.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

5\. In the root phpmyadmin folder, you need to find the config.sample.inc.php file and rename it to config.inc.php. Next, open config.inc.php in Notepad or another text editor (Notepad++ is recommended) and uncomment (remove the // characters from the beginning of the line) the following lines:

> $cfg\['Servers']\[$i]\['pmadb'] = 'phpmyadmin';\
> $cfg\['Servers']\[$i]\['bookmarktable'] = 'pma\_\_bookmark';\
> $cfg\['Servers']\[$i]\['relation'] = 'pma\_\_relation';\
> $cfg\['Servers']\[$i]\['table\_info'] = 'pma\_\_table\_info';\
> $cfg\['Servers']\[$i]\['table\_coords'] = 'pma\_\_table\_coords';\
> $cfg\['Servers']\[$i]\['pdf\_pages'] = 'pma\_\_pdf\_pages';\
> $cfg\['Servers']\[$i]\['column\_info'] = 'pma\_\_column\_info';\
> $cfg\['Servers']\[$i]\['history'] = 'pma\_\_history';\
> $cfg\['Servers']\[$i]\['table\_uiprefs'] = 'pma\_\_table\_uiprefs';\
> $cfg\['Servers']\[$i]\['tracking'] = 'pma\_\_tracking';

&#x20;

In addition, replace the word localhost with 127.0.0.1\
&#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801130509-1.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

Save the config.inc.php file.

&#x20;

6\. In your browser, go to http://127.0.0.1/phpmyadmin and log in with the root user credentials whose password was created during installation on the MySQL server.

&#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801130741-2.jpg" alt=""><figcaption></figcaption></figure>

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801130813-3.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

7\. To store service information, phpmyadmin uses its own database, which we will now create. We will also create a user with full rights to this database.\
To create the database, we will use a ready dump provided by the developers in the file create\_tables.sql. This file is located in the sql subfolder. To import this dump, from the main phpmyadmin page, go to the Import tab

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801131700-4.jpg" alt=""><figcaption></figcaption></figure>

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801131802-5.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

select the file create\_tables.sql

&#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801132321-1.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

Click the Import button (at the very bottom of the form) and wait for the database import to complete.

The phpmyadmin database should now appear in the list

.

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801132350-2.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

Now let's create a MySQL account and grant permissions to the database we just created. To do this, go to the phpmyadmin database and click on Privileges - Add user / Add user account&#x20;

&#x20;

&#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801132438-3.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

Fill in the form fields as indicated in the screenshot

&#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801132524-4.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

In the config.inc.php file, you need to uncomment the lines and write the access data of the previously created user pma

&#x20;

> $cfg\['Servers']\[$i]\['controluser'] = 'pma';\
> $cfg\['Servers']\[$i]\['controlpass'] = 'pmapass';

&#x20;

pmapass is the password for user pma

&#x20;

<figure><img src="https://dx86q6oq7ry0e.cloudfront.net/uploads/media/blog/a55%40server-panel.net/2023/08/01/image-20230801132630-5.jpg" alt=""><figcaption></figcaption></figure>

&#x20;

In this article we learned how to install phpmyadmin on Windows Server.&#x20;



***

## REFERENCES

* [https://zomro.com/blog/faq/367-how-to-install-and-configure-phpmyadmin-on-windows-server](https://zomro.com/blog/faq/367-how-to-install-and-configure-phpmyadmin-on-windows-server)
