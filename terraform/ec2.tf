variable "debian_12_instance_ami" {
  type        = string
  description = "The ami of a debian 12 (bookworm) instance"
  default     = "ami-0779caf41f9ba54f0"
}

variable "aws_pub_key" {
  type        = string
  description = "The public key used for our key pair. Passed in through TF_VAR_aws_pub_key"
  default     = ""
}

# assert
check "aws_pub_key_exists" {
  assert {
    condition     = var.aws_pub_key != ""
    error_message = "${var.aws_pub_key} returned '', meaning it has not been set. Please set it using TF_VAR_aws_pub_key"
  }
}

# Create a key pair
resource "aws_key_pair" "kubernetes-the-hard-way-tf" {
  key_name   = "kubernetes-the-hard-way-tf"
  public_key = var.aws_pub_key
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

  subnet_id = aws_subnet.resource[1].id
  # network_interface {
  #   network_interface_id = aws_network_interface.
  # }

  # Assign to security group and VPC
  vpc_security_group_ids = [aws_security_group.allow_tls.id, aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]


}

# Create server (2GB RAM - 20GB Storage - 1 CPU)

# Create node-0 (2GB RAM - 20GB Storage - 1 CPU)

# Create node-1 (2GB RAM - 20GB Storage - 1 CPU)

