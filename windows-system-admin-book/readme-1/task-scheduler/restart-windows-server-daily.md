---
icon: power-off
---

# Restart Windows Server Daily



#### Steps:

1.  **Open Task Scheduler**:

    * <mark style="color:green;">Press</mark> <mark style="color:green;"></mark><mark style="color:green;">`Windows + R`</mark><mark style="color:green;">, type</mark> <mark style="color:green;"></mark><mark style="color:green;">`taskschd.msc`</mark><mark style="color:green;">, press Enter.</mark>


2.  **Create a New Task**:

    * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Create Basic Task..."**</mark>
    * <mark style="color:green;">Name it:</mark> <mark style="color:green;"></mark><mark style="color:green;">`Daily Server Restart`</mark>
    * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>


3.  **Set Trigger**:

    * <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Daily"**</mark>
    * <mark style="color:green;">Set the</mark> <mark style="color:green;"></mark><mark style="color:green;">**Start time**</mark> <mark style="color:green;"></mark><mark style="color:green;">to</mark> <mark style="color:green;"></mark><mark style="color:green;">`12:00:00 AM`</mark>
    * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark>


4. **Set Action**:
   * <mark style="color:green;">Choose</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Start a program"**</mark>
   *   <mark style="color:green;">In</mark> <mark style="color:green;"></mark><mark style="color:green;">**Program/script**</mark><mark style="color:green;">, type:</mark>

       ```
       shutdown
       ```
   *   In **Add arguments**, type:

       ```
       /r /f /t 0
       ```

       * <mark style="color:green;">`/r`</mark><mark style="color:green;">: Restart</mark>
       * <mark style="color:green;">`/f`</mark><mark style="color:green;">: Force close apps</mark>
       * <mark style="color:green;">`/t 0`</mark><mark style="color:green;">: No delay</mark>


5.  **Finish Setup**:

    * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Next**</mark><mark style="color:green;">, then</mark> <mark style="color:green;"></mark><mark style="color:green;">**Finish**</mark>


6. **(Optional) Run with highest privileges**:
   * <mark style="color:green;">Go back to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Task Scheduler**</mark><mark style="color:green;">, find your task.</mark>
   * <mark style="color:green;">Right-click ></mark> <mark style="color:green;"></mark><mark style="color:green;">**Properties**</mark>
   * <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**General**</mark><mark style="color:green;">, check</mark> <mark style="color:green;"></mark><mark style="color:green;">**"Run with highest privileges"**</mark>
   * <mark style="color:green;">Under</mark> <mark style="color:green;"></mark><mark style="color:green;">**Configure for**</mark><mark style="color:green;">, select your</mark> <mark style="color:green;"></mark><mark style="color:green;">**Windows Server version**</mark>



***

## REFERENCES

* [https://learn.microsoft.com/en-us/answers/questions/439133/server-reboot](https://learn.microsoft.com/en-us/answers/questions/439133/server-reboot)
