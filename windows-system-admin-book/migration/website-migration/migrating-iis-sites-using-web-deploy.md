---
icon: globe-pointer
---

# Migrating IIS Sites Using Web Deploy

{% hint style="warning" %}
#### What Can Be Migrated?

Web Deploy can migrate:

* IIS site configuration
* Application Pools
* Content (HTML, ASP.NET, etc.)
* Web.config files
* SSL certificates
* Databases (SQL Server)
* Permissions and ACLs
{% endhint %}

## **Step 1: Installing Web Deploy**

1. **Download Web Deploy**:
   * <mark style="color:green;">Visit the</mark> [<mark style="color:green;">Microsoft Web Deploy download page</mark>](https://www.microsoft.com/en-us/download/details.aspx?id=43717)<mark style="color:green;">.</mark>
   * <mark style="color:green;">Choose the appropriate version of Web Deploy for your operating system and click “Download.”</mark>
2. **Install Web Deploy**:
   * <mark style="color:green;">Run the downloaded installer with administrative privileges (right-click and choose “Run as administrator”).</mark>
   * <mark style="color:green;">Follow the installation wizard:</mark>
     * <mark style="color:green;">Accept the license terms.</mark>
     * <mark style="color:green;">Choose the installation location (you can leave it as the default).</mark>
     * <mark style="color:green;">Select the components to install. Make sure to select at least the following:</mark>
       * <mark style="color:green;">**Web Deployment Tool**</mark>
       * <mark style="color:green;">**IIS Deployment Handler**</mark>
       * <mark style="color:green;">**Management Service Delegation UI**</mark>
     * <mark style="color:green;">Click “Install” to begin the installation.</mark>

## **Step 2: Configuring IIS for Web Deploy**

1. **Open IIS Manager**:
   * <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`inetmgr`</mark><mark style="color:green;">, and press Enter to open the Internet Information Services (IIS) Manager.</mark>
2. **Enable Management Service**:
   * <mark style="color:green;">In IIS Manager, select your server node (usually the top node in the Connections pane on the left).</mark>
3. **Double-Click on “Management Service”** under the “Management” section in the middle pane.
4. **Configure Management Service**:
   * <mark style="color:green;">Check the “Enable remote connections” checkbox to allow remote management of the IIS server.</mark>
   * <mark style="color:green;">Set the “Start Type” to “Automatic” to ensure the service starts automatically with Windows.</mark>
   * <mark style="color:green;">Specify a unique port for the management service (default is 8172).</mark>
   * <mark style="color:green;">You can also configure other settings like SSL and client certificates if needed.</mark>
5. **Configure Permissions**:
   * <mark style="color:green;">Under “Management Service Delegation,” you can configure permissions for various users and roles. Click “Add User…” to specify the users or groups that should have permission to deploy websites.</mark>
6. **Apply Changes**:
   * <mark style="color:green;">Click the “Apply” button to save your configuration.</mark>

## **Step 3: Exporting and Importing Websites with Application Pools**

Now that Web Deploy is installed and IIS is configured, you can use Web Deploy to export and import websites with application pools.

### **Export a Website**:

1. **Open a Command Prompt**:
   * <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Win + X`</mark> <mark style="color:green;"></mark><mark style="color:green;">and choose “Command Prompt (Admin)” to open a command prompt with administrative privileges.</mark>
2. **Run the Export Command**:
   * <mark style="color:green;">Use the</mark> <mark style="color:green;"></mark><mark style="color:green;">`msdeploy`</mark> <mark style="color:green;"></mark><mark style="color:green;">command to export a website. Replace placeholders with actual values:</mark>

```
# Export all sites with application pools
msdeploy -verb:sync -source:webServer,computerName=<ServerName>,userName=<Username>,password=<Password> -dest:package=<PathToPackage.zip> -enableRule:AppPoolExtension

OR

# Export only one site
msdeploy -verb:sync -source:iisapp="Default Web Site" -dest:package="C:\backup\defaultsite.zip"

```

* <mark style="color:green;">`<ServerName>`</mark><mark style="color:green;">: Replace with the server name or IP address.</mark>
* <mark style="color:green;">`<Username>`</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">`<Password>`</mark><mark style="color:green;">: Replace with the credentials of an account with sufficient permissions.</mark>
* <mark style="color:green;">`<PathToPackage.zip>`</mark><mark style="color:green;">: Specify the path where you want to save the exported package.</mark>

## **Import a Website**:

1. **Open a Command Prompt**:
   * <mark style="color:green;">Open a command prompt with administrative privileges.</mark>
2. **Run the Import Command**:
   * <mark style="color:green;">Use the</mark> <mark style="color:green;"></mark><mark style="color:green;">`msdeploy`</mark> <mark style="color:green;"></mark><mark style="color:green;">command to import a website. Replace placeholders with actual values:</mark>

```
msdeploy -verb:sync -source:package=<PathToPackage.zip>,includeAcls=“False” -dest:webServer,computerName=<ServerName>,userName=<Username>,password=<Password>

OR

msdeploy -verb:sync -source:package="C:\backup\defaultsite.zip" -dest:auto,computerName="localhost"
```

* <mark style="color:green;">`<PathToPackage.zip>`</mark><mark style="color:green;">: Specify the path to the package you want to import.</mark>
* <mark style="color:green;">`<ServerName>`</mark><mark style="color:green;">: Replace with the server name or IP address.</mark>
* <mark style="color:green;">`<Username>`</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">`<Password>`</mark><mark style="color:green;">: Replace with the credentials of an account with sufficient permissions.</mark>

1. **Execute the Command**:
   * <mark style="color:green;">Execute the command, and the website with its associated application pool will be imported to the target server.</mark>



{% hint style="warning" %}
#### Useful Commands

**Sync full site (directly):**

```bash
msdeploy -verb:sync -source:iisapp="Default Web Site" -dest:iisapp="Default Web Site",computerName="destination"
```

**List available sites on a server:**

```bash
msdeploy -verb:dump -source:apphostconfig="Default Web Site"
```

**Sync only the content folder:**

```bash
msdeploy -verb:sync -source:contentPath="C:\inetpub\wwwroot\MySite" -dest:contentPath="D:\inetpub\wwwroot\MySi
```
{% endhint %}

***

## REFERENCES

* [https://techcommunity.microsoft.com/blog/iis-support-blog/how-to-migrate-a-website-using-web-deploy/852244](https://techcommunity.microsoft.com/blog/iis-support-blog/how-to-migrate-a-website-using-web-deploy/852244)
* [https://sinaonline.net/2023/09/23/install-web-deploy-on-iis-export-and-import-websites-with-application-pools/](https://sinaonline.net/2023/09/23/install-web-deploy-on-iis-export-and-import-websites-with-application-pools/)
* [https://www.youtube.com/watch?v=i-qr1mR28sI\&ab\_channel=SinaOnline](https://www.youtube.com/watch?v=i-qr1mR28sI\&ab_channel=SinaOnline)
* [https://www.hostitsmart.com/manage/knowledgebase/286/how-to-migrate-iis-website-to-another-server.html](https://www.hostitsmart.com/manage/knowledgebase/286/how-to-migrate-iis-website-to-another-server.html)
