---
icon: file-xls
---

# Excel worksheet, right click insert not functioning

## Excel worksheet, right click insert not functioning

{% hint style="warning" %}
When i try to right click on a cell, my "insert" turns grey, and not able to use the function.
{% endhint %}

1\) Go to regedit and delete Options entry from `HKEY_CURRENT_USER\Software\Microsoft\Office|12.0\Excel\` and verify the result.\
\
**Note:**

• Hold Windows key + R.

• Copy and paste, or type the following command in the Open box, and then press Enter:

regedit&#x20;

`HKEY_CURRENT_USER\Software\Microsoft\Office|12.0\Excel\Options`\
\
right click on Options and delete it.

{% hint style="warning" %}
Note: Ensure to back up the registry before any modification or deletion.

a) Locate and click the key or subkey that you want to back up.\
b) Click the File menu, and then click Export.\
c) In the Save in box, select the location where you want to save the backup copy to, and then type a name for the backup file in the File name box.\
d) Click Save.
{% endhint %}



***

## REFERENCES

* [https://answers.microsoft.com/en-us/msoffice/forum/all/excel-worksheet-right-click-insert-not-functioning/6fe569f7-bb23-44ac-adc7-b9dc976d7bbe](https://answers.microsoft.com/en-us/msoffice/forum/all/excel-worksheet-right-click-insert-not-functioning/6fe569f7-bb23-44ac-adc7-b9dc976d7bbe)
