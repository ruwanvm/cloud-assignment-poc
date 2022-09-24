output "jenkins_server_ip" {
  value = aws_instance.jenkins_server.public_ip
}