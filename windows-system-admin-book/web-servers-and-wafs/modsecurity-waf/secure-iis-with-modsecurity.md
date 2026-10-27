---
icon: windows
---

# Secure IIS with Modsecurity

### Download Modsecurity

Download Modsecurity from the official Github page. The latest version for Windows is v2.9.7 at the moment. Just download the MSI-File.

Link: [https://github.com/owasp-modsecurity/ModSecurity/releases/tag/v2.9.7](https://github.com/owasp-modsecurity/ModSecurity/releases/tag/v2.9.7)

![](../../.gitbook/assets/1.webp)

You should now have the downloaded file.

![](../../.gitbook/assets/2.webp)

Double click to install it and follow the setup. Click on next.

![](../../.gitbook/assets/3.webp)

Accept the terms and click on next.

![](../../.gitbook/assets/4.webp)

Just click on next again.

![](../../.gitbook/assets/5.webp)

Make sure that the option “Perform ModSecurityIIS configuration.” is selected (should be default).

![](../../.gitbook/assets/6.webp)

Click on install.

![](/broken/files/43423809d092febb7603a09a8d1da48b1435ea10)

Click on finish.

![](../../.gitbook/assets/8.webp)

### Confirm installation

Open the IIS Manager on your IIS server.

![](../../.gitbook/assets/9.webp)

Select the “Modules” option. You should see entries for “ModSecurity” like in the screenshot below.

![](../../.gitbook/assets/10.webp)

### Download OWASP rules

Download the OWASP core ruleset from the official Github page. Just download the minimal ZIP-File.

Link: [https://github.com/coreruleset/coreruleset/releases/tag/v4.10.0](https://github.com/coreruleset/coreruleset/releases/tag/v4.10.0)

![](../../.gitbook/assets/12.webp)

Navigate to the following path:

```
C:\Program Files\ModSecurity IIS
```

Find the “modsecurity.conf” file.

![](../../.gitbook/assets/13.webp)

Open the file with the editor of your choice.

![](../../.gitbook/assets/14.webp)

Change the line “SecRuleEngine” to enable it.

```
SecRuleEngine On
```

It should look like this.

![](../../.gitbook/assets/15.webp)

Now find the “modsecurity\_iis.conf” file.

![](../../.gitbook/assets/16.webp)

Open the file with the editor of your choice and add the following lines:

```
Include crs-setup.conf
Include rules/*.conf
```

It should look like this:

![](../../.gitbook/assets/17.webp)

Open the extracted core ruleset folder and search the file “crs-setup.conf.example”.

![](../../.gitbook/assets/18.webp)

Copy the file to the “ModSecurity IIS” folder.

![](../../.gitbook/assets/19.webp)

Remove the “.example” file type. It should look like this.

![](../../.gitbook/assets/21.webp)

Open the extracted core ruleset folder and search the “rules” folder.

![](../../.gitbook/assets/18.webp)

Copy the “rules” folder to the “ModSecurity IIS” folder. It should look like this.

![](../../.gitbook/assets/22.webp)

Now go into the “rules” folder and search the “RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.example” file.

![](../../.gitbook/assets/23.webp)

Remove the “.example” file type. It should look like this.

![](../../.gitbook/assets/25.webp)

In the C:\ directory, create a new folder with the name “Modsecurity-Logs”.

![](../../.gitbook/assets/28.webp)

It should look like this.

![](../../.gitbook/assets/29.webp)

Do a right-click on the new folder and select “Properties”.

![](../../.gitbook/assets/30.webp)

The following window appears.

![](../../.gitbook/assets/31.webp)

Navigate to the “Security” tab and click on “Edit…”.

![](../../.gitbook/assets/32.webp)

The following window appears. Click on “Add…”.

![](../../.gitbook/assets/33.webp)

You should see the following window. Click on “Locations…”.

![](../../.gitbook/assets/34.webp)

Select your IIS server.

![](../../.gitbook/assets/35.webp)

Select the “IIS\_IUSRS” group.

![](../../.gitbook/assets/36.webp)

Make sure that you give the “IIS\_IUSRS” modify permissions. It should look like in the screenshot.

![](../../.gitbook/assets/37.webp)

In the new “Modsecurity-Logs” folder, create a new Text Document.

![](../../.gitbook/assets/38.webp)

Change the name of the file to “modsec\_audit.log” and accept the warning cause of the file name extensions change.

![](../../.gitbook/assets/39.webp)

It should look like this in the end.

![](../../.gitbook/assets/40.webp)

Navigate to the “ModSecurity IIS” path and open the “modsecurity.conf” file again.

```
C:\Program Files\ModSecurity IIS
```

Scroll down until you find the “SecAuditLogType” option.

![](../../.gitbook/assets/41.webp)

Remove the “#” symbol at the “SecAuditLog” option and change the path to “C:\Modsecurity-Logs\modsec\_audit.log”.

It should look like this.

![](../../.gitbook/assets/42.webp)

Restart the IIS after that.

![](../../.gitbook/assets/43.webp)

### Test

To confirm that Modsecurity works we can do a little test.

From an external client, enter the published Domain of the your IIS and enter /etc/passwd/ as the path. We should get a 404 error.

![](../../.gitbook/assets/44.webp)

We should now see an entry for this in the “modsec\_audit.log” file. Modsecurity has now been successfully tested.

![](../../.gitbook/assets/45.webp)

### Fix PKI (CertEnroll)

If you operate a PKI, it is very likely that access to the /CertEnroll directory will no longer work.\
There are entries in the log that could look something like the ones below.

![](../../.gitbook/assets/_6.webp)

If you try to access the /CertEnroll folder you probably get an access denied or blank page.

![](../../.gitbook/assets/_2.webp)

Navigate to the C:\Program Files\ModSecurity IIS\rules folder and search the “REQUEST-920-PROTOCOL-ENFORCEMENT.conf”.

![](../../.gitbook/assets/_1.webp)

Scroll at the bottom of the file and insert the following lines:

```
# Allow CertEnroll and OCSP
SecRule REQUEST_URI "@beginsWith /CertEnroll" "id:920350,phase:1,log,allow,ctl"
SecRule REQUEST_URI "@beginsWith /ocsp" "id:920350,phase:1,log,allow,ctl"
```

It should look like this.

![](../../.gitbook/assets/_3.webp)

Restart the IIS after the change.

![](../../.gitbook/assets/_4.webp)

The access should work again after the restart.

![](../../.gitbook/assets/_5.webp)





***

## REFERENCES

* [https://modsecurity.org/](https://modsecurity.org/)
* [https://theadmincafe.ch/p/secure-iis-modsecurity/](https://theadmincafe.ch/p/secure-iis-modsecurity/)
