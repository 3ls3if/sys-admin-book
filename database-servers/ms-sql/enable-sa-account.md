---
icon: user-pen
---

# Enable SA Account

### Steps To Enable "sa" Account In SQL Server

#### Step 1

Connect to the SQL Server instance using SQL Server Management Studio(SSMS) and go to **Security** and expand **Security.**

<figure><img src="https://edge.sitecorecloud.io/fishtankconc21d-getfishtanknext-prod-f347/media/v2/v2-blog/enable-sa-user/1.png" alt=""><figcaption></figcaption></figure>

#### Step 2

Expand **Logins** and you'll see the **sa** account is disabled.

<figure><img src="https://edge.sitecorecloud.io/fishtankconc21d-getfishtanknext-prod-f347/media/v2/v2-blog/enable-sa-user/2.png" alt=""><figcaption></figcaption></figure>

#### Step 3

Right-click on the **sa** account and select to **Properties**. Under **General** page, specify a complex password for the **sa** account. By default, the Enforce password policy is checked. If you don’t want to provide a complex password for the **sa** account, you can uncheck this option. However, this is **not recommended**.

<figure><img src="https://edge.sitecorecloud.io/fishtankconc21d-getfishtanknext-prod-f347/media/v2/v2-blog/enable-sa-user/3.png" alt=""><figcaption></figcaption></figure>

#### Step 4

Click on the **Status** page. By default, the **sa** account will be disabled. Click on the **Enabled** button to enable the **sa** account. Click on **OK** to close the **Login Properties**.

<figure><img src="https://edge.sitecorecloud.io/fishtankconc21d-getfishtanknext-prod-f347/media/v2/v2-blog/enable-sa-user/5.png" alt=""><figcaption></figcaption></figure>

Now you can see the **sa** user is no longer disabled with a red cross. Thus, the **sa** account is enabled and you will be able to log in to the SQL instance using the **sa** account.

<figure><img src="https://edge.sitecorecloud.io/fishtankconc21d-getfishtanknext-prod-f347/media/v2/v2-blog/enable-sa-user/6.jpg" alt=""><figcaption></figcaption></figure>

If you are still unable to log in with **sa** user, you need to change the authentication mode for the SQL server from Windows Authentication Mode to SQL Server and Windows Authentication Mode to use the **sa** account. To learn how to change the authentication mode for the SQL server see my previous blog, [_How To Fix Microsoft SQL Server, Error 18456_](https://www.getfishtank.com/blog/login-failed-error-18456).
