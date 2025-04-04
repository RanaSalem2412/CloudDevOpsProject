## 1. Setting Up the Dynamic Inventory
#### Inside the my_project directory, create a dynamic inventory file named aws_ec2.yaml:
```
---
- name: Configure EC2 Instances
  hosts: all
  become: true
  roles:
    - git_install
    - docker_install
    - java_install
    - jenkins_install
    - sonarqube_install
```
## 2. Copying the EC2 Key Pair
####  Copy the private key (keypair_lab22.pem) used when launching the EC2 instances:
```
cp keypair_lab22.pem ~/.ssh/keypair_lab22.pem
chmod 400 ~/.ssh/keypair_lab22.pem
```
## 3. Testing Connectivity with Ansible Ping
Verify that the EC2 instances are reachable using Ansible:
```
ansible all -i aws_ec2.yaml -m ping --private-key=~/.ssh/keypair_lab22.pem
```
## 4. Creating Ansible Roles
#### 4.1 Installing Git
##### Create a role for Git installation:
```
ansible-galaxy init git_install
```
##### Edit git_install/tasks/main.yaml:
```
---
- name: Install Git
  package:
    name: git
    state: present
```
#### 4.2 Installing Docker
##### Create a role for Docker installation:
```
ansible-galaxy init docker_install
```
##### Edit docker_install/tasks/main.yaml:
```
---
- name: Install Docker with all components
  yum:
    name:
      - docker
      - containerd
    state: present
    update_cache: yes  
  become: yes   

- name: Start and enable Docker service
  service:
    name: docker
    state: started
    enabled: yes   
  become: yes

- name: Add user to docker group
  user:
    name: ec2-user  
    groups: docker
    append: yes  
  become: yes
```
#### 4.3 Installing Java
##### Create a role for Java installation:
```
ansible-galaxy init java_install
```
##### Edit java_install/tasks/main.yaml:
```
---
- name: Install Java 17
  become: yes
  yum:
    name: java-17-amazon-corretto                                                                                                          
    state: present
```
#### 4.4 Installing Jenkins
##### Create a role for Jenkins installation:
```
ansible-galaxy init jenkins_install
```
##### Edit jenkins_install/tasks/main.yaml:
```
---
- name: Add Jenkins repository
  get_url:
    url: "https://pkg.jenkins.io/redhat-stable/jenkins.repo"
    dest: "/etc/yum.repos.d/jenkins.repo"

- name: Import Jenkins GPG key
  rpm_key:
    key: "https://pkg.jenkins.io/redhat-stable/jenkins.io.key"
    state: present
    validate_certs: no

- name: Install Jenkins
  yum:
    name: jenkins
    state: present
    disable_gpg_check: yes  

- name: Ensure Jenkins service is enabled and started
  systemd:
    name: jenkins
    enabled: yes
    state: started
```
#### 4.5 Installing SonarQube
##### Create a role for SonarQube installation:
```
ansible-galaxy init sonarqube_install
```
##### Edit sonarqube_install/tasks/main.yaml:
```
---
- name: Ensure the SonarQube directory exists
  file:
    path: /opt/sonarqube
    state: directory
    mode: '0755'
    owner: sonar
    group: sonar

- name: Download SonarQube
  get_url:
    url: "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.2.0.77647.zip"
    dest: /opt/sonarqube/sonarqube-10.2.0.77647.zip
    mode: '0644'

- name: Unzip SonarQube
  unarchive:
    src: /opt/sonarqube/sonarqube-10.2.0.77647.zip
    dest: /opt/sonarqube/
    remote_src: yes
    owner: sonar
    group: sonar

- name: Ensure correct ownership of SonarQube files
  file:
    path: /opt/sonarqube
    recurse: yes
    owner: sonar
    group: sonar
    mode: '0755'

- name: Ensure SonarQube service is enabled and started
  systemd:
    name: sonarqube
    state: started
    enabled: yes
```
## 5. Creating the Playbook
#### Inside my_project, create a playbook named install_packages.yml:
```
---
- name: Configure EC2 Instances
  hosts: all
  become: true
  roles:
    - git_install
    - docker_install
    - java_install
    - jenkins_install
    - sonarqube_install
```
## 6. Running the Playbook
#### To execute the playbook, use the following command:
```
ansible-playbook -i aws_ec2.yml install_packages.yml --private-key=~/.ssh/keypair_lab22.pem
```
## 7. Additional Configuration
### Variables for SonarQube
#### Edit sonarqube_install/vars/main.yaml:
```
---
# Variables for SonarQube installation
sonar_version: "10.2.0.77647"
```
### Handlers for SonarQube
#### Edit sonarqube_install/handlers/main.yaml:
```
---
# handlers file for sonarqube_install

- name: Restart SonarQube
  systemd:
    name: sonarqube
    state: restarted
    enabled: yes
# Handler to restart SonarQube service after changes
- name: Restart SonarQube
  systemd:
    name: sonarqube
    state: restarted
```
