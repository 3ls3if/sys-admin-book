---
icon: windows
---

# Monitoring Windows Servers Using Prometheus

## Introduction

Monitoring is a critical aspect of server management, ensuring system health, performance optimization, and quick detection of issues. Prometheus, an open-source monitoring tool, is widely used for collecting and visualizing system metrics. In this tutorial, we will set up Prometheus to monitor various Windows servers using the Windows Exporter (formerly known as WMI Exporter).

## Prerequisites

Before starting, ensure you have:

* <mark style="color:green;">A Windows server to monitor</mark>
* <mark style="color:green;">A Linux server or another system to host Prometheus</mark>
* <mark style="color:green;">Basic knowledge of Prometheus and Windows administration</mark>

## Step 1: Install Windows Exporter

Windows Exporter is an agent that exposes system metrics to Prometheus.

1. **Download Windows Exporter:**
   * <mark style="color:green;">Go to the</mark> [<mark style="color:red;">Windows Exporter GitHub releases</mark>](https://github.com/prometheus-community/windows_exporter/releases) <mark style="color:green;">page.</mark>
   * <mark style="color:green;">Download the latest</mark> <mark style="color:green;"></mark><mark style="color:green;">`.msi`</mark> <mark style="color:green;"></mark><mark style="color:green;">installer.</mark>
2. **Install Windows Exporter:**
   * <mark style="color:green;">Run the installer and follow the prompts.</mark>
   * <mark style="color:green;">By default, it runs on port</mark> <mark style="color:green;"></mark><mark style="color:green;">`9182`</mark><mark style="color:green;">.</mark>
3. **Verify Installation:**
   * <mark style="color:green;">Open a web browser and go to</mark> <mark style="color:green;"></mark><mark style="color:green;">`http://localhost:9182/metrics`</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">If installed correctly, it will show various system metrics.</mark>

## Step 2: Configure Prometheus

1. **Install Prometheus** (if not already installed):
   * <mark style="color:green;">Download Prometheus from the official website.</mark>
   * <mark style="color:green;">Extract the archive and navigate to the Prometheus directory.</mark>
2.  **Edit the Prometheus Configuration File (`prometheus.yml`)**: Add the Windows Exporter target to Prometheus:

    ```
    scrape_configs:
      - job_name: 'windows_servers'
        static_configs:
          - targets: ['<Windows_Server_IP>:9182']
    ```

    <mark style="color:green;">Replace</mark> <mark style="color:green;"></mark><mark style="color:green;">`<Windows_Server_IP>`</mark> <mark style="color:green;"></mark><mark style="color:green;">with the actual IP address of the Windows server.</mark>
3.  **Start Prometheus:** Run Prometheus using:

    ```
    ./prometheus --config.file=prometheus.yml
    ```
4. **Verify Prometheus Configuration:**
   * <mark style="color:green;">Open a web browser and navigate to</mark> <mark style="color:green;"></mark><mark style="color:green;">`http://<Prometheus_Server_IP>:9090/targets`</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Ensure that the Windows server is listed and marked as</mark> <mark style="color:green;"></mark><mark style="color:green;">`UP`</mark><mark style="color:green;">.</mark>

