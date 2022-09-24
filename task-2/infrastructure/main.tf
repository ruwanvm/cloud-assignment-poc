resource "tls_private_key" "jenkins_rsa_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "jenkins_key_pair" {
  key_name   = "jenkins_key"
  public_key = tls_private_key.jenkins_rsa_key.public_key_openssh
  tags = {
    "Name"       = "jenkins_key"
    "Managed-by" = "Terraform"
  }
}

resource "local_file" "jenkins_private_key_file" {
  content         = tls_private_key.jenkins_rsa_key.private_key_pem
  filename        = "/home/ruwan/.ssh/jenkins.pem"
  file_permission = "0600"
}

data "http" "workstation_ip" {
  url = "https://api.ipify.org"
}
data "aws_vpc" "jenkins_vpc" {
  id = var.jenkins_vpc_id
}

resource "aws_security_group" "jenkins_sg" {
  name   = "jenkins_server_sg"
  vpc_id = data.aws_vpc.jenkins_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.workstation_ip.body)}/32"]
    description = "Allow SSH access"
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.workstation_ip.body)}/32"]
    description = "Allow HTTP access"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name"       = "Jenkins_security_group"
    "Managed-by" = "Terraform"
  }
}

module "jenkins_ec2" {
  source = "./modules/jenkins"
  security_group = aws_security_group.jenkins_sg.id
  subnet_id = var.jenkins_subnet_a_id
  keypair_id = aws_key_pair.jenkins_key_pair.id
  private_key_file = local_file.jenkins_private_key_file.filename
}