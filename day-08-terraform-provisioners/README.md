# Terraform Day 08 – Provisioners

## Topics Covered

- AWS Key Pair creation
- VPC creation
- Public Subnet
- Internet Gateway
- Route Table and Route Table Association
- Security Group configuration
- EC2 instance provisioning
- SSH connection using Terraform `connection` block
- `file` provisioner for copying files to a remote instance
- `remote-exec` provisioner for executing commands on the EC2 instance
- `local-exec` provisioner for running commands on the local machine
- Provisioner execution order and lifecycle
- Automatic server configuration using a shell script
- Nginx installation and configuration through Terraform
- Custom web page deployment using a provisioning script
- Usage of `path.module` and `pathexpand()`
- Public IP assignment for EC2 instances


## Provisioning Flow

```text
Terraform Apply
      │
      ▼
Create AWS Infrastructure
      │
      ▼
Launch EC2 Instance
      │
      ▼
Establish SSH Connection
      │
      ▼
Copy setup.sh to EC2 (file provisioner)
      │
      ▼
Execute setup.sh (remote-exec)
      │
      ▼
Install and Configure Nginx
      │
      ▼
Deploy Custom Web Page
      │
      ▼
Execute Local Command (local-exec)
```

## Provisioners Used

### File Provisioner

Copies a local file from the Terraform machine to the EC2 instance over SSH.

### Remote Exec Provisioner

Executes commands on the remote EC2 instance after it has been created.

### Local Exec Provisioner

Executes commands on the machine where Terraform is running.

## Script Automation

The provisioning script performs tasks such as:

- Updating package repositories
- Installing Nginx
- Creating a custom HTML page
- Enabling the Nginx service
- Starting the web server automatically

## AWS Resources Created

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association
- Security Group
- EC2 Instance
- AWS Key Pair