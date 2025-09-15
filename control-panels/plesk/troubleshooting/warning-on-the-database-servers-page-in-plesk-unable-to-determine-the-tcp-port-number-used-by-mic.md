---
icon: database
---

# Warning on the “Database Servers” page in Plesk: Unable to determine the TCP port number used by Mic

### Symptoms <a href="#h_01ht5cf407p0emckyrfew7wz33" id="h_01ht5cf407p0emckyrfew7wz33"></a>

*   The following warning message is shown in Plesk at **Tools & Settings** > **Database Servers**:

    Warning: Unable to determine the TCP port number used by Microsoft SQL server '.MSSQLSERVER2019': TCP/IP protocol is not enabled in the server network configuration or the server is configured to use dynamic TCP ports.\
    To allow your customers to automatically configure firewall for remote database access, manually configure the SQL server to listen on a specific fixed TCP port.
*   It is not possible to connect to a Microsoft SQL Server remotely using Microsoft SQL Server Management Studio with the error:

    A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: SQL Network Interfaces, error: 28 - Server doesn't support requested protocol) (Microsoft SQL Server, Error: -1)
*   A Plesk website that uses a MSSQL database shows the following error:

    Win32Exception: The system cannot find the file specified.\
    Unknown location\
    SqlException: A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)\
    System.Data.SqlClient.SqlexternalConnectionTds..ctor(DbConnectionPoolIdentity identity, SqlConnectionString connectionOptions, SqlCredential credential, object providerInfo, string newPassword, SecureString newSecurePassword, bool redirectedUserInstance, SqlConnectionString userConnectionOptions, SessionData reconnectSessionData, bool applyTransientFaultHandling, string accessToken)

### Cause <a href="#h_01ht5cf407pzfndb4102k4b2pw" id="h_01ht5cf407pzfndb4102k4b2pw"></a>

Microsoft SQL Server is not configured to use a static port.

### Resolution <a href="#h_01ht5cf407zdtvd07gerwe3nny" id="h_01ht5cf407zdtvd07gerwe3nny"></a>

1. Connect to the Plesk server via [RDP](https://support.plesk.com/hc/en-us/articles/12377247797271).
2.  Go to **Start** > **All Programs** > **Microsoft SQL Server XXXX** > **SQL Server XXXX Configuration Manager**.

    **Note:** XXXX is a version of MS SQL Server from the error message.
3. Expand **SQL Server Network Configuration** and click **Protocols for MSSQLSERVERXXXX**.
4.  Double-click on **TCP/IP**:

    4.1. On the **Protocol** tab, make sure that the **TCP/IP** protocol is **Enabled**.

    ![1.PNG](https://support.plesk.com/hc/article_attachments/22426663772439)

    4.2. Switch to the **IP Addresses** tab and scroll down to the **IPAll** section.

    4.3. Specify default MS SQL port number **1433** (or a custom port number if 1433 is already used by another MS SQL Server instance) in the **TCP Port** field

    **Note:** The specified MS SQL port must be opened in firewall.

    4.4. Click **OK**.

    ![2.PNG](https://support.plesk.com/hc/article_attachments/22426675822103)
5. Go to **SQL Server Configuration Manager (Local)** > **SQL Server Services**,
6.  Right-click on **SQL Server (MSSQLSERVERXXXX)** and click **Restart** to apply the changes.

    ![3.png](https://support.plesk.com/hc/article_attachments/22426663790615)
7. [Log in to Plesk](https://support.plesk.com/hc/en-us/articles/12377667582743).
8. Go to **Tools & Settings** > **Database Servers** > .**MSSQLSERVERXXXX** and click **OK** to sync new settings with Plesk.

**Note:** You should also [recycle the IIS application pool](https://docs.plesk.com/en-US/obsidian/administrator-guide/web-servers/iis-web-server-windows/iis-application-pool.60323/) for affected domains in order for them to start loading properly



***

## REFERENCES

* [https://www.plesk.com/kb/support/warning-on-the-database-servers-page-in-plesk-unable-to-determine-the-tcp-port-number-used-by-microsoft-sql-server/](https://www.plesk.com/kb/support/warning-on-the-database-servers-page-in-plesk-unable-to-determine-the-tcp-port-number-used-by-microsoft-sql-server/)
