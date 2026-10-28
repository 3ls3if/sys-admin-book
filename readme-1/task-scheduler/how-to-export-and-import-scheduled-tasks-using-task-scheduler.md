---
icon: gears
---

# How to export and import scheduled tasks using Task Scheduler

## How to export and import scheduled tasks using Task Scheduler

### Exporting tasks with Task Scheduler <a href="#exporting-tasks-with-task-scheduler-3" id="exporting-tasks-with-task-scheduler-3"></a>

To export a scheduled task using Task Scheduler, use these steps:

1. Open **Start**.
2. Search for **Task Scheduler**, and click the top result to open the experience.
3. Browse to the location of the scheduled task that you want to export.
4. Right-click the item, and select the **Export** option.

<figure><img src="https://cdn.mos.cms.futurecdn.net/CAsApjcFGRUbH8dPpSxyK7.jpg" alt=""><figcaption></figcaption></figure>

5. Browse and open the folder to export the task.
6. Click the **Save** button.

<figure><img src="https://cdn.mos.cms.futurecdn.net/ei3AN7t3DyRcvCGVB7sQCe.jpg" alt=""><figcaption></figcaption></figure>

Once you complete these steps, you'll end up with a .xml file that you can then import to another machine or another installation of Windows Server.

Using Task Scheduler, you can only export (or import) one task at a time, as such you'll need to repeat the steps to export additional scheduled tasks.

***

### Importing tasks with Task Scheduler <a href="#importing-tasks-with-task-scheduler-3" id="importing-tasks-with-task-scheduler-3"></a>

To import a scheduled task on Windows 10, use these steps:

**Important:** This option will only restore the task; it'll not restore the script or application that the task will execute. If you're importing a task that runs a script or starts an application, you need to make sure that those resources exist on the device before proceeding with the steps below. Otherwise, the scheduled task will fail.

1. Open **Start**.
2. Search for **Task Scheduler**, and click the top result to open the experience.
3. Browse to the import location.
4. Right-click the folder, and select the **Import Task** option.

<figure><img src="https://cdn.mos.cms.futurecdn.net/CEdgHpzbw6kafq4Rp3aVNQ.jpg" alt=""><figcaption></figcaption></figure>

5. Browse and open the folder with the scheduled task.
6. Select the task.
7. Click the **Open** button.

<figure><img src="https://cdn.mos.cms.futurecdn.net/MGp9re2mhNRLvg74UqtqG6.jpg" alt=""><figcaption></figcaption></figure>

8. Optional: Update the scheduled task settings as necessary.
9. Click the **OK** button.

After completing the steps, the task will import automatically on your device.



***

## REFERENCES

* [https://www.windowscentral.com/how-export-and-import-scheduled-tasks-windows-10](https://www.windowscentral.com/how-export-and-import-scheduled-tasks-windows-10)
