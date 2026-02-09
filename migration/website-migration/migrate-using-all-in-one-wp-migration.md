---
icon: wordpress
---

# Migrate using All-in-One WP Migration

### Step 1: Export your existing site <a href="#step-1-export-your-existing-site" id="step-1-export-your-existing-site"></a>

1. Install and activate the [All-in-One WP Migration and Backup plugin](https://wordpress.org/plugins/all-in-one-wp-migration/) on the source site.
2. In the site’s dashboard, navigate to _All-in-One WP Migration → Export._
   * If you’re using the same domain name on the new WordPress.com site, you don’t need to use the find and replace feature at _All-in-One WP Migration → Export._
   * If you are changing domain names as part of the migration, you’ll want to first enter your current domain name in the **Find** field and your new domain name in the **Replace with** field.
3. Click “**Export to**” and choose the **File** option. The other methods listed here will cost money, whereas the **File** option is included with the free version of All-in-One WP Migration.

<figure><img src="https://en-support.files.wordpress.com/2023/09/aiowpm-file-export.png?w=404" alt="The File option is highlighted in the Export list." height="194" width="404"><figcaption></figcaption></figure>

4. Wait for the file to finish preparing.
5. Click the download option to save the file to your computer. The file will be in a `.wpress` format.

### Step 2: Import to WordPress.com <a href="#step-two-import-to-wordpress-com" id="step-two-import-to-wordpress-com"></a>

1. On your WordPress.com site, install and activate the [All-in-One WP Migration and Backup plugin](https://wordpress.com/plugins/all-in-one-wp-migration/).
2. In the site’s dashboard, navigate to _All-in-One WP Migration → Import._
3. Click “**Import from**” and choose the “**File**” option:

<figure><img src="https://en-support.files.wordpress.com/2023/09/aiowpm-import-file.png?w=410" alt="The File option is highlighted in the Import list." height="182" width="410"><figcaption></figcaption></figure>

4. Select the `.wpress` file from your computer that you downloaded earlier.
5. Wait for the upload to complete. Depending on the size of the site, this can take a while.
6. Once the upload finishes, click “**Proceed**” to confirm that you wish to overwrite the existing WordPress.com site.

⚠️

> By importing a site using this method, the entire contents of the WordPress.com site will be erased and replaced with the site that you import.

### Step 3: Review your site <a href="#step-three-contact-us" id="step-three-contact-us"></a>

Once you complete the above steps, take a few minutes to review your new WordPress.com site. Make sure you’re able to access tools and plugins in your WordPress.com [dashboard](https://wordpress.com/home) and that your new site has the features and functionality you need from the source site. Deactivate any [incompatible plugins](https://wordpress.com/support/plugins/incompatible-plugins/) on the imported site.

If anything isn’t working as expected, please [send us a message](https://wordpress.com/support/contact/) to let us know that you have just completed a migration using the All-in-One WP Migration plugin. We will review your site to ensure the migration went smoothly.





***

## REFERENCES

* [https://wordpress.com/support/import/import-using-all-in-one-migration/](https://wordpress.com/support/import/import-using-all-in-one-migration/)
