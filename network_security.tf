data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnet" "public" {
  id = var.public_subnet_id
}

data "aws_subnet" "private" {
  id = var.private_subnet_id
}

data "aws_instance" "public" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private" {
  instance_id = var.private_instance_id
}

resource "aws_security_group" "ssh" {
  name        = var.ssh_security_group_name
  description = "Allow SSH and ICMP from approved IP ranges."
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group" "public_http" {
  name        = var.public_http_security_group_name
  description = "Allow public HTTP and ICMP from approved IP ranges."
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group" "private_http" {
  name        = var.private_http_security_group_name
  description = "Allow HTTP and ICMP from the public HTTP security group."
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh.id
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "ssh_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh.id
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "public_http" {
  type              = "ingress"
  security_group_id = aws_security_group.public_http.id
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "public_http_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.public_http.id
  protocol          = "icmp"
  from_port         = -1
  to_port           = -1
  cidr_blocks       = var.allowed_ip_range
}

resource "aws_security_group_rule" "private_http" {
  type                     = "ingress"
  security_group_id        = aws_security_group.private_http.id
  protocol                 = "tcp"
  from_port                = 8080
  to_port                  = 8080
  source_security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "private_http_icmp" {
  type                     = "ingress"
  security_group_id        = aws_security_group.private_http.id
  protocol                 = "icmp"
  from_port                = -1
  to_port                  = -1
  source_security_group_id = aws_security_group.public_http.id
}

resource "aws_network_interface_sg_attachment" "public_ssh" {
  network_interface_id = data.aws_instance.public.network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "public_http" {
  network_interface_id = data.aws_instance.public.network_interface_id
  security_group_id    = aws_security_group.public_http.id
}

resource "aws_network_interface_sg_attachment" "private_ssh" {
  network_interface_id = data.aws_instance.private.network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "private_http" {
  network_interface_id = data.aws_instance.private.network_interface_id
  security_group_id    = aws_security_group.private_http.id
}
