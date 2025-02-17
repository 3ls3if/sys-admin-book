---
icon: user
---

# User Isolation

## User isolation <a href="#step-4-user-isolation" id="step-4-user-isolation"></a>

In order for each user to get to his own directory and not have access to other files after connecting to the server, it is necessary to set up isolation.

1\. To do this, **open your ftp site settings** and select **FTP User Isolation**.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-47.png)

2\. Select the **User name directory** and click **Apply**.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-48.png)

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-49.png)

3\. Then, using the right mouse button, open the menu of your ftp site and select **Add Virtual Directory**.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-50.png)

4\. In the **Alias** field, enter a nickname or name, in the path field enter the path to the user directory, you can also create a subdirectory in the ftp site directory on your Windows server. Click **Ok**.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-51.png)

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-52.png)

5\. To configure permissions in IIS Manager, expand the hierarchical structure of your ftp server. Using the right mouse button, open the Windows virtual directory menu and select **Edit Permission**

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-53.png)

6\. Click the **Security** tab and click the **Advanced** button.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-54.png)

7\. In the window that opens, click the **Disable inheritance** button, select the first option in the new window, and then click **Apply – Ok.**

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-55.png)

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-56.png)

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-57.png)

8\. Select the Users group in which all users are located and click the **Remove** button. This is necessary so that only the owner of the directory has access to it.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-58.png)

9\. Next, click **Apply – Ok**.

![](https://howto.hyonix.com/wp-content/uploads/2023/12/image-59.png)

\
