variable "aws_region" { default = "us-east-1" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "vpc_name" { default = "MyVPC" }
variable "public_subnet_cidr" { default = "10.0.1.0/24" }
variable "public_subnet_az" { default = "us-east-1a" }
variable "ami_id" { default = "ami-072e42fd77921edac" }  # Amazon Linux 2
variable "instance_type" { default = "t2.medium" }
variable "key_name" { default = "keypair_lab22" }
