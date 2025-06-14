---
icon: database
---

# Exporting and Importing Database Dumps

A database dump is a file containing a database structure and content.\
You can use it for backup purposes. In earlier Plesk versions, dumps\
could be created only using database management tools. Now Plesk offers\
a quicker way to create database dumps, store them, and deploy\
previously created dumps on the server.

In Plesk, _to export a database dump_ means to save a source database\
in a file, which then can be used for storage or distribution. _To_\
&#xNAN;_&#x69;mport a database dump_ means to restore data from such a file to a\
destination database. You can import a database to the same or another\
database server. The only restriction is that the source and destination\
databases must be of the same type, for example, MySQL.

In Plesk, database dumps are created in the SQL format and saved as ZIP\
archives. If you need to create a dump in another format or to set\
custom settings for a dump, use the native functionality of database\
management tools (phpMyAdmin, phpPgAdmin, or myLittleAdmin). For\
instructions on how to import and export data by using database\
management tools, refer to the tools’ documentation.

***

**To save a copy of a database:**

1. Go to **Websites & Domains** > **Databases** > **Export Dump** in the\
   database tools pane.
2. Save a dump:
   * To save a dump in a certain directory on the server, select the\
     directory. The home directory of your subscription is used by\
     default.
   * To save a dump on your local computer as well as on the server,\
     select **Automatically download dump after creation**.

***

**To deploy your copy of a database in Plesk:**

1. Go to **Websites & Domains** > **Databases** > **Import Dump** in the\
   database tools pane.
2. Select a dump to deploy:
   * To deploy a dump from your local computer, select **Upload** and\
     click **Browse**. Then select the ZIP archive containing the dump\
     file.
   * To deploy a dump from a directory on the server, select **Import**\
     and select the dump file.
3. To deploy the dump into a newly created database, select **Recreate**\
   **the database**. The old database will be deleted and a new one, with\
   the same name, created.

{% hint style="warning" %}
**Note:** By default, the **Import Dump** and **Export Dump** buttons are not\
displayed for databases hosted on a remote Microsoft SQL Server. To\
export or import dumps of such databases, configure backup settings\
for the remote Microsoft SQL Server first.
{% endhint %}



***

## REFERENCES

* [https://docs.plesk.com/en-US/obsidian/reseller-guide/website-management/website-databases/exporting-and-importing-database-dumps.69538/?\_gl=1\*o7i3xz\*\_gcl\_au\*NzYwMzk4ODc3LjE3NDg3NjQ2MDk.\*\_ga\*NzExMDk0NTI5LjE3MzU3NDkwNDE.\*\_ga\_5SX3L7KZCY\*czE3NDk5Mzk0MDIkbzE2JGcwJHQxNzQ5OTM5NDAyJGo2MCRsMCRoMTYxODc4MTM4Nw..](https://docs.plesk.com/en-US/obsidian/reseller-guide/website-management/website-databases/exporting-and-importing-database-dumps.69538/?_gl=1*o7i3xz*_gcl_au*NzYwMzk4ODc3LjE3NDg3NjQ2MDk.*_ga*NzExMDk0NTI5LjE3MzU3NDkwNDE.*_ga_5SX3L7KZCY*czE3NDk5Mzk0MDIkbzE2JGcwJHQxNzQ5OTM5NDAyJGo2MCRsMCRoMTYxODc4MTM4Nw..)
