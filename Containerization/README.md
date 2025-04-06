# Docker Containerization for Application

## Steps Followed

### 1. Install Docker and Verify Version
#### The first step is to install Docker on your machine or EC2 instance
```
sudo yum update -y
sudo yum install docker -y
sudo systemctl enable --now docker
```
####  After installation, you can check the installed version using the following command:
```
docker --version
```
### 2. Clone the GitHub Repository
#### Next, clone the repository containing the application code using the following command:
```
git clone https://github.com/IbrahimAdell/FinalProjectCode.git
```
### 3. Build the Application Using Gradle
#### Navigate to the cloned repository and build the application with Gradle. The command used for this step is:
```
cd FinalProjectCode
./gradlew build -x test
```
###### This will build the application, skipping the tests.

### 4. Verify the JAR File Exists
#### After the build process completes, check if the JAR file was generated in the build/libs/ directory. You can do this by running:
```
ls -l build/libs/
```
###### You should see the generated .jar file in this directory.

### 5. Create the Dockerfile
#### Create a Dockerfile to containerize the application. The Dockerfile was created with the following content:
```
FROM amazoncorretto:17                                                                                                                                                                                                                          
RUN yum install -y git


WORKDIR /app

RUN git clone https://github.com/IbrahimAdell/FinalProjectCode.git /app


WORKDIR /app/web-app


RUN chmod +x gradlew


RUN ./gradlew build -x test


RUN cp build/libs/*SNAPSHOT.jar app.jar



EXPOSE 8080


CMD ["java", "-jar", "app.jar"]
```
### 6. Build the Docker Image
#### Once the Dockerfile is created, build the Docker image using the following command:
```
docker build -t my-java-app .
```
###### This command will build the Docker image with the tag my-java-app.

### 7. Run the Docker Container
#### After building the image, run the container using the following command:
```
docker run -p 8080:8081 my-java-app
```
###### This command maps port 8080 on the host to port 8081 in the container, allowing you to access the application from your local machine.

### 8. Access the Application Locally
#### To check if the application is running, use curl to send a request to the application on localhost:
```
curl http://localhost:8080
```
###### This should return the application's homepage or status page.

### 9. Access the Application via EC2 Public IP
###### If you are running Docker on an EC2 instance, replace <EC2-PUBLIC-IP> with your EC2 instance's public IP address and access the application via a browser:
```
http://<EC2-PUBLIC-IP>:8080
```
##### This will allow you to view the application from your browser.


