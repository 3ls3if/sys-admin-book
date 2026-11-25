# High Availability with Cloudflare Tunnels and Docker Swarm

## High Availability with Cloudflare Tunnels and Docker Swarm

A comprehensive guide to setting up and testing high availability (HA) for your web applications using Cloudflare Tunnels distributed across multiple VPS nodes with Docker Swarm.

### Overview <a href="#overview" id="overview"></a>

This guide shows how to deploy a highly available web application across 3 VPS nodes using:

* **Docker Swarm** for container orchestration
* **Cloudflare Tunnels** for secure, zero-config ingress
* **Overlay networks** for inter-service communication
* **Health checks** for automatic failover

The setup ensures your application remains online even if individual VPS nodes fail, with automatic load balancing across all available nodes.

### Architecture <a href="#architecture" id="architecture"></a>

```
┌─────────────────┐
│   Cloudflare    │
│     Edge        │
└────────┬────────┘
         │ Load Balancing
    ┌────┴────┬────┬────┐
    │         │    │    │
┌───▼───┐ ┌──▼──┐ ┌▼───┐ ┌▼───┐
│ VPS 1 │ │VPS 2│ │VPS 3│ │ ... │
│ NC2   │ │NC3  │ │NC4  │ │     │
└───┬───┘ └──┬──┘ └┬───┘ └┬───┘
    │       │      │      │
    └───────┴──────┴──────┘
         Docker Swarm
         Overlay Network
```

Each VPS runs:

* **Cloudflared connector** (1 replica per node)
* **Frontend service** (1 replica per node)
* **Backend service** (1 replica per node)

### Prerequisites <a href="#prerequisites" id="prerequisites"></a>

#### Infrastructure <a href="#infrastructure" id="infrastructure"></a>

* 3+ VPS nodes with Docker installed
* Docker Swarm initialized across all nodes
* Each node can communicate with others (ports 2377, 7946, 4789 open)

#### Cloudflare <a href="#cloudflare" id="cloudflare"></a>

* Cloudflare account with Zero Trust enabled
* Domain configured in Cloudflare DNS
* Cloudflare Tunnel created

#### Software <a href="#software" id="software"></a>

* Docker Engine 20.10+
* Docker Swarm mode enabled

### Setup <a href="#setup" id="setup"></a>

#### 1. Initialize Docker Swarm <a href="#id-1-initialize-docker-swarm" id="id-1-initialize-docker-swarm"></a>

On your manager node (NC2-net):

```bash
docker swarm init --advertise-addr <MANAGER_IP>
```

On worker nodes (NC3-org, NC4-de):

```bash
docker swarm join --token <TOKEN> <MANAGER_IP>:2377
```

#### 2. Create Overlay Network <a href="#id-2-create-overlay-network" id="id-2-create-overlay-network"></a>

Create an attachable overlay network for inter-service communication:

```bash
docker network create --driver overlay --subnet 10.0.1.0/24 --gateway 10.0.1.1 --attachable cloudflared-ha
```

#### 3. Get Cloudflare Tunnel Token <a href="#id-3-get-cloudflare-tunnel-token" id="id-3-get-cloudflare-tunnel-token"></a>

1. Go to Cloudflare Zero Trust → Networks → Tunnels
2. Create a new tunnel or use existing one
3. Copy the tunnel token

#### 4. Configure Cloudflared <a href="#id-4-configure-cloudflared" id="id-4-configure-cloudflared"></a>

Create a `.env` file in your cloudflared directory:

```bash
TUNNEL_TOKEN=your_tunnel_token_here
```

### Configuration Files <a href="#configuration-files" id="configuration-files"></a>

#### cloudflared.yaml <a href="#cloudflared-yaml" id="cloudflared-yaml"></a>

```yaml
services:
  cloudflared-ha:
    image: cloudflare/cloudflared:latest
    command: tunnel run
    env_file:
      - .env
    networks:
      - cloudflared-ha
    healthcheck:
      test: ["CMD", "cloudflared", "version"]
      interval: 60s
      timeout: 20s
      retries: 5
      start_period: 60s
      start_interval: 5s
    deploy:
      mode: replicated
      replicas: 3
      placement:
        max_replicas_per_node: 1
      restart_policy:
        condition: any

networks:
  cloudflared-ha:
    external: true
```

