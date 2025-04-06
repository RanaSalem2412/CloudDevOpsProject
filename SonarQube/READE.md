# SonarQube Installation and Setup on Amazon Linux
## 1- Update System and Install Required Packages
### First, update your system and install the required tools.
```
sudo yum update -y
sudo yum install unzip wget -y
```
## 2- Install Java 17
```
sudo yum install java-17-openjdk -y
```
### Verify Java Installation:
```
java -version
```
## 3- Download and Install SonarQube
### Download the SonarQube zip file:
```
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.3.0.82913.zip
```
### Unzip the downloaded file:
```
unzip sonarqube-10.3.0.82913.zip
```
### Move the SonarQube folder to the desired directory:
```
sudo mv sonarqube-10.3.0.82913 /opt/sonarqube
```
## 4-Create a User to Run SonarQube
### Create a new user to run the SonarQube service.
```
sudo useradd -m -d /opt/sonarqube -r -s /bin/false sonar
sudo chown -R sonar:sonar /opt/sonarqube
```
## 5-Set Up SonarQube as a Service
### Create a systemd service for SonarQube.
```
sudo vim /etc/systemd/system/sonarqube.service
```
### Add the following content to the file:
```
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```
##### Save and exit the file.

### Reload the systemd daemon to apply the changes:
```
sudo systemctl daemon-reload
```
### Enable and start the SonarQube service:
```
sudo systemctl enable sonarqube
sudo systemctl start sonarqube
sudo systemctl status sonarqube
```
## 6- Access SonarQube Dashboard
### Once SonarQube is running, open your browser and go to:
```
http://<server-ip>:8080
```
### Default login credentials:
#### Username: admin
#### Password: admin
## 7- Install SonarQube Scanner
#### To scan your projects with SonarQube, you need to install the SonarQube Scanner.
### Clone the project repository:
```
git clone https://github.com/IbrahimAdell/FinalProjectCode.git
```
### Install Node Version Manager (nvm):
```
nvm install 16
nvm use 16
```
### Install the SonarQube Scanner globally:
```
npm install -g sonarqube-scanner
```
### Verify the installation:
```
sonar-scanner --version
```
8- Run SonarQube Scanner
### Navigate to your project directory and run the SonarQube scanner:
```
cd FinalProjectCode
sonar-scanner\
``` 
