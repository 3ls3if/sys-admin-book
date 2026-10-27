---
icon: code-branch
---

# A Quick Guide to Pushing Local Projects to GitHub (Branches & Versions)

Managing your code with Git and GitHub is essential for building, tracking, and maintaining projects efficiently. Whether you're creating a new repository, pushing code, or managing multiple versions, understanding a few core commands can make your workflow smooth and professional.

***

### Starting with a Local Folder

If you already have a project on your system, the first step is to turn it into a Git repository:

```
git init
git add .
git commit -m "Initial commit"
```

This initializes version control and saves your current project state.

***

### Connecting to GitHub

To push your code online, you can use GitHub CLI, which simplifies repository creation and authentication.

```
gh auth login
gh repo create your-repo-name --public --source=. --remote=origin --push
```

This creates a GitHub repository and uploads your code in one step.

***

### Working with Branches (Best Practice)

Branches allow you to work on new features or versions without affecting the main codebase.

To create and switch to a new branch:

```
git checkout -b v2.0
```

Now, any changes you make will stay in this branch.

***

### Adding a New Version from Another Folder

If your new version of the project exists in a different folder, you don’t need to replace existing files. Instead, you can add it as a separate directory:

```
cp -r /path/to/new-version ./Version2
git add Version2
git commit -m "Added Version2 folder"
git push -u origin v2.0
```

This keeps your old version intact while adding the new one cleanly.

***

### Pushing Changes to GitHub

After committing, push your changes:

```
git push -u origin v2.0
```

The `-u` flag links your branch to GitHub so future pushes are easier.

***

### Understanding What Git Does

You don’t need to manually replace files on GitHub. Git:

* Tracks changes automatically
* Updates only modified files
* Keeps version history intact

This is why using branches is powerful—you can safely experiment without breaking your main code.

***

### Managing Versions Properly

Instead of creating multiple folders like `Version2`, many developers use:

* **Branches** → for development (`feature/v2`)
* **Tags** → for releases (`v2.0`)

Example:

```
git tag v2.0
git push origin v2.0
```

***

### Recommended Workflow

A clean workflow looks like this:

```
git checkout -b feature/v2
git add .
git commit -m "New version features"
git push -u origin feature/v2
```

Later, you can merge it into `main` when it’s stable.

***

### Conclusion

* Use Git to track your code locally
* Use GitHub to store and share it
* Use branches to manage versions safely
* Avoid manually editing files on GitHub

Once you get comfortable with this workflow, managing even large and complex projects becomes easy and structured.