#### swarm.yaml <a href="#swarm-yaml" id="swarm-yaml"></a>

```yaml
services:
  frontend:
    image: your-registry/frontend:latest
    env_file:
      - ./frontend/.env
    networks:
      - cloudflared-ha
    healthcheck:
      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://127.0.0.1/health"]
      interval: 60s
      timeout: 20s
      retries: 5
      start_period: 60s
      start_interval: 5s
    deploy:
      mode: replicated
      replicas: 3
      placement:
        max_replicas_per_node: 1
      update_config:
        parallelism: 1
        delay: 10s
        order: start-first
      restart_policy:
        condition: any

  backend:
    image: your-registry/backend:latest
    env_file:
      - ./backend/.env
    networks:
      - cloudflared-ha
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 60s
      timeout: 20s
      retries: 5
      start_period: 60s
      start_interval: 5s
    deploy:
      mode: replicated
      replicas: 3
      placement:
        max_replicas_per_node: 1
      update_config:
        parallelism: 1
        delay: 10s
        order: start-first
      restart_policy:
        condition: any

networks:
  cloudflared-ha:
    external: true
```

### Deployment <a href="#deployment" id="deployment"></a>

#### 1. Deploy Cloudflared Stack <a href="#id-1-deploy-cloudflared-stack" id="id-1-deploy-cloudflared-stack"></a>

```bash
cd /path/to/cloudflared-ha
docker stack deploy -c cloudflared.yaml cloudflared
```

Verify deployment:

```bash
docker service ps cloudflared_cloudflared-ha
```

You should see 1 replica running on each node.

#### 2. Deploy Application Stack <a href="#id-2-deploy-application-stack" id="id-2-deploy-application-stack"></a>

```bash
cd /path/to/your-app
docker stack deploy -c swarm.yaml blog
```

Verify deployment:

```bash
docker service ps blog_frontend
docker service ps blog_backend
```

#### 3. Configure Cloudflare Tunnel Routes <a href="#id-3-configure-cloudflare-tunnel-routes" id="id-3-configure-cloudflare-tunnel-routes"></a>

In Cloudflare Zero Trust dashboard:

1. Go to Networks → Tunnels → Your tunnel
2. Add **Public Hostname**:
   * **Hostname**: `yourdomain.com`
   * **Service**: `http://frontend:80`
3. Add **Public Hostname** for API:
   * **Hostname**: `api.yourdomain.com`
   * **Service**: `http://backend:8000`

### Testing High Availability <a href="#testing-high-availability" id="testing-high-availability"></a>

#### Verify All Connectors Are Registered <a href="#verify-all-connectors-are-registered" id="verify-all-connectors-are-registered"></a>

Check Cloudflare dashboard → Networks → Connectors:

* Should show 3 connectors (1 per VPS)
* All status should be "Connected"
* Note the Connector IDs for each

#### Test Traffic Distribution <a href="#test-traffic-distribution" id="test-traffic-distribution"></a>

**Method 1: Cloudflare Live Logs**

1. Go to Zero Trust → Networks → Tunnels → Live logs
2. Access your application multiple times
3. Observe different Connector IDs handling requests

```bash
# Make multiple requests
for i in {1..10}; do curl -I https://yourdomain.com; sleep 1; done
```

You should see traffic distributed across different connector IDs.

**Method 2: Simulate Node Failure**

```bash
# Scale down cloudflared to 2 replicas
docker service scale cloudflared_cloudflared-ha=2

# Verify site still works
curl -I https://yourdomain.com

# Scale back to 3
docker service scale cloudflared_cloudflared-ha=3
```

**Method 3: Check Service Replicas**

```bash
# Check all services are running
docker service ls

# Check individual service distribution
docker service ps cloudflared_cloudflared-ha
docker service ps blog_frontend
docker service ps blog_backend
```

Each should show 1 replica per node.

#### Test Health Checks <a href="#test-health-checks" id="test-health-checks"></a>

```bash
# Check service health
docker service ps blog_frontend --format "table \t"

# Check individual container health
docker inspect <container_id> --format ''
```

#### Test Network Connectivity <a href="#test-network-connectivity" id="test-network-connectivity"></a>

