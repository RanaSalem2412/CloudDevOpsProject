# CI/CD with ArgoCD on Minikube using Docker

### This guide documents the steps taken to complete the task of setting up ArgoCD on a local Kubernetes cluster using Minikube and Docker.

---

## 1. Prerequisites Installation

### Docker Installation

#### Before installing Minikube, Docker must be installed:
```
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version
```
### kubectl Installation
```
curl -LO "https://dl.k8s.io/release/v1.29.1/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
```
## 2. Minikube Installation and Start
### Install and run Minikube using Docker as the driver:
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/
minikube start --driver=docker
```
### Confirm Minikube is running:
```
kubectl get nodes
```
## 3. Install ArgoCD on Kubernetes
### Apply the official ArgoCD installation manifests:
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
### Confirm ArgoCD is running:
```
kubectl get pods -n argocd
```
## 4. Access ArgoCD UI
### To access the ArgoCD web interface from your browser:
```
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80
```
### Then open your browser and visit:
```
http://<your-ec2-public-ip>:8080
```
## 5. Login to ArgoCD
### Get the initial admin password:
```
kubectl -n argocd get pods -l app.kubernetes.io/name=argocd-server -o name
kubectl -n argocd exec -it <argocd-server-pod-name> -- argocd admin initial-password -n argocd
```
#### Use the username admin and the retrieved password to log in to the ArgoCD UI


