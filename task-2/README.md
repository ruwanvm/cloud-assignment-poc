## Approach
1. Provision EC2 instance using Terraform
2. Wait untill SSH is ready on EC2 instance
3. Install Jenkins on the EC2 using Ansible playbook (Using Terraform `null-resource`)
4. Jenkins URL will be output by terraform

> **If High Availability is required**
>* Mount `/var/lib/jenkins/jobs` to EFS (To configure Auto scaling for Jenkins)
>* Create Jenkins AMI from the EC2 instance
>* Create Launch Template using the AMI for the Jenkins Auto scaling
>* Create Jenkins Auto scaling group for high availability
>* Add Elastic Load balancer (NLB) to Auto scaling group 
----------------------------------
## Terraform module IaC

* Refer the Terraform IaC in the `infrastructure` directory and Ansible playbook on `configuration` directory
----------------------------------
## Grant SSH and HTTP access
* Security Group is added to EC2 and allow SSH & HTTP access to local workstation IP
* Wait for SSH to be ready using `remote-exec` terraform `provisioner`
* Terraform will output the jenkins URL
----------------------------------
## Approch to automating Jenkins installation

* Use `null_resource` terraform `resource` and `local-exec` terraform `provisioner` to provision and configure Jenkins on EC2

> **For high availability**
>*  Use the Jenkins AMI to launch EC2 instances behind Load Balancer attached Auto Scaling Group
>* Jenkis data is mounted to EFS backend to support Auto Scaling

----------------------------------
