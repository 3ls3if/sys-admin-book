---
icon: flask-gear
---

# Installation and Configuration (Practical)

## **Introduction**

This article introduces the steps for installing and configuring SmarterMail. &#x20;

## **Preconditions**

* Windows Server 2012 R2 64-bit or higher
* Microsoft .NET 4.7 Framework or higher
* Microsoft Internet Information Server (IIS)

## 1 **Install SmarterMail**

### 1.1 **Download SmarterMail installation package**

Download SmarterMail installation package from [https://www.smartertools.com/smartermail/downloads/16](https://www.smartertools.com/smartermail/downloads/16).

### 1.2 **Run the SmarterMail installer**

* Double click SmarterMail16\_Setup.exe file.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240275\&key=3844690654)

* Choose **Create a new site**.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240276\&key=4161200589)

* Click **Next**.&#x20;

The **Port** part can be modified, but 9998 is generally used by default.&#x20;

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240277\&key=630208584)

* Click **Next**.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240278\&key=2556056710)

## 2 **Configure SmarterMail**

Once the installation is complete, it will automatically jump to the configuration page.                                                               &#x20;

### 2.1 **Set up the administrator account** **“admin” to log in to SmarterMail**

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240279\&key=1171033347)

### 2.2 **Configure the server DNS**

**Hostname:** mail.yourdomain.com**Primary DNS Server IP:** 8.8.8.8**Secondary DNS Server IP:** 8.8.4.4

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240280\&key=1656510518)

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240281\&key=3207233971)

### 2.3 **Disable relay**

To prevent your server from becoming an open relay server, which can cause IP abuse problems, please disable the relay feature.Click **Settings** ->**protocols**. Locate the **Allow Reply** option. Choose **Nobody**.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240282\&key=4144205104)

### 2.4 **Set up authentication**

Scroll down to the bottom of the page from the previous step.Change “**Require Auth Match**” to “**Email Address**” Enable **"Allow relay for authenticated users"** and **"domain's SMTP auth setting for local deliveries"** as the screenshot shows.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=252786\&key=2239096725)

Save all changes.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240284\&key=2105534547)

### 2.5 **Specify password requirements**

Click **Settings** ->**Password Requirements**. Locate the **options** and enable all the requirements.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240285\&key=3296998331)

### 2.6 **Set up SMTP authentication**

Click **Manage**-> **Domain Defaults**. Scroll down to the bottom of the page from the previous step. Enable **Require SMTP Authentication**. Save all changes.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240286\&key=3589888450)

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240287\&key=1812103722)

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240288\&key=948584887)

### 2.7 **Open ports for all IPs**

If your server has more than 1 IP. All IPs must be listening to the following ports:**SMTP(25), POP(110), IMAP(143), Submission Port(587)**

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240289\&key=3796848751)

## 3 **Login SmarterMail**

After completing all the above steps, SmarterMail has been successfully installed and configured.The login URL is http://IP:9998. Please log in to SmarterMail using the account “admin”  you set up in step 2.1.

![](https://portal.databasemart.com/AvatarHandler.ashx?fid=240290\&key=1538558855)
