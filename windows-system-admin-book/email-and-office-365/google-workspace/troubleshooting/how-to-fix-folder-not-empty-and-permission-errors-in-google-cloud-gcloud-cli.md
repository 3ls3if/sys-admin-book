---
icon: folder-check
---

# How to Fix “Folder Not Empty” and Permission Errors in Google Cloud (gcloud CLI)

Managing resources in Google Cloud using the CLI can sometimes lead to confusing errors—especially when dealing with folders and projects. Two of the most common issues are:

* **Permission denied when deleting a project**
* **Precondition failure when deleting a folder**

This article explains why these errors occur and how to resolve them step by step.

***

### Understanding the Resource Hierarchy

Google Cloud organizes resources in a hierarchy:

```
Organization (optional)
   └── Folder(s)
         └── Subfolder(s)
               └── Project(s)
```

Each level must be cleaned up from the bottom up. This means:

* You cannot delete a folder if it contains subfolders or projects
* You cannot delete a subfolder if it still contains projects

***

### Common Errors Explained

#### 1. Permission Denied When Deleting a Project

You may see an error like:

```
ERROR: (gcloud.projects.delete) does not have permission
```

**Cause:**

* You are trying to delete a project without sufficient permissions
* Or you are using the wrong account

**Required Roles:**

* Project Owner (`roles/owner`)
* OR Project Deleter (`roles/resourcemanager.projectDeleter`)

***

#### 2. Folder Not Empty Error

```
FAILED_PRECONDITION: The folder being deleted is non-empty
```

**Cause:**

* The folder still contains:
  * Projects
  * Subfolders

***

### Step-by-Step Solution

#### Step 1: List Resources Inside the Folder

List subfolders:

```
gcloud resource-manager folders list --folder FOLDER_ID
```

List projects:

```
gcloud projects list --filter="parent.id=FOLDER_ID"
```

***

#### Step 2: Delete All Projects

Delete each project:

```
gcloud projects delete PROJECT_ID
```

Or automate:

```
for p in $(gcloud projects list --filter="parent.id=FOLDER_ID" --format="value(projectId)"); do
  gcloud projects delete $p --quiet
done
```

> Note: Deleted projects enter a 30-day recovery period but no longer block folder deletion.

***

#### Step 3: Delete Subfolders

Once all projects are removed:

```
gcloud resource-manager folders delete SUBFOLDER_ID
```

***

#### Step 4: Delete the Parent Folder

Finally:

```
gcloud resource-manager folders delete FOLDER_ID
```

***

### Troubleshooting Tips

#### Check Active Account

```
gcloud auth list
```

Switch account:

```
gcloud config set account YOUR_ACCOUNT
```

***

#### Verify Permissions

```
gcloud projects get-iam-policy PROJECT_ID
```

***

### Best Practices

* Always verify resource type (Project vs Folder) before deleting
* Use automation for bulk deletions
* Ensure proper IAM roles before performing destructive actions
* Clean resources in hierarchical order: **Projects → Subfolders → Folders**

***

### Conclusion

Most deletion errors in Google Cloud come down to two things:

1. Incorrect resource targeting
2. Insufficient permissions
3. Ignoring resource hierarchy

By understanding how Google Cloud structures resources and following a bottom-up deletion approach, you can avoid these issues entirely and manage your environment efficiently.
