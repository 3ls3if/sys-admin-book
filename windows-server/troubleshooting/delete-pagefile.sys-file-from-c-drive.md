---
icon: trash-can-clock
---

# Delete pagefile.sys file from C drive

The **`pagefile.sys`** file in Windows is not a regular file — it’s a **system-managed virtual memory (paging file)** used when your RAM is full. You generally **should not delete it manually**, as it can cause instability, crashes, or performance issues.

That said, if you want to remove or reduce it, you need to do it through **Windows settings**:

1. **Open Virtual Memory Settings**
   *   <mark style="color:purple;">Press</mark> <mark style="color:purple;"></mark><mark style="color:purple;">`Win + R`</mark><mark style="color:purple;">, type:</mark>

       ```
       sysdm.cpl
       ```

       <mark style="color:purple;">and hit</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Enter**</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">Go to the</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Advanced**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">tab →</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Performance**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">→</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Settings**</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">In the</mark> <mark style="color:purple;"></mark>_<mark style="color:purple;">Performance Options</mark>_ <mark style="color:purple;"></mark><mark style="color:purple;">window, open the</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Advanced**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">tab → under</mark> <mark style="color:purple;"></mark>_<mark style="color:purple;">Virtual Memory</mark>_ <mark style="color:purple;"></mark><mark style="color:purple;">click</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Change**</mark><mark style="color:purple;">.</mark>
2. **Disable Pagefile**
   * <mark style="color:purple;">Uncheck</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Automatically manage paging file size for all drives**</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">Select</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**C: drive**</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">Choose</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**No paging file**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">→ click</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Set**</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">Click</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**OK**</mark><mark style="color:purple;">.</mark>
3. **Restart Your PC**
   * <mark style="color:purple;">After the reboot, Windows will no longer lock</mark> <mark style="color:purple;"></mark><mark style="color:purple;">`pagefile.sys`</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">The file will disappear automatically in most cases.</mark>
4. **If Still Visible** (rare)
   * <mark style="color:purple;">Open</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**File Explorer**</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">Enable hidden + system files:</mark>
     * <mark style="color:purple;">Go to</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**View**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">→</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Show**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">→ check</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Hidden items**</mark><mark style="color:purple;">.</mark>
     * <mark style="color:purple;">Also in</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Options**</mark> <mark style="color:purple;"></mark><mark style="color:purple;">→</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**View tab**</mark><mark style="color:purple;">, uncheck</mark> <mark style="color:purple;"></mark><mark style="color:purple;">**Hide protected operating system files**</mark><mark style="color:purple;">.</mark>
   * <mark style="color:purple;">Navigate to \*</mark>_<mark style="color:purple;">C:\*</mark>_ <mark style="color:purple;"></mark><mark style="color:purple;">and manually delete</mark> <mark style="color:purple;"></mark><mark style="color:purple;">`pagefile.sys`</mark><mark style="color:purple;">.</mark>

***

{% hint style="warning" %}
⚠️ **Important Warning:**

\
Deleting `pagefile.sys` means Windows will have **no virtual memory backup**. If your RAM fills up, programs may crash or the system may freeze
{% endhint %}



***

## REFERENCES

* [https://www.youtube.com/watch?v=Tuc9OIoQToI\&t=2s](https://www.youtube.com/watch?v=Tuc9OIoQToI\&t=2s)
