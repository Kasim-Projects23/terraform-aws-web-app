# Networking Module – VPC

## Overview

This module builds the AWS networking infrastructure for the web application. It creates a VPC, public subnet, Internet Gateway, route table and the routing configuration needed for internet connectivity.

The networking module is kept separate from the security and web-server modules to make the infrastructure easier to manage and maintain.

## Resources

| Resource | Purpose |
|---|---|
| `aws_vpc.main` | Creates the project VPC |
| `aws_subnet.public` | Creates the public subnet |
| `aws_internet_gateway.main` | Connects the VPC to the internet |
| `aws_route_table.public` | Defines routing for the public subnet |
| `aws_route.public_internet` | Routes internet-bound traffic through the Internet Gateway |
| `aws_route_table_association.public` | Associates the public subnet with the route table |

## Network Configuration

| Setting | Value |
|---|---|
| AWS Region | `eu-west-2` |
| VPC CIDR | `10.0.0.0/16` |
| Public Subnet CIDR | `10.0.1.0/24` |
| Availability Zone | `eu-west-2a` |

The VPC and subnet CIDRs are supplied through Terraform variables rather than being hardcoded into the resources.

DNS support and DNS hostnames are enabled on the VPC to support DNS resolution and public DNS hostnames for instances.

## Public Subnet

The public subnet is deployed within the VPC and configured to automatically assign public IPv4 addresses to instances launched into it.

The subnet is associated with a route table containing a default route to the Internet Gateway. This allows instances with public IP addresses to communicate with the internet, subject to their security group rules.

## Internet Connectivity

An Internet Gateway is attached to the VPC and referenced by the public route table.

The route table contains a default IPv4 route:

- Destination: `0.0.0.0/0`
- Target: Internet Gateway

The public subnet is associated with this route table using `aws_route_table_association.public`.

Together, these resources provide the routing required for the EC2 web server to receive HTTP traffic from the internet and return responses.

## Module Inputs

| Variable | Description |
|---|---|
| `project_name` | Used for resource naming and tagging |
| `vpc_cidr` | CIDR range for the VPC |
| `subnet_cidr` | CIDR range for the public subnet |
| `availability_zone` | Availability Zone for the subnet |

## Module Outputs

| Output | Description |
|---|---|
| `vpc_id` | ID of the created VPC |
| `public_subnet_id` | ID of the public subnet |

These outputs are consumed by the other modules:

- **Security:** Uses `module.networking.vpc_id` to create the security group within the VPC.
- **Web Server:** Uses `module.networking.public_subnet_id` to deploy the EC2 instance into the public subnet.

## Design Decisions

For this project, I kept the networking architecture relatively simple, using a single public subnet in one Availability Zone.

This was sufficient for deploying and testing the EC2-hosted web application without introducing additional networking components.

The project currently does not include private subnets, NAT Gateways, multiple Availability Zones or load balancing. These could be introduced in a future iteration to improve the architecture and availability.

## Related Documentation

- [Security Module](../security/security.md)
- [Web Server Module](../web-server/web-server.md)
- [Project README](../../README.md)
