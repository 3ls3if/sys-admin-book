---
icon: block-brick-fire
---

# Configuring Windows Firewall for FileZilla Server

## Configuring Windows Firewall for FileZilla Server on Windows Server

I download FileZilla Server from [http://filezilla-project.org/](https://filezilla-project.org/) and I wanted to install it on my Windows Server. I did a basic install, created a user and set a directory for the user. When I tried to access it via the FileZilla client I noticed I could not connect to the FileZilla server. Troubleshooting led to the Windows firewall being the root cause.

In this article I will show you how to configure Windows Firewall to allow FileZilla Server. You can apply this same method for other network services you want to use with Windows Firewall because we are going to set the firewall rules by the application and not by the port.

FileZilla Client error:

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring1.png)

Open "Windows Firewall" from Administrative Tools and select "New Rule"

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring2.png)

Select "Program", and then press "Next"

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring3.png)

Press "Browse"

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring4.png)

Browse to <mark style="color:red;">C:\Program Files\FileZilla Server\\</mark> and select "<mark style="color:red;">FileZilla server.exe</mark>". Then press "Open". You can apply this method for almost any program that is having issues connecting through Windows Firewall. The key to configuring Windows Firewall is selecting the right EXE to allow. Sometimes the only way to find the right EXE is trial and error. If I would have selected “FileZilla Server Interface.exe” instead of “FileZilla server.exe” it probably would not have allowed the connection.

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring5.png)

Verify that the correct EXE is in the path location and press "Next" to continue

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring6.png)

Select "Allow the connection", and then press "Next" to continue

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring7.png)

Select Domain, Private and Public then press "Next". For most situations you will need to have all of these checked.

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring8.png)

Enter a name for the Firewall Rule, in this case we are going name it "FilaZilla FTP Server" so we can easily find it later if we need to change anything

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring9.png)

Make sure the rule is set to "Enabled". We can now try to connect again using the client

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring10.png)

After the configuration I was able to connect to the FileZilla FTP Server. In the event you cannot connect to the server check the following:

* Check the Servers active/passive configuration settings
* Check the Clients active/passive configuration settings
* Check to see if a router or another firewall is preventing connection both on the client and server side

![](https://jppinto.com/wp-content/uploads/2009/03/032209-0251-configuring11.png)



***

## REFERENCES

* [https://jppinto.com/2009/03/configuring-windows-firewall-for-filezilla-server-in-windows-server-2008/](https://jppinto.com/2009/03/configuring-windows-firewall-for-filezilla-server-in-windows-server-2008/)

