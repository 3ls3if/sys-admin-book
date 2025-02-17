---
icon: server
---

# FTP Server (FileZilla)

### Step-by-Step Guide

#### Step 1: Download and Install FileZilla Server

* Visit the [FileZilla official website](https://filezilla-project.org/download.php?type=server) and download the server version.
* Run the installer and follow the suggested installation settings.
* FileZilla installs a service that runs by default. For manual control, change the service setting during installation.

[![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz1.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz1.jpg)

#### Step 2: Launch FileZilla and Connect

After installation, the FileZilla interface will launch automatically. Click **Connect** when prompted to establish a connection to your server.

[![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz2.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz2.jpg)

&#x20;

#### Step 3: Set Up FTP Directory and User Permissions

* Create a directory to serve as your FTP repository (e.g., C:\FTP).
* Go to **Edit** > **Users** and click **Shared folders**.\
  [![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz3.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz3.jpg)
* Click **Add** under the Users section, create a new username, and **assign** the folder.\
  [![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz4.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz4.jpg)

[![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz5.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz5.jpg)

* Configure read/write permissions for the user.

[![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz6.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz6.jpg)

&#x20;

#### Step 4: Secure Your FTP Server

* Use strong passwords for all users.
* Change the default FTP port under **Edit** > **Settings** > **General Settings**.\
  [![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz7.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz7.jpg)
* Limit access to trusted IP addresses using **IP Filter** under **Settings**.\
  [![](https://www.ipserverone.info/wp-content/uploads/2020/04/fz8.jpg)](https://www.ipserverone.info/wp-content/uploads/2020/04/fz8.jpg)

&#x20;
