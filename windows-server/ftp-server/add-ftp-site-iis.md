---
icon: globe-pointer
---

# Add FTP Site (IIS)

## **Configuration at IIS** <a href="#step-3-configuration-at-iis" id="step-3-configuration-at-iis"></a>

We assume you have enabled/installed IIS Services and FTP Server. Now we have to configure the FTP account for read and write permissions. Let get started!

1\. On your **Windows Server → Search Internet Information Services (IIS) Manager**.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-39.png)

&#x20;

2\. Navigate to **Sites → Right-click** → Click on **Add FTP Site**.

<figure><img src="https://howto.hyonix.com/wp-content/uploads/2023/12/image-40.png" alt=""><figcaption></figcaption></figure>

3\. Enter **the name for FTP** -> Click 3 dot next to Physical path -> Select Local Disk (C): -> Make New Folder and configure the directory access → Click on **Next**.

<figure><img src="https://howto.hyonix.com/wp-content/uploads/2023/12/image-41.png" alt=""><figcaption></figcaption></figure>

4\. Enter the folder name -> Click OK

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-42.png)

5\. Click **Next**

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-44.png)

4\. Next, configure the **IP address for the FTP site**. If you have a virtual host, then enter the host domain name. Finally, select _**No SSL**_ → Click on **Next**.

<figure><img src="https://howto.hyonix.com/wp-content/uploads/2023/12/image-43.png" alt=""><figcaption></figcaption></figure>

5\. In the Authentication step, select the **Basic** authentication type and make sure to deselect Anonymous. Now, select the users to whom you want to grant the FTP permission. For this article, we will give FTP access to **Specified roles or user groups**. In **Permission**, make sure to select Read and Write both options (depending on your demand) → Click on **Finish**.

<figure><img src="https://howto.hyonix.com/wp-content/uploads/2023/12/image-45.png" alt=""><figcaption></figcaption></figure>

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-46.png)

<br>
