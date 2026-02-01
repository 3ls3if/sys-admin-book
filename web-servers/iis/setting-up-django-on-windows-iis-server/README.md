---
icon: python
---

# Setting up Django on Windows IIS Server

## **Software Required:**

* Python, Django, wfastcgi
* IIS
* Windows Server 2012 R2 or Windows Server 2016 (64-bit)
* Database (Optional): MySQL/SQLite/PostgreSQL + DB Connector for Python
* Knowledge of Php, Apache, and Webserver technologies would come in handy.

{% hint style="info" %}
**A quick note on `wfastcgi` and WSGI:**

There aren’t really any issues in targetting Windows Server and IIS as the production environment for your Django application, other than including the wfastcgi Python package ([https://pypi.python.org/pypi/wfastcgi](https://pypi.python.org/pypi/wfastcgi)) in your application.

wfastcgi is maintained by Microsoft and provides a file that serves as the entry point of the IIS handler for WSGI applications in Python. It’s similar in purpose to a tool like Gunicorn ([http://gunicorn.org](http://gunicorn.org/)), with the end result being that requests that come into IIS are handed off to the Python application for processing.
{% endhint %}



***

