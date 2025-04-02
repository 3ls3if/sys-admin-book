---
icon: chart-pie-simple
---

# Visualize Data in Grafana

## Visualize Data in Grafana

1. **Install Grafana:**
   * <mark style="color:green;">Download and install Grafana from the official website.</mark>
   * <mark style="color:green;">Start Grafana and log in at</mark> <mark style="color:green;"></mark><mark style="color:green;">`http://localhost:3000`</mark> <mark style="color:green;"></mark><mark style="color:green;">(default credentials:</mark> <mark style="color:green;"></mark><mark style="color:green;">`admin/admin`</mark><mark style="color:green;">).</mark>
2. **Add Prometheus as a Data Source:**
   * <mark style="color:green;">Navigate to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Configuration**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Data Sources**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Add Data Source**</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Select</mark> <mark style="color:green;"></mark><mark style="color:green;">**Prometheus**</mark> <mark style="color:green;"></mark><mark style="color:green;">and set the URL as</mark> <mark style="color:green;"></mark><mark style="color:green;">`http://<Prometheus_Server_IP>:9090`</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Click</mark> <mark style="color:green;"></mark><mark style="color:green;">**Save & Test**</mark><mark style="color:green;">.</mark>
3. **Import a Dashboard:**
   * <mark style="color:green;">Go to</mark> <mark style="color:green;"></mark><mark style="color:green;">**Dashboards**</mark> <mark style="color:green;"></mark><mark style="color:green;">></mark> <mark style="color:green;"></mark><mark style="color:green;">**Import**</mark><mark style="color:green;">.</mark>
   * <mark style="color:green;">Use an existing Windows monitoring dashboard (e.g., Dashboard 2129).</mark>
   * <mark style="color:green;">Configure the data source and import.</mark>
