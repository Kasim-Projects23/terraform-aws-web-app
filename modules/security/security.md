# Security Module – Security Group

## Overview

This module manages the security group for the web application EC2 instance. It controls inbound and outbound traffic to help restrict network access.

The security group allows public HTTP access to the website, restricts SSH access to an approved IP address, and allows outbound HTTP and HTTPS traffic.

The security module is separate from the networking and web-server modules to keep the infrastructure organised and easier to maintain.

## Resources

| Resource | Purpose |
|---|---|
| `aws_security_group.web` | Creates the security group for the web application |
| `aws_vpc_security_group_ingress_rule.http` | Allows inbound HTTP traffic on port 80 |
| `aws_vpc_security_group_ingress_rule.ssh` | Allows inbound SSH traffic on port 22 from an approved IP |
| `aws_vpc_security_group_egress_rule.http` | Allows outbound HTTP traffic on port 80 |
| `aws_vpc_security_group_egress_rule.https` | Allows outbound HTTPS traffic on port 443 |

## Inbound Rules

The security group allows the following inbound traffic:

| Protocol | Port | Source | Purpose |
|---|---|---|---|
| TCP | 80 | `0.0.0.0/0` | Allows public access to the website over HTTP |
| TCP | 22 | `ssh_allowed_cidr` | Allows SSH access from an approved public IP |

HTTP access is open to the public because the website is intended to be accessible over the internet.

SSH access is restricted to an approved IP address rather than allowing connections from anywhere. This reduces unnecessary exposure of the EC2 instance.

## Outbound Rules

The security group allows the following outbound traffic:

| Protocol | Port | Destination | Purpose |
|---|---|---|---|
| TCP | 80 | `0.0.0.0/0` | Allows outbound HTTP connections |
| TCP | 443 | `0.0.0.0/0` | Allows outbound HTTPS connections |

Outbound HTTP and HTTPS are permitted to support package downloads, software installation and external connectivity requirements.

Other outbound protocols and ports are restricted.

## Security Group Configuration

The security group is created within the VPC provided by the networking module.

The `revoke_rules_on_delete` setting is enabled to revoke security group rules before deletion.

The security group also includes project-related tags to help identify and manage AWS resources.

## Module Inputs

| Variable | Description |
|---|---|
| `project_name` | Name used to identify project resources |
| `vpc_id` | ID of the VPC where the security group is created |
| `ssh_allowed_cidr` | Public IPv4 CIDR allowed to connect over SSH |

## Module Outputs

| Output | Description |
|---|---|
| `security_group_id` | ID of the security group created by this module |

The security group ID is passed to the web-server module and attached to the EC2 instance.

## Design Decisions

- HTTP access is allowed publicly to make the website accessible over the internet.
- SSH access is restricted to an approved public IP rather than allowing access from anywhere.
- Outbound HTTP and HTTPS are allowed to support package downloads and external connectivity.
- Other outbound protocols and ports are restricted rather than allowing unrestricted outbound traffic.
- Security groups are stateful, meaning response traffic for permitted inbound connections is automatically allowed without requiring separate outbound response rules.

This provides basic network-level security for the web application while keeping the configuration straightforward and manageable.

## Related Documentation

- [Networking Module](../networking/networking.md)
- [Web Server Module](../web-server/web-server.md)
- [Project README](../../README.md)
