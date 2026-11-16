# Web Server Module – EC2

## Overview

This module creates the EC2 instance that hosts the web application. It uses Amazon Linux 2023, installs Nginx during the initial boot process and serves a basic HTML website.

The web-server module uses the public subnet created by the networking module and the security group created by the security module.

## Resources

| Resource | Purpose |
|---|---|
| `data.aws_ssm_parameter.al2023_ami` | Retrieves the latest Amazon Linux 2023 AMI ID |
| `aws_instance.web` | Creates the EC2 instance hosting the web application |

## AMI Selection

The module retrieves the Amazon Linux 2023 AMI using an AWS Systems Manager Parameter Store public parameter.

This avoids hardcoding an AMI ID into the Terraform configuration and allows the instance to use the latest Amazon Linux 2023 kernel-default x86_64 AMI available through the parameter.

## EC2 Configuration

The EC2 instance is configured with the following:

| Setting | Configuration |
|---|---|
| AMI | Amazon Linux 2023 |
| Instance type | Configurable through `instance_type` |
| Subnet | Public subnet from networking module |
| Security group | Security group from security module |
| Public IP | Automatically associated |
| Key pair | Configurable through `key_name` |

The instance is deployed into the public subnet and receives a public IPv4 address to allow internet access to the website and SSH access from the approved IP.

## Instance Metadata Security

The instance requires IMDSv2 by setting:

```hcl
metadata_options {
  http_tokens = "required"
}
```

This requires token-based access when retrieving instance metadata, providing additional protection against certain metadata access attacks.

## Root Storage

The EC2 instance uses an encrypted root EBS volume with the following configuration:

| Setting | Value |
|---|---|
| Encryption | Enabled |
| Volume type | gp3 |
| Volume size | 8 GB |
| Delete on termination | Enabled |

The root volume is encrypted to protect stored data. The volume is also configured to be deleted when the EC2 instance is terminated.

## User Data and Nginx Installation

The EC2 instance uses a user data script to configure the web server during its initial boot.

The script:

1. Uses Bash strict mode to stop execution if a command fails or an error occurs.
2. Installs Nginx using `dnf`.
3. Creates a basic HTML page in `/usr/share/nginx/html/index.html`.
4. Enables Nginx to start automatically on boot.
5. Starts the Nginx service immediately.

The website displays a basic confirmation message indicating that the application has been deployed successfully using Terraform on AWS.

The `user_data_replace_on_change` setting is enabled, meaning changes to the user data will cause Terraform to replace the EC2 instance rather than simply updating its user data configuration.

## Module Inputs

| Variable | Description |
|---|---|
| `project_name` | Name used to identify project resources |
| `subnet_id` | ID of the public subnet where the EC2 instance is deployed |
| `security_group_id` | ID of the security group attached to the instance |
| `instance_type` | EC2 instance type, defaulting to `t3.micro` |
| `key_name` | Name of the EC2 key pair used for SSH access |

## Module Outputs

| Output | Description |
|---|---|
| `instance_id` | ID of the EC2 web server |
| `public_ip` | Public IPv4 address of the web server |
| `public_dns` | Public DNS name of the web server |

These outputs are passed through the root module and can be used to identify the instance or access the deployed website.

## Design Decisions

- Amazon Linux 2023 was selected as the operating system for the web server.
- The AMI is retrieved through AWS Systems Manager Parameter Store instead of hardcoding an AMI ID.
- The EC2 instance is deployed in a public subnet to allow direct internet access.
- IMDSv2 is required to improve instance metadata security.
- Root storage is encrypted using an 8 GB gp3 EBS volume.
- Nginx is installed and configured automatically using EC2 user data.
- Changes to user data trigger instance replacement to ensure the updated configuration is applied.
- The instance uses a configurable EC2 key pair for SSH access.

## Related Documentation

- [Networking Module](../networking/networking.md)
- [Security Module](../security/security.md)
- [Project README](../../README.md)
