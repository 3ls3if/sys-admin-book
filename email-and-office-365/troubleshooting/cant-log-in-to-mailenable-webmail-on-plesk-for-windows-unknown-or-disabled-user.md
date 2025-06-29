---
icon: user-magnifying-glass
---

# Can't log in to MailEnable webmail on Plesk for Windows: Unknown or Disabled User!

### Symptoms <a href="#h_01jcrz5z1v42cesxy9jy3wc28t" id="h_01jcrz5z1v42cesxy9jy3wc28t"></a>

Trying to log in to a Plesk email account with MailEnable webmail fails:

Unknown or Disabled User!

### Cause <a href="#h_01jcrz5z1vk2n26tb8tfhf25yb" id="h_01jcrz5z1vk2n26tb8tfhf25yb"></a>

The mailbox password was changed outside Plesk (i.e. on MailEnable admin console or webmail interface), and Plesk was updated or repaired after.\
Passwords are replaced with the ones from the Plesk database during upgrades and mail repair; this overwrites changes made outside Plesk, leaving a mismatch in credentials.

### Resolution <a href="#h_01jcrz5z1vpdaxxembt6gptsww" id="h_01jcrz5z1vpdaxxembt6gptsww"></a>

Reset the password using the Plesk interface.

1. <mark style="color:green;">Log in to</mark> [<mark style="color:green;">Plesk</mark>](https://support.plesk.com/hc/en-us/articles/12377667582743)
2. <mark style="color:green;">Go to the affected mailbox in</mark> <mark style="color:green;"></mark><mark style="color:green;">**Domains > example.com > Mail**</mark> <mark style="color:green;"></mark><mark style="color:green;">tab</mark> <mark style="color:green;"></mark><mark style="color:green;">**> Mail Accounts > jdoe@example.com**</mark>
3. <mark style="color:green;">Enter the password in the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Password**</mark> <mark style="color:green;"></mark><mark style="color:green;">and</mark> <mark style="color:green;"></mark><mark style="color:green;">**Confirm password**</mark> <mark style="color:green;"></mark><mark style="color:green;">fields</mark>
4. <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">**OK**</mark> <mark style="color:green;"></mark><mark style="color:green;">to save the changes</mark>



***

## REFERENCES

* [https://support.plesk.com/hc/en-us/articles/12376963931799-Can-t-log-in-to-MailEnable-webmail-on-Plesk-for-Windows-Unknown-or-Disabled-User](https://support.plesk.com/hc/en-us/articles/12376963931799-Can-t-log-in-to-MailEnable-webmail-on-Plesk-for-Windows-Unknown-or-Disabled-User)
