## 1-Project Structure
terraform-project/
│── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── server/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── main.tf
│── variables.tf
│── backend.tf
│── provider.tf
│── README.md
```
 mkdir terraform-project && cd terraform-project
 mkdir modules
 mkdir modules/network
 mkdir modules/server
 touch main.tf variables.tf provider.tf backend.tf 
 touch modules/network/{main.tf,variables.tf,outputs.tf}
 touch modules/server/{main.tf,variables.tf,outputs.tf}
```
### Modules:
##### network: Defines VPC, Subnet, and Security Groups.
#### server: Defines EC2 instances and integrates CloudWatch monitoring.

---
## 2- install terraform
```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform
```
### verify version:
```
terraform -version
```
## 3-creat s3 bucket:
```
aws s3 mb s3://my-terraform-state-bucket-rana --region us-east-1
```
## 4-search for AMI ID :
```
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' --region us-east-1
```
## 5-apply terraform:
```
terraform init
terraform plan
terraform apply -auto-approve
```
## Resources Provisioned:
#### VPC (Virtual Private Cloud): A custom VPC with CIDR block 10.0.0.0/16.
#### Subnet: A public subnet in the VPC with CIDR block 10.0.1.0/24.
#### Security Groups: A security group that allows inbound traffic on ports 22 (SSH) and 80 (HTTP).
#### 2 EC2 Instances: Two EC2 instances for application deployment, placed in the public subnet.
#### CloudWatch Monitoring: Integrated with CloudWatch to monitor CPU utilization and send alerts via SNS when the CPU exceeds a threshold.
#### S3 Backend: Terraform state is stored remotely in an S3 bucket to enable collaboration and maintain state consistency.
#### SNS Topic for Alerts: Used to notify via email when the CloudWatch alarm is triggered.
#### Route Table: A custom route table associated with the public subnet, which routes traffic to the Internet Gateway for outbound traffic.
#### Internet Gateway: An internet gateway (IGW) attached to the VPC, allowing communication between the EC2 instances and the internet.



