---
icon: reply
---

# Set Up an Auto-Reply (Vacation Responder) in Gmail

{% hint style="warning" %}
This method is ideal if `test@test.com` is an **active Gmail account**.
{% endhint %}

## Steps:

* **Login to `test@test.com`** via Gmail.
* Click on the **Gear icon (⚙️)** > **See all settings**.
* Under the **"General"** tab, scroll to **"Vacation responder"**.
* Set it up like this:
  * **Turn ON** the vacation responder.
  * **Subject:** Email Address Change
  *   **Message:**

      <pre><code><strong>Please note that we have migrated to a new email ID. Kindly send your email to: test1@demo.com.
      </strong></code></pre>
  * **Select starting date** as today.
  * Leave the end date blank (or set one if temporary).
  * Check **“Send responses to people outside my organization”** if you want external people to get the response too.
* **Click "Save Changes"** at the bottom.

{% hint style="warning" %}
Now, anyone who emails `test@test.com` will automatically get the message.
{% endhint %}

{% hint style="danger" %}
### Important Notes:

* This sends **only one auto-reply per email address per 4 days** (Google's default behavior for vacation responders).
* If you need **every email to receive a reply**, regardless of frequency, you'd need to use **Google Apps Script** (see below).
{% endhint %}



***

## REFERENCES

* [https://support.google.com/mail/answer/25922?hl=en\&co=GENIE.Platform%3DDesktop#:\~:text=On%20your%20computer%2C%20open%20Gmail.\&text=See%20all%20settings.,Select%20Vacation%20responder%20on.](https://support.google.com/mail/answer/25922?hl=en\&co=GENIE.Platform%3DDesktop)
