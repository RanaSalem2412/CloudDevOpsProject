# Deploying an Application with ArgoCD on Kubernetes
## 1. Installing ArgoCD on the Kubernetes Cluster
### 1.1 Install ArgoCD in the `argocd` Namespace
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
### 1.2 Verify ArgoCD Pods
#### Check that the ArgoCD pods are running correctly:
```
kubectl get pods -n argocd
```
## 2. Accessing the ArgoCD UI
### To access ArgoCD UI from an AWS EC2 instance, use kubectl port-forward:
```
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:80
```
### Then, open your browser and visit:
```
http://<EC2-IP>:8080
```
## 3. Logging in to ArgoCD UI
### 3.1 Default Login Credentials
#### Username: admin
##### Password: Run the following command to retrieve the initial admin password:
```
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d; echo
```
## 4. Creating an Application in ArgoCD
### 4.1 Create New App
#### After logging in, go to the Applications page.
#### Click on + New App to create a new application
### 4.2 Fill Application Details
#### Application Name: my-app (or any name)
#### Project: default
#### Sync Policy: Automatic
#### Repository URL: Example: https://github.com/RanaSalem2412/jenkins-shared-library.git
#### Revision: main
#### Path: k8s-manifests (or the directory where manifests are located)
### 4.3 Select Cluster and Namespace
#### Cluster: https://kubernetes.default.svc.
#### Namespace: default 
### Click Create to create the application in ArgoCD.
## 5. Syncing and Verifying Deployment
### Once the application is created:
#### ArgoCD will start syncing resources from the Git repository.
#### You can see the sync status and deployment status in the UI.
#### A "Synced" status means everything is up-to-date and deployed.
## 6. Accessing the Deployed Application
```
kubectl port-forward pod/my-app-54f458cbd9-hxwmf 9090:8081 -n default --address 0.0.0.0
```
### you can access the application via:
```
http://<EC2-IP>:9090
```
