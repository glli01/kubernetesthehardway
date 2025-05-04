# Create VPC and security group for instances
# This VPC should have open access for SSH from the internet
# Let's for now make it so that all of them are accessible via IPv4 from the internet as well.
# Port 80, Port 443 for TCP connections.
# Public subnet ipv4 CIDRs

resource "aws_vpc" "khw-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "khw-vpc (Kubernetes The Hard Way)"
  }
}

# Add internet gateway
resource "aws_internet_gateway" "khw-internet-gateway" {
  vpc_id = aws_vpc.khw-vpc.id
  tags = {
    Name = "khw-vpc gateway"
  }
}

# Add route table that allows access to the internet
resource "aws_route_table" "second_rt" {
 vpc_id = aws_vpc.khw-vpc.id

 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.khw-internet-gateway.id
 }

 tags = {
   Name = "Secondary route table"
 }
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "Ipv4 public CIDRs"
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# availability zones in us-east-1
variable "azs" {
  type = list(string)
  description = "availability zones in us-east-1"
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d","us-east-1e", "us-east-1f" ]
}

# create subnets
resource "aws_subnet" "resource" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.khw-vpc.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "KTHW Public Subnet ${count.index + 1}"
  }
}

# Associate all subnets to public routes table
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.resource[*].id, count.index)
 route_table_id = aws_route_table.second_rt.id
}

# SECURITY GROUPS
# create TLS + outbound security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS traffic and all outbound traffic."
  vpc_id      = aws_vpc.khw-vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.khw-vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::0/0"
  ip_protocol       = -1
}

# HTTP
resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow all inbound HTTP traffic"
  vpc_id = aws_vpc.khw-vpc.id
  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.khw-vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# SSH
resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow all inbound HTTP traffic"
  vpc_id = aws_vpc.khw-vpc.id
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

