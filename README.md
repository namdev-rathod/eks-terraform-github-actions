# 🚀 DevOps CI/CD Project With AWS EKS, Terraform and GitHub Actions

This project demonstrates a real-time, end-to-end deployment pipeline using **AWS EKS**, **Terraform**, **Kubernetes**, and **GitHub Actions**. The goal is to provision a fully functional Kubernetes environment on AWS and deploy a containerized application through CI/CD.

**End-to-End AWS EKS DevOps Project** using Terraform modules, Kubernetes manifests, ALB Ingress, and GitHub Actions for CI/CD. Deploys a sample NGINX application to an EKS cluster (v1.33) in a custom VPC with automated rollout verification.

---

## 📌 Project Overview

- **Cloud Platform:** AWS
- **Orchestration:** Kubernetes on EKS (v1.33)
- **Infrastructure as Code:** Terraform (module-based)
- **CI/CD Tool:** GitHub Actions
- **Load Balancer:** AWS ALB Ingress Controller
- **App:** Sample NGINX Web App

---

## 🧱 EKS Cluster Configuration

| Property            | Value                              |
|---------------------|-------------------------------------|
| Cluster Name        | `EKS-DevOps-Cluster`               |
| Node Group Name     | `EKS-DevOps-Cluster-NodeGroup`     |
| Instance Type       | `t4g.medium`                       |
| Min / Max Nodes     | `1 / 2`                            |
| VPC CIDR            | `10.0.0.0/16`                      |
| Ingress Type        | Application Load Balancer (ALB)    |

---

## 📁 Project Structure

```

eks-devops-project/
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   │   └── main.tf
│   │   ├── eks/
│   │   │   └── main.tf
│   └── environments/
│       └── dev/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
├── .github/
│   └── workflows/
│       └── deploy.yaml
└── README.md

````

---

## ⚙️ Setup Guide

### 🧩 Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/eks-devops-project.git
cd eks-devops-project
````

---

### ☁️ Step 2: Provision AWS Infrastructure

```bash
cd terraform/environments/dev
terraform init
terraform apply -auto-approve
```

> This creates VPC, Subnets, EKS Cluster, and Node Group.

---

### 🌍 Step 3: Install AWS Load Balancer Controller (one-time)

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update

kubectl create namespace kube-system

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=EKS-DevOps-Cluster \
  --set serviceAccount.create=false \
  --set region=ap-south-1 \
  --set vpcId=<your-vpc-id> \
  --set serviceAccount.name=aws-load-balancer-controller
```

---

### 🔐 Step 4: Set GitHub Secrets

Go to GitHub → `Settings` → `Secrets and Variables` → `Actions` and add:

| Name                    | Description         |
| ----------------------- | ------------------- |
| `AWS_ACCESS_KEY_ID`     | Your AWS Access Key |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Key |

---

### 🚀 Step 5: Push Code to GitHub

```bash
git add .
git commit -m "Initial working EKS CI/CD project"
git push origin main
```

---

### 🤖 Step 6: GitHub Actions Deploys Automatically

* Deploys Kubernetes manifests
* Verifies rollout status
* Prints pod + ingress info

You can check logs in the **Actions tab** of your repository.

---

## 🔎 Useful kubectl Commands

```bash
kubectl get nodes
kubectl get pods
kubectl get svc
kubectl get ingress
kubectl rollout status deployment/demo-app
```

---

## 🎯 Result

* ✅ Infrastructure provisioned via Terraform
* ✅ EKS Cluster with auto-scaling node group
* ✅ Sample NGINX app deployed with K8s
* ✅ Public access via ALB Ingress
* ✅ CI/CD enabled via GitHub Actions

---

## 👨‍🏫 Workshop Tips

* Show real-time `terraform apply`
* Explain module-based folder structure
* Show `kubectl get ingress` with ALB DNS
* Access NGINX via browser from public ALB
* Show GitHub Action workflow live

---

## 📷 Screenshots (Optional)

> Include screenshots of:
>
> * Terraform apply output
> * GitHub Actions success
> * Ingress DNS in browser
> * kubectl output

---

## 🙌 Credits

Built by **Namdev Rathod** for DevOps training and workshops.
Feel free to fork and extend!

---

```

---

## ✅ Final Tip Before Workshop

- Make sure your **Ingress controller is deployed**.
- Validate EKS access with `aws eks update-kubeconfig`.
- Test `kubectl apply -f k8s/` locally once before demo.
- Keep an **ALB DNS name ready to open in browser**.

```
