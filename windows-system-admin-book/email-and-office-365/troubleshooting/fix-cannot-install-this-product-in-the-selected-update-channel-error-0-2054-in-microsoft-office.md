---
icon: square-pen
---

# Fix "Cannot install this product in the selected update channel" Error 0-2054 in Microsoft Office

## 🔍 Understanding the Error

This error occurs when there's a mismatch between your Office version and update channel settings, commonly with **Office LTSC 2021** installations.

**Error Message:**

> ## Cannot install this product in the selected update channel <a href="#post-title-t3_1nolr0x" id="post-title-t3_1nolr0x"></a>

## 🚀 Quick Fix Solution

## Method 1: Registry Edit (Most Effective)

1. **Press Win + R**, type `regedit`, press Enter
2. Navigate to:

HKEY\_LOCAL\_MACHINE\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate

**Locate the** `UpdateBranch` **value**

1. **Delete or modify** the value if it shows:
   * `PerpetualVL2021`
   * Or any specific channel name
2. **Close Registry Editor and restart your computer**
3. **Try installing/updating Office again**

## Method 2: Using Office Deployment Tool

1. **Download Office Deployment Tool** from Microsoft
2.  **Create configuration.xml file:**

    \<Configuration> \<Remove All="TRUE"/> \<Add SourcePath="\\\server\share" OfficeClientEdition="64" Channel="PerpetualVL2021"> \<Product ID="Pro2021Volume"> \<Language ID="en-us"/> \</Product> \</Add> \</Configuration>
3. Run: `setup.exe /configure configuration.xml`

## Method 3: Complete Office Reinstall

1. **Uninstall Office completely:**
   * Control Panel → Programs → Uninstall
   * Or use Microsoft's **SaRA tool** for complete removal
2. **Download fresh Office installer** from Microsoft website
3. **Install with correct channel settings**

## 💡 What Causes This Error?

* **Channel mismatch** between installed Office and update settings
* **Registry conflicts** from previous installations
* **Volume license** vs **retail version** conflicts
* **Group Policy** settings enforcing specific channels

## ⚠️ Important Notes

* **Backup your registry** before making changes
* **LTSC 2021** uses perpetual channel, not standard update channels
* This affects **Volume License editions** specifically

## 🔧 Advanced Solutions

## For IT Administrators:

```
# Remove via PowerShell
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate" -Name "UpdateBranch" -Force
```

## Group Policy Fix:

1. Open **Group Policy Editor** (gpedit.msc)
2. Navigate to: _Computer Configuration → Administrative Templates → Microsoft Office 2016 (Machine) → Updates_
3. Set **Update Channel** to "Not Configured"

## 📊 Prevention Tips

* **Use consistent installation methods**
* **Avoid mixing volume license and retail versions**
* **Document your Office deployment channel**
* **Use official Microsoft deployment tools**

## 🚨 When to Seek Help

If the error persists after registry edit:

* Contact your IT department (for enterprise users)
* Use Microsoft's **Support and Recovery Assistant**
* Consider **complete system restore point**

<br>



***

## REFERENCES

* [https://www.reddit.com/user/Actual-Ant-8824/comments/1nolr0x/fix\_cannot\_install\_this\_product\_in\_the\_selected/](https://www.reddit.com/user/Actual-Ant-8824/comments/1nolr0x/fix_cannot_install_this_product_in_the_selected/)
