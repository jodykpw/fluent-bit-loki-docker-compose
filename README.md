# Loki with Fluent Bit Docker Compose Setup

This repository provides a Docker Compose setup for deploying Loki and Fluent Bit in a containerised environment. Loki, a log aggregation system by Grafana, and Fluent Bit, a lightweight log shipper, are used together to provide efficient log collection and storage.

## Overview

The provided Docker Compose configuration sets up the following:

- **Loki Gateway**: Acts as a reverse proxy to handle requests to Loki's read and write endpoints.
- **Loki Read**: Handles read operations for logs.
- **Loki Write**: Manages write operations for logs.
- **Loki Backend**: Manages backend operations for Loki.
- **Fluent Bit**: Collects logs from Docker containers and forwards them to Loki.

## Prerequisites

1. **Centralised Grafana**: Ensure that Grafana is set up and running. Follow the [Setting Up Centralised Grafana using Docker Compose](https://homelab.jodywan.com/en/docker/setup-centralised-grafana-using-docker-compose) guide for setup details.

2. **MinIO**: Ensure that MinIO is set up and running on Docker VMs. Follow the [How to Set Up MinIO for Each Docker VM: A Step-by-Step Guide](https://homelab.jodywan.com/en/docker/setup-minio-per-docker-vm-guide) for detailed instructions.

3. **Reverse Proxy (Optional)**: If Loki and Grafana are not on the same Docker VM, make sure you have a reverse proxy configured. For this setup, you will need:
   - **Traefik**: Follow the [Install and Configure Traefik on Docker](https://homelab.jodywan.com/en/initial-setup/13-install-and-configure-traefik-on-docker) guide.
   - **pfSense HAProxy with Let's Encrypt and Cloudflare DNS**: Follow the [pfSense HAProxy with Let's Encrypt and Cloudflare DNS](https://homelab.jodywan.com/en/initial-setup) guide. Configure HAProxy to restrict access to Loki Gateway.

## Docker Compose Configuration

The Docker Compose file is based on the official Loki GitHub repository and has been customised to fit specific needs:

- **Integrates with Traefik**
- **Omits Promtail, Prometheus, MinIO, and Grafana**
- **Works with a shared MinIO instance**

## Configure GitLab CICD Variables: 

Make sure to set the following variables in your GitLab CI/CD settings:

* SSH_PRIVATE_KEY: Your SSH private key used for connecting to the remote server.
* SSH_DOCKER_USER: The SSH user for the remote Docker server.
* REMOTE_IPADDRESS: The IP address of the remote server.
* MINIO_ACCESS_KEY_ID: MinIO access key.
* MINIO_SECRET_ACCESS_KEY: MinIO secret access key.

## Usage

### 1. Deployment

To deploy the Loki, manually trigger the `ssh_scp_docker-compose-up` job from the GitLab CI/CD pipeline. This will:

- Upload project files to the remote server using `rsync`.
- Start all the Loki services on Docker.

### 2. Service Shutdown

To stop and remove the Loki services, manually trigger the `ssh_scp_docker-compose-down` job.

### 3. Destroying Services and Volumes

To remove the containers and associated volumes, trigger the `ssh_scp_docker-compose-remove` job.

### 4. Cleanup on Failure

If a deployment fails, the `cleanup_deployment_failure` job will automatically remove the project folder on the remote server.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🇬🇧🇭🇰 Author Information

* Author: Jody WAN
* Linkedin: https://www.linkedin.com/in/jodywan/
* Website: https://www.jodywan.com