```bash
# Test overlay network connectivity
docker network inspect cloudflared-ha

# Verify containers can communicate
docker exec <frontend_container> wget -qO- http://backend:8000/health
```

### Troubleshooting <a href="#troubleshooting" id="troubleshooting"></a>

#### Issue: Services Not Starting on All Nodes <a href="#issue-services-not-starting-on-all-nodes" id="issue-services-not-starting-on-all-nodes"></a>

**Symptoms:** Only some replicas running, others rejected

**Solution:**

```bash
# Check network configuration
docker network inspect cloudflared-ha

# Remove and recreate network
docker network rm cloudflared-ha
docker network create --driver overlay --subnet 10.0.1.0/24 --gateway 10.0.1.1 --attachable cloudflared-ha

# Redeploy stacks
docker stack rm cloudflared blog
docker stack deploy -c cloudflared.yaml cloudflared
docker stack deploy -c swarm.yaml blog
```

#### Issue: Health Checks Failing <a href="#issue-health-checks-failing" id="issue-health-checks-failing"></a>

**Symptoms:** Containers stuck in "health: starting"

**Solution:**

*   Verify health check command works inside container:

    ```bash
    docker exec <container_id> <health_check_command>
    ```
* Ensure required tools (curl, wget) are installed in Dockerfile
* Check health endpoint is accessible

#### Issue: Cloudflared Not Connecting <a href="#issue-cloudflared-not-connecting" id="issue-cloudflared-not-connecting"></a>

**Symptoms:** Connectors showing as disconnected in dashboard

**Solution:**

```bash
# Check cloudflared logs
docker service logs cloudflared_cloudflared-ha -f

# Verify tunnel token is correct
# Check network connectivity between nodes
# Ensure overlay network is working
```

#### Issue: No Traffic Distribution <a href="#issue-no-traffic-distribution" id="issue-no-traffic-distribution"></a>

**Symptoms:** All traffic going to single connector

**Solution:**

* Verify all connectors are registered in Cloudflare dashboard
* Check tunnel is configured for HA mode
* Use Cloudflare Live logs to verify distribution
* Ensure placement constraints allow distribution

### Best Practices <a href="#best-practices" id="best-practices"></a>

#### 1. Resource Limits <a href="#id-1-resource-limits" id="id-1-resource-limits"></a>

Add resource constraints to prevent resource exhaustion:

```yaml
deploy:
  resources:
    limits:
      cpus: '0.5'
      memory: 512M
    reservations:
      cpus: '0.25'
      memory: 256M
```

#### 2. Update Strategy <a href="#id-2-update-strategy" id="id-2-update-strategy"></a>

Use rolling updates for zero-downtime deployments:

```yaml
update_config:
  parallelism: 1
  delay: 10s
  order: start-first
  failure_action: rollback
```

#### 3. Monitoring <a href="#id-3-monitoring" id="id-3-monitoring"></a>

* Enable Cloudflare Analytics for traffic insights
* Monitor Docker Swarm service health
* Set up alerts for service failures
* Use Cloudflare Live logs for real-time debugging

#### 4. Security <a href="#id-4-security" id="id-4-security"></a>

* Use environment variables for sensitive data
* Restrict network access where possible
* Keep images updated
* Use private Docker registries
* Enable Cloudflare WAF rules

#### 5. Backup Strategy <a href="#id-5-backup-strategy" id="id-5-backup-strategy"></a>

* Backup Docker Swarm configuration
* Document tunnel tokens securely
* Version control configuration files
* Test disaster recovery procedures

### Conclusion <a href="#conclusion" id="conclusion"></a>

This HA setup provides:

* **Zero-downtime deployments** with rolling updates
* **Automatic failover** when nodes fail
* **Load balancing** across all available nodes
* **Secure ingress** without exposed ports
* **Easy scaling** by adding more nodes

The combination of Docker Swarm and Cloudflare Tunnels creates a robust, production-ready infrastructure that can handle node failures while maintaining service availability.

### Additional Resources <a href="#additional-resources" id="additional-resources"></a>

* [Cloudflare Zero Trust Documentation](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)
* [Docker Swarm Documentation](https://docs.docker.com/engine/swarm/)
* [Docker Networking](https://docs.docker.com/network/)
* [Cloudflare Tunnel Configuration](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/)

