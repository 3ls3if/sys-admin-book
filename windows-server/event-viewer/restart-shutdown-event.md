---
icon: power-off
---

# Restart / Shutdown Event

## Using Windows Event Viewer

{% hint style="warning" %}
* **Event ID 41** should say “The system has rebooted without shutting down first.” You’ll see this if your PC reboots without a proper shutdown.
* **Event ID 1074** may have varying messages depending on how the PC was shutdown. However, it always happens when a program or the user initiates a shutdown.
* **Event ID 1076** lets you know why the PC was shut down or restarted. It can give you more insight into why something happened.
* **Event ID 6005** should be labeled as “The event log service was started.” This is synonymous with system startup.
* **Event ID 6006** should be labeled as “The event log service was stopped.” This is synonymous with system shutdown.
* **Event ID 6008** should say “The previous system shutdown at \[time] on \[date] was unexpected.” This is a sign your PC started up after an improper shutdown.
* **Event ID 6009** has varying messages based on your processor. However, it means your processor was detected at a specific time.
* **Event ID 6013** should say “The system uptime is \[time.]” This shows how long your PC’s been on. This is the time in seconds.
{% endhint %}



## Using Command Prompt or Powershell



1. Press <kbd>Win</kbd> + <kbd>R</kbd> to open the Run dialog.
2. Type “cmd” and press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Enter</kbd> to open Command Prompt with elevated admin privileges.
3. Enter the following command and replace the Event ID number with the number you want to see. In this case, it’s “6006.”

```
wevtutil qe system "/q:*[System [(EventID=6006)]]" /rd:true /f:text /c:1
```

<figure><img src="../../.gitbook/assets/image (11) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
If you want to check out multiple codes at once, it’s easier to use PowerShell. Press <kbd>Win</kbd> + <kbd>X</kbd> and select “Terminal (Admin)” or “PowerShell (Admin)” depending on your version of Windows.
{% endhint %}

1. Enter the following command. Replace the numbers in the brackets to include any Event ID numbers you want

```powershell
Get-EventLog -LogName System |? {$_.EventID -in (6005,6006,6008,6009,1074,1076)} | ft TimeGenerated,EventId,Message -AutoSize -wrap
```

<figure><img src="../../.gitbook/assets/image (12) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (13) (1) (1).png" alt=""><figcaption></figcaption></figure>

## Using TurnedOnTimesView

{% hint style="warning" %}
[TurnedOnTimesView](https://www.nirsoft.net/utils/computer_turned_on_times.html) is a simple, portable tool for analyzing the event log for startup and shutdown history. The utility can be used to view the list of shutdown and startup times of local computers or any remote computer connected to the network. The utility works on any Windows version from Windows 2000 to Windows 10. That being said, it also functions well on Windows 11, as per our tests.
{% endhint %}

1. Since it is a portable tool, you will only need to unzip and execute the TurnedOnTimesView.exe file.
2. It will immediately list the startup time, shutdown time, duration of uptime between each startup and shutdown, shutdown reason, and shutdown code.

<figure><img src="https://www.maketecheasier.com/assets/uploads/2023/06/how-to-see-pc-startup-and-shutdown-history-in-windows-turnedontimes.jpg" alt="TurnedOnTimesView program in action." height="425" width="731"><figcaption></figcaption></figure>

3. It will also display a “Shutdown Reason” which is usually associated with Windows Server machines where you have to give a reason if you are shutting down the server. If you have a non-server edition of Windows, you likely won’t see a “Shutdown Reason” listed.
4. Press <kbd>F9</kbd> to go to “Advanced Options.”
5. Select “Remote Computer” under “Data Source.”

<figure><img src="https://www.maketecheasier.com/assets/uploads/2023/06/see-pc-startup-shutdown-remote-computer-option-menu.jpg" alt="Switching to &#x22;Remote Computer&#x22; option in &#x22;Data Source.&#x22;" height="527" width="589"><figcaption></figcaption></figure>

6. Specify the IP address or name of the computer in the “Computer Name” field and press the “OK” button. Now the list will show the details of the remote computer.

<figure><img src="https://www.maketecheasier.com/assets/uploads/2023/06/how-to-see-pc-startup-and-shutdown-history-in-windows-turnedontimes-advanced.jpg" alt="Specifying IP address under &#x22;Computer Name&#x22; in TurnedOnTimesView program." height="527" width="589"><figcaption></figcaption></figure>

While you can always use the event viewer for detailed analysis of startup and shutdown times, TurnedOnTimesView serves the purpose with a very simple interface and to-the-point data.



{% hint style="warning" %}
If TurnedOnTimesView isn’t quite right for you, try [LastActivityView](https://nirsoft.net/utils/computer_activity_view.html). It comes from the same developers. Not only does it show the startup and shutdown activity, but shows if files and programs were opened, system crashes network connections/disconnections, and more. It’s a good way to see what happened during an unexpected system startup/shutdown if you’re working on a Windows 11/10/8/7/Vista computer.

Another option is [Shutdown Logger](https://www.appsvoid.com/products/shutdown-logger/), which is compatible with Windows 11/10/8/7 As the name implies, it tells you when your PC was shut down. However, it adds a few more nice features, including who was logged in before the shutdown and the PC uptime. It offers only a 30-day free trial, though.
{% endhint %}



***

## REFERENCES

* [https://www.maketecheasier.com/see-pc-startup-and-shutdown-history-in-windows/](https://www.maketecheasier.com/see-pc-startup-and-shutdown-history-in-windows/)
* [https://www.nirsoft.net/utils/computer\_turned\_on\_times.html](https://www.nirsoft.net/utils/computer_turned_on_times.html)
* [https://www.nirsoft.net/utils/computer\_activity\_view.html](https://www.nirsoft.net/utils/computer_activity_view.html)
* [https://serverfault.com/questions/702828/windows-server-restart-shutdown-history](https://serverfault.com/questions/702828/windows-server-restart-shutdown-history)
