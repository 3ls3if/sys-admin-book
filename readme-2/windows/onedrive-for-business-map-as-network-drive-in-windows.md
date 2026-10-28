---
icon: hard-drive
---

# OneDrive for Business, Map as Network Drive in Windows

Microsoft Windows users can map OneDrive into windows as Network Drive.

NOTE: OneDrive for Business is not designed to be accessed over a mapped drive. But below method will let you use it as Network Drive if you don't want to use typical sync client or web interface to access files.

1\) Open Internet Explorer\
2\) Go to [https://portal.office.com](https://portal.office.com/)\
3\) Sign in with your email address and password\
4\) Check the box that says "Don't show this again" and click "Yes"<br>

<figure><img src="https://itcompany.services/images/one-drive1.png" alt=""><figcaption></figcaption></figure>

<figure><img src="https://itcompany.services/images/one-drive1a.png" alt=""><figcaption></figcaption></figure>

**Now let's make changes in Internet Explorer > Internet Options**

1\) Go to Settings in IE (Gear icon)\
2\) Select Internet Options\
3\) Select the Security tab\
4\) Select Trusted Sites\
5\) Select the Sites Button\
6\) Add Url, **https://\*.sharepoint.com** as per below screenshot. \
7\) Select Add\
8\) Select Close and Ok\
9\) Close IE

![Add website to Trusted Sites](https://itcompany.services/images/one-drive2a.png)

\
**Get the URL for the folder you want to map**

1\) Re-Open IE\
2\) Navigate to https://portal.office.com\
3\) You should be logged in by default since you selected "Don't show this again" earlier\
4\) From the Onedrive portal, place your cursor in the browser URL bar and copy the address up to the forward slash after your\_domain\_name\_com/\
5\) You should have copied something like this (but with your ID): https://itcomp-my.sharepoint.com/personal/YOURID\_domain\_name\_com/

![Copy browser URL](https://itcompany.services/images/one-drive3a.png)

\
**Map the Network drive**

1\) Open Computer or Windows Explorer (**Windows key + E**)\
2\) Click on Computer or **This PC** on the left\
3\) Click on "**Map network drive**" in the ribbon at the top. (Right clicking on Computer or This PC will also show you the "**map network drive**" option)\
4\) Select a free drive letter\
5\) In the folder box, paste the URL from you clipboard, adding the word DOCUMENTS to the end. (Example): https://itcomp-my.sharepoint.com/personal/YOURID\_domain\_name\_com/Documents/\
\
<br>

<figure><img src="https://itcompany.services/images/one-drive4a.png" alt=""><figcaption></figcaption></figure>

<figure><img src="https://itcompany.services/images/one-drive4.png" alt=""><figcaption></figcaption></figure>

<figure><img src="https://itcompany.services/images/one-drive5.png" alt=""><figcaption></figcaption></figure>



6\) Select Reconnect at sign-in if required.\
7\) Select Finish

It may take a few minutes for the mapped drive to show up.
