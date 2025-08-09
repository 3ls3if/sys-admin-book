---
icon: wordpress
---

# Cloning a WordPress WebsitePage

## Cloning a WordPress Website

\
Cloning a WordPress website involves creation of a full website copy with all website files, the database, and settings.

You may want to clone your WordPress website in one of the following situations:

* You maintain a non-public (staging) version of a WordPress website on a separate domain or subdomain, and you want to publish it to a production domain to make it publicly available.
* You have a publicly available (production) WordPress website and you want to create a non-public (staging) copy of it, to which you can make changes without affecting the production website.
* You want to create a “master” copy of a WordPress website with preconfigured settings, plugins, and theme, and then clone it to start a new development project for a client.
* You want to create multiple copies of a WordPress website and make different changes to each one (for example, to show them to a client so that he or she can choose the one he or she likes best).

{% hint style="warning" %}
**Note:** By default, on cloned WordPress installations, the “Search engine indexing” option is turned off. To turn this option on for cloned WordPress installations, go to **WordPress**, click “Settings”, and then clear the “Turn off Search Engine Indexing for cloned websites” checkbox.
{% endhint %}

**Clone a WordPress website:**

1.  Go to **WordPress** and then click “Clone” on the card of the WordPress installation you want to clone.



    <figure><img src="https://docs.plesk.com/en-US/obsidian/administrator-guide/images/73391-clone1.webp" alt=""><figcaption></figcaption></figure>
2. Choose the target where to clone the website:
   * Keep “Create subdomain” selected to have WP Toolkit create a new subdomain with the default “staging” prefix. You can use it or type in a desired subdomain prefix.
   * Select “Use existing domain or subdomain” and then select the desired domain or subdomain from the list.

{% hint style="warning" %}
**Note:** You can change the default subdomain prefix. To do so, go to **WordPress**, click “Settings”, specify the desired prefix in the “Default subdomain prefix for cloning” text field, and then click **OK**.
{% endhint %}

<figure><img src="https://docs.plesk.com/en-US/obsidian/administrator-guide/images/73391-clone2.webp" alt=""><figcaption></figcaption></figure>



{% hint style="warning" %}
**Caution:** Make sure that the domain or subdomain selected as the target is not being used by an existing website. During cloning, website data existing on the target may be overwritten and irrevocably lost.
{% endhint %}

1. (Optional) Change the name of the database automatically created during cloning.
2. When you are satisfied with the selected target and the database name, click **Start**.

When the cloning is finished, the new clone will be displayed in the list of WordPress installations.



***

## REFERENCES

* [https://docs.plesk.com/en-US/obsidian/administrator-guide/website-management/wordpress-toolkit.73391/?\_gl=1\*1hkq8r3\*\_gcl\_au\*MjY0MTkyNzA2LjE3NTQ3MTMyNjE.\*\_ga\*MjExOTc1Mzg0OS4xNzU0NzEzMjU1\*\_ga\_5SX3L7KZCY\*czE3NTQ3MTMyNTQkbzEkZzEkdDE3NTQ3MTM3NTIkajM5JGwwJGg1ODE3ODk3NzU.#cloning-a-wordpress-website](https://docs.plesk.com/en-US/obsidian/administrator-guide/website-management/wordpress-toolkit.73391/?_gl=1*1hkq8r3*_gcl_au*MjY0MTkyNzA2LjE3NTQ3MTMyNjE.*_ga*MjExOTc1Mzg0OS4xNzU0NzEzMjU1*_ga_5SX3L7KZCY*czE3NTQ3MTMyNTQkbzEkZzEkdDE3NTQ3MTM3NTIkajM5JGwwJGg1ODE3ODk3NzU.#cloning-a-wordpress-website)
* plesk.com/kb/support/how-to-clone-a-wordpress-instance-in-plesk/

