---
icon: chart-network
---

# Enable Network Access to SQL Express

## Enable Network Access to SQL Express

Once you have [SQL Express set up](https://www.apesoftware.com/calibration-control/help/sql-express) on your local computer, you can allow remote connections for members of your network. There are different ways to do this and these steps may not work for your existing network environment or authentication methods. Below is a simple approach for SQL Server Express Edition that is set up on a local computer, and SQL Server authentication is used for members of the same network to remotely connect.

#### Security & Connections

1. Open SQL Server Management Studio (SSMS)
2. Connect to your server
3. Right-click on your server name and click 'Properties'.
4.  Go to the Security page for Server Authentication, and select 'SQL Server and Windows Authentication' mode.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/ssms-server-security.png" alt="SSMS server properties - Security"></div>
5.  Then, go to the Connections page and ensure that "Allow remote connections to this server" is checked, and click OK.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/ssms-server-connections.png" alt="SSMS server properties - Connections"></div>

#### SQL Server Authentication

Now that we've ensured your server is set to allow remote connections, you can set up a login for the server and the specific Calibration Control database (apecal).  The following steps will explain how to create a universal SQL Server Authentication login for Calibration Control users to enter in the SQL Server Connection dialog to connect the database.  (Note:  If desired, you could give users their own individual logins using SQL Server Authentication or Windows Authentication if that's most preferred in your work environment.)

1. Expand the Security folder under your Server
2. Then, right click the Logins folder and select New Login...
3. Type in a generic user name that all users will use, such as _apeuser_.
4. Select SQL Server Authentication.
5. Enter a password.  (It is entirely up to you if you want to keep "Enforce password policy" checked, as deselecting it will deselect the other checkboxes below it.)
6.  Select your _apecal_ database as the default database.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/ssms-create-login.png" alt="SSMS Create server login"></div>
7. Next, under the Server Roles, public will automatically be selected and cannot be deselected. You can optionally select additional roles to grant to this user.
8. Then, open 'User Mapping' and choose the apecal database
9. Under the database roles, select db\_datawriter, db\_datareader, db\_owner and save changes.
10. After that, expand the Databases folder by double-clicking it or clicking the plus sign.
11. Expand your apecal database and then its Security folder
12. Expand the Users folder and double click the login you just created.
13. Click the Membership page and double check that the user has the minimum required roles (at least db\_datareader and db\_datawriter). Click OK.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/sql-user-mapping.png" alt="SSMS User Mapping"></div>

#### SQL Server Configuration

Your server is set up to allow remote connections with a SQL Server login but now you must enable TCP/IP protocols for your server.

1. Open SQL Server Configuration Manager
2. Expand SQL Server Network Configuration and Protocols for {_Your server name_}.
3.  Right-click 'TCP/IP' and select Enable.  Then click OK on the message that the service needs to be restarted before changes take effect.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/sql-enable-protocol.png" alt="SQL Server Configuration Enable TCP/IP"></div>
4. Right-click 'TCP/IP' again and select Properties.  View the IP Addresses tab and locate 'IPAll', (all IP Addresses).&#x20;
5. Enter the value '1433' directly in the TCP Port field.  Click OK to apply the change, and click OK on the message that the service needs to be restarted before changes take effect.
6.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/sql-tcp-port.png" alt="TCP Properties"></div>
7.  Back in the SQL Server Services dialog, right-click on your server name and select Restart.  Alternatively, you can do this from SSMS by right-clicking the server name and clicking Restart.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/server-config-restart.png" alt="SQL Server Configuration Restart"></div>

#### Windows Firewall Configuration

TCP/IP is now enabled on your server.  The next step requires allowing specific ports to connect to your server.

1. Open Windows Defender Firewall with Advanced Security
2. Click on Inbound rules
3.  Then, select 'New Rule' located on the right under the Actions menu.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/create-custom-inbound-rule.png" alt="Create Custom Inbound Rule Specific Port"></div>
4.  Select 'Port' and click Next.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/inbound-rule-port.png" alt="Inbound Rule Specific Port"></div>
5.  Select 'TCP' and then enter the Specific Port: 1433.

    * ↪ _For more, this Microsoft article lists other ports used by SQL Server:_  [_https://docs.microsoft.com/en-us/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access?view=sql-server-ver15#ports-used-by-_](https://docs.microsoft.com/en-us/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access?view=sql-server-ver15#ports-used-by-)

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/inbound-rule-tcp.png" alt="Inbound Rule Port"></div>
6. Action: 'Allow the Connection'.  Continue clicking Next.
7. Finally, create a Name for the New Rule, (e.g., "SQL PORT TCP Connection").  And click Finish.
8.  Next, create another new Inbound Rule.&#x20;

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/new-inbound-rule.png" alt="New Inbound Custom Rule"></div>
9.  Select 'Custom' to create a custom rule, and click Next.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/inbound-rule-custom.png" alt="Inbound Rule Custom"></div>
10. Under the Services section, click the Customize button.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/inbound-customize.png" alt="Inbound Custom Service SQL Server"></div>
11. Select 'Apply to this service' and select your SQL Server, then click OK.

    <div align="center"><img src="https://www.apesoftware.com/content/pages/images/inbound-custom-service.png" alt="Inbound Custom Service SQL Server"></div>
12. Continue clicking Next all the way through, and create a Name of this New Rule, (e.g., "SQL SERVER TCP CNN"). And click Finish.

#### Server Connection

Using SQL Server Management Studio, test the server connection for any computer.  In the Server name field, enter the computer's IP address followed by a comma and a space, then the Port number 1433; (Example, _72.45.194.229, 1433_).  Select 'SQL Server Authentication', and enter log-in credentials.

<div align="center"><img src="https://www.apesoftware.com/content/pages/images/connect-to-server.png" alt="SQL Server Connection Dialog"></div>

Establish server connection where Calibration Control is installed by simply using [Calibration Control SQL Connect](https://www.apesoftware.com/calibration-control/help/network-configuration#sql-connect).   If Calibration Control is open, (e.g. sample database or Access database), you can view the Utilities tab of the ribbon and select 'SQL Connect'.  Enter your connection credentials.

Or, if the test connection is not successful, refer to this help page for [Troubleshooting SQL Server Connection](https://www.apesoftware.com/calibration-control/help/sql-server-connection-troubleshooting) for testing with a UDL File on the computer from which the SQL Connection failed.

\


***

## REFERENCES

* [https://www.apesoftware.com/calibration-control/help/sql-remote-connections](https://www.apesoftware.com/calibration-control/help/sql-remote-connections)

