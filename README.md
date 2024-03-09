# Bash Scripts for Setting Up Wordpress, with Apache Web Server, MySQL Database Server, and Backup Dumps. 
Deployed for AWS, EC2 Instances of Ubuntu

This repository contains Bash scripts for automating the setup of various server components on Ubuntu. 
The scripts are designed to simplify the process of setting up a web server, MySQL database server, and performing backup dumps.

## Scripts Overview
**install_wpserver.sh**: This script automates the installation and configuration of a web server - Apache and instlls wordpress on an Ubuntu system.
It installs necessary dependencies, sets up virtual hosts, and configures firewall rules.

**install_sqlserver.sh**: This script automates the installation and configuration of a MySQL database server on an Ubuntu system. It installs MySQL Server.
Sets up initial configurations, and secures the installation.

**backup.sh**: This script performs backup dumps of MySQL databases. 
It can be scheduled as a cron job to regularly create backups of databases and store them in a specified directory.

## Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your_username/bash-scripts.git
   cd bash-scripts
2. Give .sh files execution permission  - chmod +x filename.sh
3. run the script -  ./filename.sh
