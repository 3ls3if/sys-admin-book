---
icon: cloud-binary
---

# Create a Shared Library (SharePoint) for Large Data

## Create a Shared Library (SharePoint) for Large Data

> A **Shared Library** is actually a **SharePoint Document Library**.\
> OneDrive for Business is built on top of SharePoint, which has **much higher sharing tolerance**.

***

### 🔹 Prerequisites

You **must have** one of these:

* Microsoft 365 Business
* OneDrive for Business (work/school account)
* Access to SharePoint Online

❌ This **will not work** with _personal_ OneDrive.

***

### STEP 1: Open SharePoint

1. Go to 👉 [**https://www.office.com**](https://www.office.com)
2. Sign in with your **work/school Microsoft account**
3. Click **App launcher (9 dots)** → **SharePoint**

***

### STEP 2: Create a New SharePoint Site

1. Click **Create site**
2. Choose **Team site**
3. Fill:
   * **Site name**: e.g. `LargeDataShare`
   * **Privacy**: Private (recommended)
4. Click **Next → Finish**

⏱ Takes \~30 seconds to provision.

***

### STEP 3: Create a Document Library (Shared Library)

1. Open your newly created site
2. Click **New → Document library**
3. Name it something like:
   * `Projects`
   * `Archive`
   * `SharedData`
4. Click **Create**

This is your **shared library**.

***

### STEP 4: Upload / Move Your 400 GB Data

#### ✅ Option A: Sync Locally (BEST)

This avoids browser upload limits.

1. In the document library → click **Sync**
2. OneDrive app opens
3. A new folder appears on your PC:

```
C:\Users\<you>\SharePoint\LargeDataShare\
```

1. **Move or copy** your large folders into this directory
2. Let OneDrive sync in background

✔ Handles **hundreds of GB safely**\
✔ Resume supported\
✔ No size-based sharing block

***

#### ⚠ Option B: Upload via Browser

Works, but **not recommended** for 400 GB.

***

### STEP 5: Share the Library (Key Step)

1. Open the **Document Library**
2. Click **Settings (⚙) → Library settings**
3. Click **Permissions for this document library**
4. Click **Share**
5. Add:
   * Emails of users
   * Or create a **shareable link**

You can grant:

* **View**
* **Edit**

📌 This shares **everything inside**, regardless of size.

***

### STEP 6: (Optional) Add Shortcut to OneDrive

For recipients:

1. Open the shared library
2. Click **Add shortcut to OneDrive**

Now it appears like a **normal folder** in their OneDrive.

***

### Why This Works (Important)

| OneDrive Personal      | SharePoint Library |
| ---------------------- | ------------------ |
| Folder share limits    | Designed for TBs   |
| Sync-root restrictions | Enterprise-grade   |
| Limited permissions    | Fine-grained ACLs  |

This bypasses the **“folder too large to share”** error completely.

***

### ⚠ Important Notes

* Total storage depends on your **Microsoft 365 plan**
* Sharing is **faster & more reliable**
* Ideal for:
  * Teams
  * Large archives
  * Long-term access
