aws_region = "us-east-1"

project_id = "cmtr-2dfktx7p"

allowed_ip_range = [
  "18.153.146.156/32",
  "203.0.113.25/32",
]

vpc_id            = "vpc-0d1591d0af2534431"
public_subnet_id  = "subnet-0e9ccebaeeb716a04"
private_subnet_id = "subnet-0a328ca7a5633fac4"

public_instance_id  = "i-0629395ebd1a74412"
private_instance_id = "i-0b8808d7e0c4f2ab8"

ssh_security_group_name          = "cmtr-2dfktx7p-ssh-sg"
public_http_security_group_name  = "cmtr-2dfktx7p-public-http-sg"
private_http_security_group_name = "cmtr-2dfktx7p-private-http-sg"
