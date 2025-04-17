---
icon: cloud-arrow-down
---

# Grant Export Permission in M365 Compliance Center

{% hint style="warning" %}
**eDiscovery Manager** - An eDiscovery Manager can use eDiscovery search tools to search content locations in the organization, and perform various search-related actions such as preview and export search results. Members can also create and manage cases in Microsoft Purview eDiscovery (Standard) and Microsoft Purview eDiscovery (Premium), add and remove members to a case, create case holds, run searches associated with a case, and access case data. eDiscovery Managers can only access and manage the cases they create. They can't access or manage cases created by other eDiscovery Managers.



**eDiscovery Administrator** - An eDiscovery Administrator is a member of the eDiscovery Manager role group, and can perform the same content search and case management-related tasks that an eDiscovery Manager can perform. Additionally, an eDiscovery Administrator can:

* Access all cases that are listed on the **eDiscovery (Standard)** and **eDiscovery (Premium)** pages in the Purview portal.
* Access case data in eDiscovery (Premium) for any case in the organization.
* Manage any eDiscovery case after they add themselves as a member of the case.
* Remove members from an eDiscovery case. Only an eDiscovery Administrator can remove members from a case. Users who are members of the eDiscovery Manager subgroup can't remove members from a case, even if the user created the case.
{% endhint %}

## **Step 1: Go to Microsoft Purview Compliance Portal**

* <mark style="color:green;">Navigate to:</mark> [https://compliance.microsoft.com/permissions](https://compliance.microsoft.com/permissions)

## **Step 2: Open the Permissions Section**

* <mark style="color:green;">In the left sidebar, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Permissions"**</mark>
* <mark style="color:green;">Then click</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Roles”**</mark> <mark style="color:green;"></mark><mark style="color:green;">under the</mark> <mark style="color:green;"></mark><mark style="color:green;">**“Microsoft Purview solutions”**</mark> <mark style="color:green;"></mark><mark style="color:green;">section (if it's not already selected)</mark>

## **Step 3: Edit the eDiscovery Manager Role Group**

1. <mark style="color:green;">Find and click on</mark> <mark style="color:green;"></mark><mark style="color:green;">**“eDiscovery Manager”**</mark> <mark style="color:green;"></mark><mark style="color:green;">or</mark> <mark style="color:green;"></mark><mark style="color:green;">**“eDiscovery Administrator”**</mark>
2. <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Edit role group**</mark> <mark style="color:green;"></mark><mark style="color:green;">(or "Edit" in the top bar)</mark>
3. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Roles**</mark><mark style="color:green;">, make sure</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Export"**</mark> <mark style="color:green;"></mark><mark style="color:green;">is listed</mark>
   * <mark style="color:orange;">If not, click</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**Edit roles**</mark><mark style="color:orange;">, then</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**add "Export"**</mark>
4. <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Members**</mark><mark style="color:green;">, add the user(s) who need export access</mark>
   * <mark style="color:orange;">Click</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**Edit members**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">→</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**Add**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">→ Search and select the user →</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**Add**</mark> <mark style="color:orange;"></mark><mark style="color:orange;">→</mark> <mark style="color:orange;"></mark><mark style="color:orange;">**Done**</mark>

## **Step 4: Save Changes**

* <mark style="color:green;">Once roles and members are correctly set, click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Save**</mark><mark style="color:green;">.</mark>



***

## REFERENCES

* [https://learn.microsoft.com/en-us/purview/ediscovery-assign-permissions](https://learn.microsoft.com/en-us/purview/ediscovery-assign-permissions)
* [https://answers.microsoft.com/en-us/msoffice/forum/all/export-permissions-for-content-search/fb030dbc-f716-4f1d-bbaf-e283bb4e4c55](https://answers.microsoft.com/en-us/msoffice/forum/all/export-permissions-for-content-search/fb030dbc-f716-4f1d-bbaf-e283bb4e4c55)
