---
icon: key
---

# FileZilla: Password reset

## Password reset <a href="#firstheading" id="firstheading"></a>

### FileZilla Client - Recover lost passwords for sites

From the FileZilla client menu, click the File menu, then click Export. Click "Export site manager entries" and then click "OK". Save the file to somewhere you can easily find it, e.g. your default documents folder with a descriptive name and perhaps the date e.g. "FileZillaSites\_2018-06-10.txt".

```
  Note: (This is also a handy way to back up your sites. If you name the file using '.xml' instead of '.txt', you will be able to re-import the file to other installations of the FileZilla client.)
```

Open the file with a text editor (e.g. Notepad, nano, etc.) and find the password(s) you're looking for.

### FileZilla Server - Administrator Password reset for server

To reset the administrator password for the FileZilla Server, edit the configuration file settings.xml.

If the FileZilla Server service program is running under the SYSTEM user (the default, unless chosen differently at installation time), the file is located here:

```
   C:\ProgramData\filezilla-server\settings.xml
```

Within that file, locate the section that looks like this:

```
       <admin>
               <local_port>14148</local_port>
               <password index="1">
                       <hash>...</hash>
                       <salt>...</salt>
                       <iterations>...</iterations>
               </password>
       </admin>
```

Remove the entry \<password>...\</password> and substitute it with \<password index="0" />, like below:

```
       <admin>
               <local_port>14148</local_port>
               <password index="0" />
       </admin>
```

Then restart the service. Next time you connect with the Administration Interface you won't need any password. As soon as you connect, set a new administration password using the proper configuration pane.

***

## REFERENCES

* [https://wiki.filezilla-project.org/Password\_reset](https://wiki.filezilla-project.org/Password_reset)

