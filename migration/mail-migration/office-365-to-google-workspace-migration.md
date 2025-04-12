---
icon: g
---

# Office 365 to Google Workspace Migration

## Overview

* Microsoft 365 and Google Workspace are both cloud-based services.
* The best choice depends on user needs.
* This guide focuses on migrating from **Office 365 to Google Workspace**, including **emails, contacts, and calendars**.

## Step 1: Log In to Google Workspace Admin Console

* <mark style="color:green;">Log in with</mark> <mark style="color:green;"></mark><mark style="color:green;">**admin credentials**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Admin Console**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Data**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Data migration**</mark><mark style="color:green;">.</mark>

## **Step 2: For Email Migration Only**

* <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Exchange Online**</mark> <mark style="color:green;"></mark><mark style="color:green;">as the migration source.</mark>
* <mark style="color:green;">Follow the prompts to complete the</mark> <mark style="color:green;"></mark><mark style="color:green;">**email-only migration**</mark><mark style="color:green;">.</mark>

## Step 3: Full Migration (Email, Contacts, Calendar)

* In "Data Migration", select **Microsoft Exchange**.
* Click **Setup Data Migration**.
  * <mark style="color:green;">**Confirm Source**</mark><mark style="color:green;">: Microsoft Office 365.</mark>
  * <mark style="color:green;">**Select Data Type**</mark><mark style="color:green;">: Email, Contacts, or Calendar (do one at a time).</mark>
  * <mark style="color:green;">**Connection Protocol**</mark><mark style="color:green;">: Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**Auto-select**</mark><mark style="color:green;">.</mark>
  * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Authorize**</mark> <mark style="color:green;"></mark><mark style="color:green;">and sign in using Office 365</mark> <mark style="color:green;"></mark><mark style="color:green;">**admin credentials**</mark><mark style="color:green;">.</mark>
  * <mark style="color:green;">Grant permission by clicking</mark> <mark style="color:green;"></mark><mark style="color:green;">**Accept**</mark><mark style="color:green;">.</mark>
  * <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">**Start**</mark><mark style="color:green;">.</mark>

## Step 4: Select Migration Date Range

* <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**start date**</mark> <mark style="color:green;"></mark><mark style="color:green;">(e.g., last 1 month).</mark>
* <mark style="color:green;">Optional: Enable additional migration options if needed.</mark>

## Step 5: Choose Users for Migration

**Bulk Migration (CSV Method)**:

* <mark style="color:green;">Create a CSV file with two columns:</mark>
  * <mark style="color:green;">Google Workspace email</mark>
  * <mark style="color:green;">Office 365 email</mark>
* <mark style="color:green;">Add user pairs line-by-line.</mark>
* <mark style="color:green;">Save as</mark> <mark style="color:green;"></mark><mark style="color:green;">`.csv`</mark><mark style="color:green;">, attach it, and click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Upload and Start Migration**</mark><mark style="color:green;">.</mark>

**Individual User Migration**:

* <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Add User**</mark><mark style="color:green;">.</mark>
* <mark style="color:green;">Enter source and destination emails.</mark>
* <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Start**</mark><mark style="color:green;">.</mark>

## Final Phase

* <mark style="color:green;">Migration status will show after initialization.</mark>
* <mark style="color:green;">Time taken depends on email data size.</mark>
* <mark style="color:green;">Once completed, Office 365 data is moved to Google Workspace.</mark>



***

## REFERENCES

* [https://www.youtube.com/watch?v=9gipu8YQ1pM\&ab\_channel=MailsDaddySoftware](https://www.youtube.com/watch?v=9gipu8YQ1pM\&ab_channel=MailsDaddySoftware)
