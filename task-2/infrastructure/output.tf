output "jenkins_url" {
  value = "http://${module.jenkins_ec2.jenkins_server_ip}:8080"
}
