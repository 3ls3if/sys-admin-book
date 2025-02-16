---
icon: pills
---

# Restrict access to a Google Workspace service

## Restrict access to a Google Workspace service

In the previous exercise, you created two OUs beneath your top-level organization. One benefit of applying an organizational structure like this is that you can now enable and disable services at an OU level. Child OUs normally inherit settings from above, but it’s also possible to override inheritance at the OU level to provide greater flexibility.



***

## Exercise directions

**Grant the executive board exclusive access to AI Studio**

**Step 1**

If you are not already signed in, sign in to your domain as the Administrator at [admin.google.com](https://admin.google.com/)

**Step 2**

From the main menu, select **Apps**, then click **Additional Google services**.

**Step 3**

In the **Additional Google services** panel, under the Organizational units dropdown, select your top-level organizational unit from the list of OUs.

**Step 4**

Check the box for the AI Studio row in the list of services, and click on the 3 dots icon at the end of the row. Then click **OFF (Override)**.

**Step 5**

Click **TURN OFF** to confirm the change. This disables the service for everyone in your organization. We must now enable the service for your Executive OU.

**Step 6**

On the left, click **Executive** OU.

**Step 7**

Scroll down the list of services and locate the AI Studio service. Notice that the service is OFF. This setting has been inherited from the top level organization. Hover over AI Studio, and click on the 3 dots icon at the end of the row. Then click **ON (Override)**.

**Step 8**

Click **TURN ON** to confirm the change. Users in the Executive OU now have access to AI Studio. Users in the root organization and any other child OU cannot use the service.



**Please note:** Changes can take 24 hours to propagate to all users.
