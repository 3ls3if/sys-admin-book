---
icon: php
---

# Installing PHP

### Downloading the PHP binaries <a href="#downloading-the-php-binaries" id="downloading-the-php-binaries"></a>

You can download the latest PHP binaries from the PHP website found here: [http://windows.php.net/download/](http://windows.php.net/download/).

You must pay special attention to the version that you download, given that my server(s) run the 64-bit version of Windows, I will naturally choose to download and go for the x64 NTS (none-thread safe) version of PHP.

Once downloaded, extract all the files to C:PHP, this directory will be used to store our PHP binaries and configuration files.

### Installing PHP <a href="#installing-php" id="installing-php"></a>

Now that we have the required runtimes installed and IIS has the CGI module enabled we can now start the final part of the setup and that is to install PHP!

Using the _Administrative Tools_ found under the _Control Panel_ again, this time we are going to open up the **Internet Information Services (IIS) Manager** application:

Now, from the left-hand menu click on the server’s name, and then from the main panel double click the Handler Mappings icon as shown below:

<figure><img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/33059940134/original/uJ-avuPGGP2dAvgz1jewkrLRAqAZYn0hKA.png?1623318728" alt=""><figcaption></figcaption></figure>

You will now be presented with the current handler mappings supported by the server, on the right-hand side of the window you should see a list of _Action_ links, click on the link named **Add Module Mapping…** as shown here:

<figure><img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/33059940138/original/b4E7uVZgweuPC8y2OBsL4hEtcMNH6N0gsQ.png?1623318728" alt=""><figcaption></figcaption></figure>

Once the Add Module Mapping window appears, populate the values as follows:

<figure><img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/33059940137/original/b8Cp_9bh3V_j5hPO4W2TSSyk3yrf3B7vpQ.png?1623318728" alt=""><figcaption></figcaption></figure>

Click on the **Request Restrictions** button and tick the **Invoke handler only if the request is mapped to:** and then select the **File** radio button…

<figure><img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/33059940140/original/uKSuq7V5e5zzPJ36Y2RyAusuFqrC3NlT0w.png?1623318729" alt=""><figcaption></figcaption></figure>

Now click **Ok** and **Ok** again, the module mapping is now configured!

Although not mandatory, it is recommended that you now set a default document so that directory level access to pages will automatically serve the “index” page, it is common when serving PHP sites to have “index.php” configured as a default index page…

To set a new index page, select the server name from the left-hand menu and then double-click on the **Default Document** icon as shown below:

<figure><img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/33059940139/original/KcBVuAxc9x66BVEBimEOpCD5fKCINeUoxA.png?1623318728" alt=""><figcaption></figcaption></figure>

On the right-hand menu of the Default Document window you will have the option to _add_ a new one, click the **Add** link, and then, in the window that pops up type **index.php** and then click **Save** as shown here:

<figure><img src="https://s3.amazonaws.com/cdn.freshdesk.com/data/helpdesk/attachments/production/33059940133/original/9E7lJX5FQp6oKjgtSqmg8XRweMy5NIrXAg.png?1623318728" alt=""><figcaption></figcaption></figure>

Great stuff! – That’s it, adding a new site and add a _index.php_ file into the root of the home directory should now work!

To test it out, create a file named **index.php** with the following content:

```
<?php phpinfo(); ?>
```
