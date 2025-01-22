---
icon: torii-gate
---

# Introduction

## What is Proxmox VE?

Proxmox VE (Virtual Environment) is an open-source, enterprise-grade server virtualization platform. It allows users to manage virtual machines (VMs), containers, and software-defined storage, all within a unified web-based interface. Proxmox VE is commonly used in IT environments for server consolidation, application development, and hosting due to its ease of use and robust feature set.

## Key Features of Proxmox VE

1. **Virtualization Technologies**:
   * **KVM (Kernel-based Virtual Machine)**: For full virtualization of operating systems.
   * **LXC (Linux Containers)**: For lightweight OS-level virtualization.
2. **Web-Based Management**:
   * Offers a user-friendly web interface for managing VMs, containers, storage, and networks.
3. **High Availability (HA)**:
   * Supports clustering for high availability, ensuring minimal downtime for services.
4. **Storage Options**:
   * Supports a variety of storage types, including local disks, shared storage (NFS, iSCSI, Ceph), and ZFS.
5. **Backup and Restore**:
   * Provides integrated backup tools to create consistent backups of VMs and containers.
6. **Networking**:
   * Advanced networking features, including virtual networks, VLANs, and bridges, for flexible configurations.
7. **Built-in Firewall**:
   * Offers a cluster-wide firewall to secure virtual machines and containers.
8. **Ceph Integration**:
   * Deep integration with Ceph, a distributed storage system, for scalable and resilient storage solutions.
9. **Open Source**:
   * Fully open-source and free to use under the GNU AGPLv3 license. Optional paid support plans are available.
10. **Extensive Community and Ecosystem**:
    * Backed by an active user community and extensive documentation.

## Use Cases

* Data centers for hosting virtual servers.
* Development and testing environments.
* Home labs for IT professionals and hobbyists.
* Business applications requiring efficient resource utilization.



{% hint style="success" %}
Proxmox VE simplifies server management while offering powerful features suitable for both small-scale and large-scale deployments.
{% endhint %}

## Hardware Requirements

* **Processor**:
  * Multi-core processor (e.g., Intel Xeon or AMD EPYC) for better multitasking and handling multiple VMs/containers.
  * Hardware virtualization extensions (Intel VT-x/AMD-V and Intel VT-d/AMD-Vi for I/O passthrough).
* **Memory**:
  * 16 GB of RAM or more for small to medium workloads.
  * At least 2 GB of RAM per virtual machine or container for typical workloads.
* **Storage**:
  * SSD or NVMe drives for faster I/O operations.
  * Use RAID configurations (RAID 10, RAID 5, or ZFS RAID-Z) for redundancy and performance.
  * For enterprise storage, consider Ceph or other distributed storage systems.
* **Network**:
  * 10 Gigabit Ethernet (or higher) for high-performance networking in clustered environments.
  * Multiple NICs for segregating management traffic, VM traffic, and storage traffic.
* **GPU** (Optional):
  * For workloads requiring GPU acceleration (e.g., AI/ML tasks, video rendering, or gaming VMs), ensure your GPU supports PCIe passthrough.

## Example Deployment Sizes

* **Home Lab/Small Deployment**:
  * CPU: 4-core processor.
  * RAM: 16 GB.
  * Storage: 256 GB SSD.
  * Network: 1 Gbps NIC.
* **Medium Business Deployment**:
  * CPU: 8-core processor.
  * RAM: 64 GB.
  * Storage: Multiple SSDs in RAID 10 (e.g., 2 TB total).
  * Network: 10 Gbps NICs (for clustering).
* **Enterprise Deployment**:
  * CPU: Dual 16-core Xeon or EPYC processors.
  * RAM: 256 GB or more.
  * Storage: Distributed Ceph cluster or NVMe-based storage.
  * Network: Redundant 10 Gbps NICs with separate VLANs for management and storage.

## Software Requirements

* **Proxmox VE Installation ISO** or a clean Debian 12 installation.
* **Modern web browser** for management.
* **Static IP configuration**.
* **Virtualization-enabled hardware**.



***

## REFERENCES

* [https://noted.lol/proxmox-for-beginners/](https://noted.lol/proxmox-for-beginners/)
* [https://www.youtube.com/watch?v=GaP-wkyfLrQ\&list=PL8cE5Nxf6M6bBTixIuAAViwXBqlk4PBOh\&index=1\&ab\_channel=TechArkit](https://www.youtube.com/watch?v=GaP-wkyfLrQ\&list=PL8cE5Nxf6M6bBTixIuAAViwXBqlk4PBOh\&index=1\&ab_channel=TechArkit)



