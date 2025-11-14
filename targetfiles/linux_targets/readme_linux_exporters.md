# Linux Exporters

## Intro - Installation Flavors
This serves as support for a relevant blog post at https://www.mythryll.com/ here: https://www.mythryll.com/?p=3648.
It's a series of blog posts, with part 1 here: https://www.mythryll.com/?p=3329.
You can either install exporters as a package for your OS (Ubuntu, RedHat, etc) or install them as a docker container. 
This repository contains an example of a docker compose based installation.

## Installation Instructions
Just run docker compose up -d (after pulling the right image for cadvisor and tagging correctly or replacing the image in the docker-compose.yml)

## Prerequisites
You must have installed docker and docker composed. The system on which this example has been tested was an ubuntu 24.04.3 LTS virtual machine on Vmware Infrastructure (mentioned for reference).
Create a directory under /opt called 'prometheus-docker' (or choose your own name) and the following subdirectories: 
- node_exporter
- process_exporter
- ssl

If you plan to use the textfile collector you will need additional configuration and the same goes if you want to allow socket access to node exporter.

Copy the process-exporter.yml and web_config.yml files in the corresponding directories like in the repo and make sure you also put the server certificates in the ssl directory and name them accordingly.
Remember that if you have an enterprise CA that has signed the certificate, you will need that CA's chain certificate in your prometheus server to verify the target certificate when accessing the exporter page.

This is the folder and file structure in tree format:
```bash
.
├── docker-compose.yml
├── node_exporter
│   └── web_config.yml
├── process_exporter
│   └── process-exporter.yml
├── readme_node_exporter.md
└── ssl
```

## Configuration - Prepare the password
The password contained in the web_config.yaml is a hash and is produced from the original password either through online coverters or using your own script.
Check the instructions here for a complete explanation and choice of methods: https://prometheus.io/docs/guides/basic-auth/
Remember, hashed password goes in the web-config file at the target, clear text password goes in the Prometheus config (but is hidden if the config is viewer from the Prometheus server web site).
Web configuration is common for the exporters and is mentioned here: https://github.com/prometheus/exporter-toolkit/blob/master/docs/web-configuration.md
CAdvisor does not support https, a reverse proxy (Nginx or Caddy would be needed)
Be mindfull that the ssl certificate is used for all 3 services that come up with https. Also the web_config.yml file is used in both node exporter and process exporter, that's why it's mounted in process exporter service through the node_exporter folder. Should't be an issue, but keep an eye on the logs if necessary with
```bash
docker compose logs --follow --tail 500
```

## docker compose walkthrough
The blog post at https://www.mythryll.com/?p=3648 (part-2) explains the structure of the docker compose file. However here is a short recap:

### Common Settings
There are 4 services operating at a common bridge (monitor-net).
There is one volume to support persistent data for Portainer as the internal configuration data (users etc) would perish if you delete the container.

### Process Exporter
It gives more visibility for processes running on the linux host and their metrics.

### Node Exporter
Host and OS metrics for your target, with the extra ability to also host custom host data with the textfile collector (not configured in this repo yet).

### CAdvisor
Container metrics for every container running on the target docker host. This container image by google is normally hosted on the Google Artifact repository and normally the image would be 
```bash
gcr.io/cadvisor/cadvisor:v0.53.0
```
In our case we have no access to that artifact repository from within the enterprise due to security reasons so we serve this locally and the image is already installed and tagged appropriately, that's why it's referenced as team/cadvisor:v0.53.0

### Portainer
Portainer has no connection to the Prometheus and Grafana project. It's a sidecar container intended to allow management of the docker container and images on the docker host via a graphical UI. Upon first launch an admin user is created and basic configuration options are selected.