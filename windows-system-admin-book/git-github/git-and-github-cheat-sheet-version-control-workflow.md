---
icon: code-commit
---

# Git & GitHub Cheat Sheet (Version Control Workflow)

### Initialize & Setup

```
git init                     # Initialize repo
git clone <repo-url>         # Clone existing repo
git status                   # Check changes
```

***

### Add & Commit

```
git add .                    # Add all files
git add <file/folder>        # Add specific file/folder
git commit -m "message"      # Commit changes
```

***

### Branching (VERY IMPORTANT)

```
git branch                   # List branches
git branch <branch-name>     # Create branch
git checkout <branch-name>   # Switch branch
git checkout -b <branch>     # Create + switch
```

**Example:**

```
git checkout -b v2.0
```

***

### Connect to GitHub

```
git remote add origin <repo-url>
git remote -v
```

***

### Push to GitHub

```
git push origin main                 # Push main branch
git push -u origin <branch>          # First push (set upstream)
git push                             # Push after upstream set
```

**Example:**

```
git push -u origin v2.0
```

***

### Pull Updates

```
git pull origin main
git pull --rebase
```

***

### Add New Version Folder (Your Use Case)

```
git checkout -b v2.0
cp -r /path/to/new-version ./Version2
git add Version2
git commit -m "Added Version2"
git push -u origin v2.0
```

***

### Remove Files

```
git rm <file>
git rm -r <folder>
```

***

### Reset / Undo

```
git restore <file>           # Undo changes
git reset HEAD <file>        # Unstage file
git reset --hard             # Reset everything (⚠️ dangerous)
```

***

### Tags (for versions)

```
git tag v1.0
git push origin v1.0
```

***

### GitHub CLI (GitHub CLI)

#### Login

```
gh auth login
```

#### Create repo & push

```
gh repo create repo-name --public --source=. --remote=origin --push
```

#### Create repo only

```
gh repo create repo-name
```

#### Create PR

```
gh pr create --base main --head v2.0 --title "v2 release" --body "New features"
```

***

### Useful Checks

```
git log --oneline            # Commit history
git diff                     # See changes
git branch -r                # Remote branches
```

***

### Common Mistakes

* ❌ Forgetting `-u` on first push
* ❌ Working on wrong branch
* ❌ Not committing before push
* ❌ Overwriting main instead of using branch

***

### Recommended Workflow (Clean)

```
git checkout -b feature/v2
git add .
git commit -m "v2 features"
git push -u origin feature/v2
```

***

### Pro Structure (Best Practice)

* `main` → stable
* `dev` → ongoing work
* `feature/*` → new features
* `release/*` → versions
