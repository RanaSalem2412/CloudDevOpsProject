# CloudDevOpsProject
##  Project Objectives
### Build a cloud infrastructure using Terraform.
### Containerize and deploy a Java-based application using Docker and Kubernetes.
### Automate server configuration using Ansible.
### Implement CI/CD pipelines using Jenkins.
### Manage continuous deployment with ArgoCD.
### Document the entire process for reproducibility and clarity.
---
## Tools & Technologies Used
### GitHub	 ...    Source code and documentation repo
### Docker	 ...   Containerization
### Kubernetes ...	Container orchestration
### Terraform	  ... Infrastructure as Code (IaC)
### Ansible ...	Configuration management
### Jenkins ...	Continuous Integration
### ArgoCD ... 	Continuous Deployment
### SonarQube ...	Code quality analysis
### AWS	... Cloud hosting environment
---
## Project Implementation Steps
### 1. Understand the Application
#### Cloned Java application from GitHub.
#### Built .jar file and ran unit tests successfully.
#### Verified application runs and opens in browser.
---
### 2. SonarQube Setup
#### Manually installed SonarQube locally.
#### Scanned the application and validated code quality.
--- 
### 3. containerization
#### Created a Dockerfile to build the application image.
#### Built and run the Docker container successfully.
#### Verified application inside the container.
---
### 4. Kubernetes Deployment
#### Created ivolve namespace.
#### Deployed app using Deployment, Service, and Ingress resources.
#### Accessed app via the Ingress URL.
---
### 5. Infrastructure Provisioning (Terraform)
#### Created custom Terraform modules for:
##### VPC, Subnet, and Security Groups.
##### EC2 instances (2) for hosting the application.
##### S3 backend for state files.
##### CloudWatch integration for monitoring.
##### Verified infrastructure successfully created on AWS.
---
### 6. Configuration Management (Ansible)
#### Created Ansible roles and playbooks to:
##### Install Docker, Git, Java.
##### Set up Jenkins and SonarQube.
##### Configure environment variables.
##### Used dynamic inventory to target EC2 instances.
---
### 7. ArgoCD Setup
#### Deployed ArgoCD to the Kubernetes cluster.
#### Accessed ArgoCD UI
---
### 8. CI Pipeline with Jenkins
#### Created a Jenkins pipeline with the following stages:
##### Unit Test
##### Build JAR
##### Build Docker Image
##### Push Docker Image
##### Delete Local Image
##### Update Kubernetes Manifests
#### Implemented Jenkins Shared Library.
#### Used Jenkins slave for execution.
--- 
### 9. ArgoCD for Deployment
#### Accessed ArgoCD UI and connected to the Git repository.
#### Synced and deployed application using ArgoCD.
#### Accessed application through browser








