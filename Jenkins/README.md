# Jenkins CI Pipeline with Shared Library and Slave Node
##  Overview
### This repository demonstrates a CI setup using Jenkins, where:
#### - A Jenkins slave node is created and connected to the master.
#### - A Jenkins pipeline is defined using a `Jenkinsfile`.
#### - A shared library is used to modularize pipeline logic.
#### - DockerHub and GitHub credentials are configured for pushing images and manifests.
#### - Kubernetes manifests are updated and deployed automatically using ArgoCD.
---
## Step 1: Copy SSH Key to Jenkins Master
### Before connecting the slave node, the private key was securely copied to the Jenkins master to allow SSH communication.
#### Create the .ssh directory for Jenkins user
```
sudo mkdir -p /var/lib/jenkins/.ssh
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh
```
#### Transfer the private key to Jenkins master
```
scp -i C:\Users\ascom\Downloads\keypair_lab22.pem C:\Users\ascom\Downloads\keypair_lab22.pem ec2-user@<JENKINS_MASTER_IP>:/tmp/keypair_lab22.pem
```
#### Move and secure the key
```
sudo mv /tmp/keypair_lab22.pem /var/lib/jenkins/.ssh/keypair_lab22.pem
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/keypair_lab22.pem
sudo chmod 600 /var/lib/jenkins/.ssh/keypair_lab22.pem
```
#### Setup known_hosts file
```
sudo touch /var/lib/jenkins/.ssh/known_hosts
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh
sudo chmod 644 /var/lib/jenkins/.ssh/known_hosts
```
#### Add slave's host key to known_hosts
```
sudo -u jenkins ssh-keyscan -H <SLAVE_IP> | sudo tee -a /var/lib/jenkins/.ssh/known_hosts > /dev/null
```
---
## Step 2: Create and Configure Jenkins Slave (docker_agent)
### 1-Manage Jenkins → Manage Nodes and Clouds → New Node
### 2-Enter:
#### Node Name: docker_agent
#### Type: Permanent Agent
### 3-Configuration:
#### of executors: 1
#### Remote root directory: /home/ec2-user/jenkins
#### Labels: docker-agent
#### Usage: Use this node as much as possible
#### Launch method: Launch agents via SSH
#### Host: <Slave Node IP>
### 4-Add SSH Credentials:
#### Username: ec2-user
#### Private Key: Enter directly (paste contents of .pem file)
#### Click Save and Jenkins will try to connect to the agent.
##### If successful, the agent will show as "Connected" and "Online".
---
## Step 3: Create Shared Library Repo
### A new GitHub repository was created:
#### "https://github.com/RanaSalem2412/jenkins-shared-library.git"
### This repo contains:
#### vars/ folder: Groovy scripts for each pipeline stage.
#### Jenkinsfile: Main pipeline script.
#### k8s-manifests/: Kubernetes manifests for deployment.
---
## Step 4: Configure Jenkins Credentials
### In Jenkins, the following credentials were added:
#### DockerHub Credentials
##### Type: Username and Password
##### ID: dockerhub_creds
#### GitHub Credentials
##### Type: Username and Personal Access Token
##### ID:git_credential
---
## Step 5: Create Jenkins Pipeline Job
### 1-Go to Jenkins > New Item
### 2-Name: final-pipeline
### 3-Type: Pipeline
### 4-In Pipeline section:
#### -Definition: Pipeline script from SCM
#### -SCM: Git
#### -Repository URL: https://github.com/RanaSalem2412/jenkins-shared-library.git
#### -Script Path: Jenkinsfile
### 5-Click Save.
---
## Pipeline Structure
### The pipeline includes the following stages:
#### 1-Run Unit Test
#### 2-Build JAR
#### 3-Build Docker Image
#### 4-Push Docker Image
#### 5-Delete Docker Image Locally
#### 6-Update Kubernetes Manifests with New Tag
#### 7-Push Updated Manifests to GitHub
##### All these stages are modular and implemented inside the vars/ folder using Groovy.


