locals {
  ssh_user = "ec2-user"
}

data "aws_security_group" "jenkins_security_group" {
  id = var.security_group
}

data "aws_subnet" "jenkins_subnet" {
  id = var.subnet_id
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "jenkins_server" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name = var.keypair_id
  associate_public_ip_address = true
  vpc_security_group_ids = [data.aws_security_group.jenkins_security_group.id]
  subnet_id = data.aws_subnet.jenkins_subnet.id
  tags = {
    "Name"       = "Jenkins_Server"
    "Managed-by" = "Terraform"
  }
  provisioner "remote-exec" {
    inline = ["echo 'wait until SSH is ready'"]
    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_file)
      host        = aws_instance.jenkins_server.public_ip
    }
  }
}

resource "null_resource" "setup_jenkins" {
  provisioner "local-exec" {
    working_dir = "../configuration/"
    command     = "ansible-playbook -u ${local.ssh_user} -i ${aws_instance.jenkins_server.public_ip}, --private-key ${var.private_key_file} jenkins-setup.yml"
  }
  triggers = {
    jenkins_server = aws_instance.jenkins_server.id
  }
  depends_on = [
    aws_instance.jenkins_server
  ]
}
