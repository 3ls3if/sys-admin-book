---
icon: user-magnifying-glass
---

# Error 'Unknown or Disabled User!' when attempting to authenticate via web mail

**SYMPTOMS**

Error: 'Unknown or Disabled User!' when attempting to authenticate via web mail.

**CAUSE**

There are several possibilities as to why this problem can occur. These are listed below in order of probability:\
\
1\. The account or password was specified incorrectly. Please see: [http://www.mailenable.com/kb/content/article.asp?ID=ME020068](http://www.mailenable.com/kb/content/article.asp?ID=ME020068)

2\. The account being used has been disabled in the MailEnable Administration program.  Open the Administration Program and select the account that is being used to access web mail. Right click on the mailbox and ensure that it is enabled and active for use.\
\
3\. The **IME\_ADMIN** account does not have the correct permissions to access the C:\Program Files\Mail Enable\CONFIG directory and its subdirectories.

_Solution: Use Windows Explorer to locate this directory and right click on the directory to validate that the IME\_ADMIN account has full control of this directory and its subdirectories._\
\
4\. Web mail has been disabled for this user. This is a feature of MailEnable Enterprise and can be enabled by viewing the Service Selection mailbox properties in the administration program, ensure the web mail service is "Enabled" for that mailbox.  Also ensure that the web mail is enabled for the post office.

5\. A migration to a third party database did not migrate correctly causing invalid credentials. (Only applies to Enterprise Edition)

_Solution: Revert back to tab delimited files and perform the migration following the instructions as explained in the Enterprise Edition manual._



***

## REFERENCES

* [https://www.mailenable.com/kb/content/article.asp?ID=ME020182](https://www.mailenable.com/kb/content/article.asp?ID=ME020182)
* [http://www.mailenable.com/kb/content/article.asp?ID=ME020045](http://www.mailenable.com/kb/content/article.asp?ID=ME020045)
