variable "debian_12_instance_ami" {
  type        = string
  description = "The ami of a debian 12 (bookworm) instance"
  default     = "ami-0779caf41f9ba54f0"
}

# Create a key pair
resource "aws_key_pair" "kubernetes-the-hard-way-tf" {
  key_name   = "kubernetes-the-hard-way-tf"
  public_key = tls_private_key.rsa.public_key_openssh
}
# RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Store locally
resource "local_file" "tf_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "terraform-the-hard-way-tf"
}

# Create the jump-box
resource "aws_instance" "jump-box" {
  ami           = var.debian_12_instance_ami
  instance_type = "t2.micro"
  key_name      = aws_key_pair.kubernetes-the-hard-way-tf.key_name

  # Assign 10 GB of storage
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  # network_interface {
  #   network_interface_id = aws_network_interface.jump-box_vnic.id
  #   device_index = 0
  # }

  associate_public_ip_address = true

  subnet_id = aws_subnet.resource[1].id

  # Assign to security group and VPC
  vpc_security_group_ids = [aws_security_group.allow_tls.id, aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]

  tags = {
    Name = "jump-box"
  }
}

# Create server (2GB RAM - 20GB Storage - 1 CPU) Create node-0 (2GB RAM - 20GB Storage - 1 CPU) Create node-1 (2GB RAM - 20GB Storage - 1 CPU)
variable "instance_names" {
  type = list(string)
  default = ["server", "node-0", "node-1"]
}
resource "aws_instance" "server_and_nodes" {
  count = length(var.instance_names)
  ami           = var.debian_12_instance_ami
  instance_type = "t2.small" # 2GB RAM
  key_name      = aws_key_pair.kubernetes-the-hard-way-tf.key_name

  # Assign 10 GB of storage
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  associate_public_ip_address = true

  subnet_id = aws_subnet.resource[1].id

  # Assign to security group and VPC
  vpc_security_group_ids = [aws_security_group.allow_tls.id, aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]

  tags = {
    Name = element(var.instance_names,count.index)
  }
}
