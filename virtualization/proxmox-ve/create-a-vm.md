---
icon: vr-cardboard
---

# Create a VM

Now that you logged in to the Proxmox web console, follow these steps to create a virtual machine.

1\. Make sure you have ISO images for installation mediums. Move to the resource tree on the left side of your [GUI](https://phoenixnap.com/glossary/what-is-gui).

Select the server you are running and click on **local (pve1)**. Select **ISO Images** from the menu and choose between uploading an image or downloading it from a URL.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/upload-iso-image-on-proxmox-ve.png" alt="Add ISO images to Proxmox VE." height="243" width="752"><figcaption></figcaption></figure>

2\. Once you have added an ISO image, spin up a virtual machine. Click the **Create VM** button.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/create-vm-in-proxmox-ve.png" alt="Start creating a VM on Proxmox." height="226" width="733"><figcaption></figcaption></figure>

3\. Provide general information about the [VM](https://phoenixnap.com/glossary/what-is-a-virtual-machine):

* Start by selecting the **Node**. If you are starting and have no nodes yet, Proxmox automatically selects node 1 (**pve1**).
* Provide a **VM ID**. Each resource has to have a unique ID.
* Finally, specify a **name** for the VM.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/adding-general-information-for-proxmox-virtual-machine.png" alt="General options for setting up a virtual machine." height="200" width="731"><figcaption></figcaption></figure>

3\. Next, switch to the **OS** tab and select the **ISO image** you want for your VM. Define the **OS Type** and [kernel Version](https://phoenixnap.com/kb/check-linux-kernel-version). Click **Next** to continue.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/select-os-for-proxmox-virtual-machine.png" alt="Select OS for Proxmox virtual machine." height="242" width="731"><figcaption></figcaption></figure>

4\. Modify system options (such as the **Graphic card** and **SCSI controller**) or leave the default settings.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/system-options-for-proxmox.png" alt="System options for proxmox." height="186" width="732"><figcaption></figcaption></figure>

5\. Configure any **Hard Disk** options you want the VM to have. You can leave all the default settings. However, if the physical server uses an [SSD](https://phoenixnap.com/glossary/what-is-ssd), enable the **Discard** option.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/hard-disk-options-for-proxmox-vm.png" alt="Hard disk options for Proxmox VM." height="246" width="732"><figcaption></figcaption></figure>

6\. The number of **Cores** the physical server has determines how many cores you can provide to the VM. The number of cores allocated also depends on the predicted workload.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/set-cpu-options-for-proxmox-virtual-machine.png" alt="Set CPU options for Proxmox virtual machine." height="201" width="730"><figcaption></figcaption></figure>

7\. Next, choose how much **RAM Memory (MiB)** you want to assign to the VM.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/configure-memory-for-virtual-machine.png" alt="Configure memory for virtual machine." height="183" width="731"><figcaption></figcaption></figure>

8\. Move on to the **Network** tab. It is recommended to separate the management interface from the VM network. For now, leave the default setting and click **Next**.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/configure-network-options-for-vm.png" alt="Configure network options for VM." height="221" width="730"><figcaption></figcaption></figure>

9\. Proxmox loads the _Confirm_ tab that summarizes the selected VM options. To start the VM immediately, check the box under the listed information or start the VM manually later. Click **Finish** to create the VM.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/vm-summary.png" alt="VM summary." height="492" width="727"><figcaption></figcaption></figure>

10\. The newly created VM appears in the resource tree on the left side of the screen. Click the VM to see its specifications and options.

<figure><img src="https://phoenixnap.com/kb/wp-content/uploads/2022/01/proxmox-virtual-machine.png" alt="Proxmox virtual machine." height="425" width="751"><figcaption></figcaption></figure>

**Note:** Learn how to [delete a VM in Proxmox](https://phoenixnap.com/kb/proxmox-delete-vm). The guide includes both the command line and GUI methods for deleting VM, VM disks, and VM snapshots.
