 # Deploying a Spring Boot Application on Minikube with Ingress
## Prerequisites
### Docker: Installed for building container images.
### kubectl: Kubernetes command-line tool for interacting with the cluster.
### Minikube: Tool for running Kubernetes clusters locally.
### Helm: Kubernetes package manager for deploying applications.

## Steps
### 1. Install Docker
```
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user
```
#### Log out and log back in to apply group changes.

### 2. Install kubectl
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```
#### Verify the installation:
```
kubectl version --client
```  
### 3. Install Minikube
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
#### Start Minikube:
```
minikube start --driver=docker
```
### 4. Clone the Application Repository
```
git clone https://github.com/RanaSalem2412/CloudDevOpsProject.git
cd CloudDevOpsProject
```   
### 5. Build the Docker Image
#### Navigate to the directory containing the Dockerfile and build the image:
```
docker build -t myapp:v1 .
```
### 6. Load the Docker Image into Minikube
```
minikube image load myapp:v1
```
### 7. Create Kubernetes Deployment and Service
#### Create a deployment YAML file (deployment.yaml):
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  namespace: ivolve
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:v1
        ports:
        - containerPort: 80
```
#### Create a service YAML file (service.yaml):
```
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
  namespace: ivolve
spec:
  ports:
    - port: 80        
      protocol: TCP
      targetPort: 8081 
  selector:
    app: myapp        
  type: ClusterIP    
  ```  
#### Apply the deployment and service:
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
### 8. Install Ingress Controller Using Helm
#### Add the Ingress NGINX repository:
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```
#### Install the Ingress NGINX controller:
```
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace kube-system
```
#### Verify the Ingress controller pods are running:
```
kubectl get pods -n kube-system | grep ingress
```
#### Check the services to find the Ingress controller service:
```
kubectl get svc -n kube-system | grep ingress
```
### 9. Expose the Application Using Ingress
#### Create an Ingress resource YAML file (ingress.yaml):
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
  namespace: ivolve
  annotations:
    nginx.ingress.kubernetes.io/service-upstream: "true"
spec:
  ingressClassName: nginx
  rules:
    - host: myapp.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: myapp-service
                port:
                  number: 80
 ```               
#### Apply the Ingress resource:
```
kubectl apply -f ingress.yaml
```
### 10. Access the Application
#### Add an entry to your /etc/hosts file to map myapp.local to the Minikube IP:
```
sudo sh -c 'echo "$(minikube ip) myapp.local" >> /etc/hosts'
```
Verify access:
```
curl  http://myapp.local
```
