---
icon: album
---

# 100% Disk Usage Issue



## Disable Windows Search (Temporarily or Permanently)

Why: Sometimes, Windows Search goes crazy with indexing and eats up disk resources.

To test temporarily:\
Open Command Prompt as Admin and run:\
net.exe stop "Windows Search"\
To disable permanently (if it's the culprit):\
Press Win + R → type services.msc → find Windows Search → Right-click → Properties → Set Startup type to Disabled → Click Stop



## Turn off SysMain (formerly Superfetch)

Why: This service tries to "optimize performance" but ends up overloading HDDs.\
Press Win + R → type services.msc → find SysMain → Right-click → Properties → Set Startup type to Disabled → Click Stop



## Check for Malware or Background Apps

Why: Sometimes, unnecessary apps or hidden malware keep your disk busy in the background.\
Press Ctrl + Shift + Esc to open Task Manager\
Look for processes hogging disk space\
Uninstall unused apps or disable them from the Startup tab



***

## REFERENCES

* [https://www.linkedin.com/posts/md-naymur-rahman-b54b12204\_struggling-with-100-disk-usage-on-windows-activity-7331983646746198018-KMdK?utm\_source=share\&utm\_medium=member\_desktop\&rcm=ACoAADp07Y4B2z5HlGEFcYyupz1wbzFd5stzyBA](https://www.linkedin.com/posts/md-naymur-rahman-b54b12204_struggling-with-100-disk-usage-on-windows-activity-7331983646746198018-KMdK?utm_source=share\&utm_medium=member_desktop\&rcm=ACoAADp07Y4B2z5HlGEFcYyupz1wbzFd5stzyBA)
