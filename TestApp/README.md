# Gradle Application on Amazon Linux
## Prerequisites
### Before you begin installing and running the application, ensure that you have the necessary tools and environment installed on your machine.

## 1- Install Required Tools
### Run the following commands to install the required tools:
```
sudo yum install -y git java-17-amazon-corretto unzip wget
```
## 2- Verify Java Version
### Verify that Java version 17 is installed using the following command:
```
java -version
```
## 3- Clone the Application from GitHub
### To download the project, follow these steps:
```
cd /home/ec2-user
```
### Clone the project from GitHub:
```
git clone https://github.com/IbrahimAdell/FinalProjectCode.git
```
### Navigate to the web-app folder:
```
cd FinalProjectCode/web-app
```
## 4- Grant Execute Permissions to Gradle
### Before running the gradlew script, you need to give it execute permissions:
```
chmod +x gradlew
```
## 5- Build the Application
### To build the project using Gradle, run the following command:
```
./gradlew build
```
## 6- Run the Application
### After a successful build, you can run the application using the following command:
```
java -jar build/libs/*.jar
```
## 7- Verify the Application is Running
### Ensure that the application is running successfully on port 8081 by opening a browser and navigating to the following URL:
```
http://your-ec2-ip:8081
```
#### Replace your-ec2-ip with the actual EC2 IP address.
