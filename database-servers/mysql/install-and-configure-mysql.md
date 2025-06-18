---
icon: circle-down
---

# Install and Configure MySQL

{% hint style="warning" %}
MySQL is a well-established relational database management system ([RDBMS](https://phoenixnap.com/glossary/relational-database-management-system-rdbms)). It is fully compatible with Windows operating systems, including desktop and server editions.
{% endhint %}

## Prerequisites

* Windows operating system.
* Administrator privileges on the Windows server.

## How to Install MySQL on Windows

{% hint style="success" %}
Instead of downloading and installing MySQL manually, you can use the **MSI Installer** to streamline the process.
{% endhint %}

### Step 1: Download MySQL MSI Installer for Windows

To download a free Community MySQL Server for Windows:

1\. [Connect to your Windows server](https://phoenixnap.com/kb/rdp-windows) and navigate to the [official MySQL downloads page](https://dev.mysql.com/downloads/mysql/).

2\. Use the dropdown menu to select the latest MySQL Server version. At the time of writing, the latest **stable** MySQL Community Server version is **8.4.3 LTS**.

3\. **Download** the MSI Installer.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/donwload-mysql-msi-installer.png" alt="Download MSI Installer form official MySQL page." width="563"><figcaption></figcaption></figure>

4\. If you do not want to sign up for an _Oracle Web Account_, click **No thanks, just start my download**.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/start-mysql-installer-download-1.png" alt="Start MySQL MSI Installer download." width="563"><figcaption></figcaption></figure>

Once the download is complete, run the MySQL Installer file from the download folder. It can take a few moments while Windows prepares the installation and configuration process.

***

### Step 2: Install MySQL Server on Windows

To install MySQL Server on Windows:

1\. Click **Next** to start the MySQL installation process in the Setup Wizard.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/start-setup-wizard-mysql-windows.png" alt="Start MySQL Setup Wizard." width="563"><figcaption></figcaption></figure>

2\. Review and accept the _License Agreement_ terms and click **Next**.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/license-agreement-mysql-install.png" alt="Accept MySQL License Agreement." width="563"><figcaption></figcaption></figure>

3\. Before proceeding with the installation, define which features to install by selecting a _Setup Type_. Select one of the predefined options or create your custom setup:

* <mark style="color:green;">**Typical**</mark><mark style="color:green;">. Deploy an instance of the MySQL Server and skip most other features. Typically used for deploying servers in a</mark> [<mark style="color:green;">production environment</mark>](https://phoenixnap.com/glossary/production-environment)<mark style="color:green;">.</mark>
* <mark style="color:green;">**Custom**</mark><mark style="color:green;">. Manually select the elements to be installed and modify default settings.</mark>
* <mark style="color:green;">**Complete**</mark><mark style="color:green;">. Install MySQL Server and all available features, including sample</mark> [<mark style="color:green;">databases</mark>](https://phoenixnap.com/kb/what-is-a-database) <mark style="color:green;">and examples. Provides a complete environment for development and</mark> [<mark style="color:green;">server management</mark>](https://phoenixnap.com/blog/server-management)<mark style="color:green;">.</mark>

For this tutorial, we selected the **Typical** setup type. After making your selection, click **Next** to proceed.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/typical-setup-type-mysql-windows.png" alt="Select MySQL Server setup type on Windows." height="480" width="801"><figcaption></figcaption></figure>

{% hint style="warning" %}
**Note:** The setups are tailored for specific use cases, primarily to streamline the installation. You can always customize the preconfigured setups post-installation.
{% endhint %}

4\. Click **Install** to initiate the MySQL Server installation.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/install-windows-mysql-server.png" alt="Install the MySQL Server on Windows." width="563"><figcaption></figcaption></figure>

5\. Confirm the **Run MySQL Configurator** option is checked and click **Finish**.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/complete-install-mysql-windows.png" alt="Complete MySQL Server installation and launch MySQL Configurator." width="563"><figcaption></figcaption></figure>

This launches the **MySQL Configurator** app to assist you in configuring **MySQL Server 8.4.3**.



***

### Step 3: Configure MySQL Server on Windows

The following section explains how to set up MySQL Server on Windows using the **MySQL Configurator**.

{% hint style="warning" %}
**Note:** The MySQL Configurator is part of the MySQL bundle and does not need to be installed separately. It automates the MySQL Server setup, provides a consistent interface across all supported Windows platforms, and resolves [software dependencies](https://phoenixnap.com/blog/software-dependencies).
{% endhint %}

The tool starts automatically if the **Run MySQL Configurator** option is selected during installation. If it does not launch, open the tool manually from the Windows Start menu.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/mysql-configurator-windows.png" alt="Start MySQL Server configuration on Windows." width="563"><figcaption></figcaption></figure>

Once the tool is launched, click **Next** to begin the configuration process.

#### **Data Directory**

Select the directory where MySQL Server will store its data.

Use the default path, _C:\ProgramData\MySQL\MySQL Server 8.4\\,_ or specify a custom directory and click **Next**.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/data-directory-path-mysql-windows.png" alt="Select MySQL Data Directory path." width="563"><figcaption></figcaption></figure>

{% hint style="warning" %}
**Note:** To avoid path conflicts during the installation, remove previous MySQL versions from the system or select a new installation directory.
{% endhint %}

#### **Type and Networking**

In the _Type and Networking_ section:

1\. Choose one of three server configuration types in the **Config Type** dropdown:

* <mark style="color:green;">**Development Computer**</mark><mark style="color:green;">. Select this option if the Windows server is a testing and</mark> [<mark style="color:green;">development environment</mark>](https://phoenixnap.com/glossary/development-environment) <mark style="color:green;">where MySQL needs to share resources with other</mark> [<mark style="color:green;">applications</mark>](https://phoenixnap.com/glossary/what-is-an-application)<mark style="color:green;">.</mark>
* <mark style="color:green;">**Server Computer**</mark><mark style="color:green;">. This configuration balances resource sharing and server performance. The Windows server can host multiple applications, including MySQL, as part of a multi-purpose server setup.</mark>
* <mark style="color:green;">**Dedicated Computer**</mark><mark style="color:green;">. MySQL utilizes all system resources with minimal resource sharing. This option is best used for dedicated MySQL servers and is optimized for production environments.</mark>

2\. (Optional) Define the MySQL server port. The default port is **3306**, but it can be changed if, for example, another application already uses this [port number](https://phoenixnap.com/glossary/port-number).

3\. Ensure the **Open Windows Firewall ports for network access** option is checked to allow MySQL traffic through the [firewall](https://phoenixnap.com/glossary/what-is-a-firewall).

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/type-networking-mysql-server-port.png" alt="Set MySQL port number in Windows." width="563"><figcaption></figcaption></figure>

4\. (Optional) Check the **Show Advanced and Logging Option** box to configure additional logging options later.

5\. Click **Next** to continue.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/type-networking-mysql-server.png" alt="Enable MySQL logging in Windows." width="563"><figcaption></figcaption></figure>

#### **Accounts and Roles**

The _Accounts and Roles_ section allows you to configure MySQL user accounts. This is only an initial setup, and you can [change the MySQL root password](https://phoenixnap.com/kb/how-to-reset-mysql-root-password-windows-linux) after the installation.

1\. Enter and confirm a [strong password](https://phoenixnap.com/blog/strong-great-password-ideas) for the MySQL root user.

2\. (Optional) Click **Add User** to create additional roles and set privileges for various users and purposes.

3\. Select **Next** to continue with the server configuration.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/account-roles-mysql-windows.png" alt="Set MySQL accounts and roles on Windows server." width="563"><figcaption></figcaption></figure>

#### **Windows Service**

A Windows Service is registered with the operating system and starts automatically when Windows boots. Configuring MySQL Server as a Windows Service ensures it runs continuously in the background and is available for applications.

Confirm the **Configure MySQL Server as a Windows Service** and **Start the MySQL Server as System Startup** options are checked, then click **Next** to proceed.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/windows-service-mysql-setup.png" alt="Configure MySQL as Windows Service." height="625" width="800"><figcaption></figcaption></figure>

#### **Server File Permissions**

File permissions determine how users access and interact with MySQL server files. To define file permissions for previously created MySQL users, you can:

* <mark style="color:green;">Allow the MySQL Installer to configure user permissions automatically.</mark>
* <mark style="color:green;">Manually set specific file access levels for each user (recommended).</mark>
* <mark style="color:green;">Modify the server permissions manually after the installation is complete.</mark>

The recommended option is the safe choice for most setups. When ready, click **Next** to continue.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/server-file-permission-mysql.png" alt="Set MySQL Server file permissions during Windows installation." width="563"><figcaption></figcaption></figure>

#### **Logging Options (Optional)**

If you have selected the **Show Advanced Logging** option in the _Type and Networking_ tab, you can set up MySQL log preferences.

Select the types of logs you want to activate and define the log directories for:

* <mark style="color:green;">**Error Log**</mark><mark style="color:green;">. Logs critical errors and warnings encountered by the MySQL server.</mark>
* <mark style="color:green;">**General Log**</mark><mark style="color:green;">. Tracks server activity and connections.</mark>
* <mark style="color:green;">**Slow Query Log**</mark><mark style="color:green;">. Identifies queries that take longer than expected to execute.</mark>
* <mark style="color:green;">**Bin Log**</mark><mark style="color:green;">. Records all changes to the database data.</mark>

Click **Next** to proceed to the _Advanced Options_ section.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/logging-mysql-windows.png" alt="MySQL logging option during installation on Windows." width="563"><figcaption></figcaption></figure>

#### **Advanced Options (Optional)**

The _Advanced Options_ are available only if you have checked **Show Advanced Options** in the _Type and Networking_ tab.

The **Server ID** setting allows you to set a unique server identifier, which is useful for distinguishing servers in multi-server environments.

You can also configure **Table Names Case** sensitivity. In Windows, MySQL treats table names as lowercase (case-insensitive) by default. Uppercase names are rarely used but can be set to align with specific cross-platform requirements.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/advanced-options-mysql-windows-setup.png" alt="Advanced options during MySQL installation on Windows." width="563"><figcaption></figcaption></figure>

Click **Next** to finalize the MySQL Server configuration.

#### **Sample Databases**

The _Sample Databases_ tab allows you to create predefined sample databases and example code, which are useful for learning, testing, and development purposes.

Select the **Sakila** or **World** database (or both) and click **Next**.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/sample-databases-mysql-windows.png" alt="Add sample databases when installing MySQL on Windows." width="563"><figcaption></figcaption></figure>

#### **Apply Server Configuration**

To complete the MySQL Server configuration:

1\. Review the steps and click **Execute** to apply the configuration.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/apply-mysql-configuration-windows.png" alt="Review and execute MySQL configuration in Windows." width="563"><figcaption></figcaption></figure>

2\. The system informs you the MySQL Server configuration process is complete and displays a summary of the completed configuration steps. Select **Next** to continue the installation process.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/apply-mysql-configuration-successful.png" alt="Apply MySQL configuration in Windows." width="563"><figcaption></figcaption></figure>

3\. (Optional) Copy the installation process log to the Windows Clipboard.

4\. Click **Finish** to complete the MySQL server installation on Windows.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/mysql-windows-setup-complete.png" alt="Finish MySQL setup on Windows server." width="563"><figcaption></figcaption></figure>

***

### Step 4: Verify MySQL Installation on Windows

f you configured MySQL as a Windows service, it starts automatically. To verify that the server is running:

1\. Open the **MySQL Command Line Client** from the Windows Start menu.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/access-mysql-command-line-client.png" alt="Open the MySQL client form Windows start menu." width="563"><figcaption></figcaption></figure>

2\. Enter the **root password** created during setup to access the MySQL server.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/connect-mysql-server-windows.png" alt="Enter MySQL root password to connect to server." width="563"><figcaption></figcaption></figure>

3\. Use the following command to list the current databases:

```
SHOW DATABASES;
```

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/show-mysql-databases.png" alt="Show list of MySQL databases." width="563"><figcaption></figcaption></figure>

The output shows that the example databases, _Sakila_ and _World_, were successfully created during the setup process.

#### **Restart MySQL Service on Windows**

If MySQL does not start automatically on boot:

1\. Type **Services** in the Start menu and select **Run as administrator**.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/services-mysql-windows.png" alt="Run Windows Services app as administrator." width="563"><figcaption></figcaption></figure>

2\. Locate the MySQL service in the list. In this example, the service is listed as **MySQL84**.

3\. Select the service and click **Start** or **Restart**, depending on its status.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/restart-mysql-service-windows.png" alt="Restart MySQL Service in Windows." width="563"><figcaption></figcaption></figure>

4\. To ensure the MySQL service always starts on boot, right-click the service and select **Properties**.

5\. In the _Startup Type_ dropdown, select **Automatic** and click **OK** to save the changes.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2024/12/mysql-service-automatic-windows.png" alt="Set MySQL to boot automatically on Windows." width="563"><figcaption></figcaption></figure>

The changes take effect immediately.

***

## REFERENCES

* [https://phoenixnap.com/kb/install-mysql-on-windows](https://phoenixnap.com/kb/install-mysql-on-windows)
