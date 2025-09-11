---
icon: microsoft
---

# Install Docker: Windows Server

## Windows Server

To run a Windows container, you must have a supported container runtime available on your machine. The runtimes currently supported on Windows are [Moby](https://mobyproject.org/), the [Mirantis Container Runtime](https://www.mirantis.com/software/mirantis-container-runtime), and [containerd](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd).

This section shows you how to install each runtime on a VM that runs Windows Server. For the Moby and containerd runtimes, you can use PowerShell scripts to complete the installation in a few steps.



## [Docker CE / Moby](https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=dockerce#tabpanel_1_dockerce)

Docker Community Edition (Docker CE) provides a standard runtime environment for containers. The environment offers a common API and command-line interface. The framework and components of Docker CE are managed by the open-source community as part of the [Moby Project](https://mobyproject.org/).

To get started with Docker on Windows Server, use the following command to run the [install-docker-ce.ps1](https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1) PowerShell script. This script configures your environment to enable container-related OS features. The script also installs the Docker runtime.

PowerShellCopy

```powershell
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1
.\install-docker-ce.ps1
```

For detailed information about configuring Docker Engine, see [Docker Engine on Windows](https://learn.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon).



***

## REFERENCES

* [https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/run-your-first-container](https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/run-your-first-container)
* [https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=dockerce](https://learn.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment?tabs=dockerce)
