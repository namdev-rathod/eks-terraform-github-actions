# 🚀 DevOps CI/CD Project With AWS EKS, Terraform and GitHub Actions


This project demonstrates a real-time, end-to-end deployment pipeline using **AWS EKS**, **Terraform**, **Kubernetes**, and **GitHub Actions**. The goal is to provision a fully functional Kubernetes environment on AWS and deploy a containerized application through CI/CD.

Using Terraform modules, Kubernetes manifests, ALB Ingress, and GitHub Actions for CI/CD. Deploys a sample NGINX application to an EKS cluster (v1.33) in a custom VPC with automated rollout verification.

---

### 🚀 Project Overview

This project demonstrates how to provision a **production-grade AWS EKS cluster** using:

* 🧱 **Terraform Modules**
* 🏗️ Custom **VPC**
* ☁️ **Amazon EKS** with managed node groups
* 📦 Remote **state management** in S3
* 🔄 Deployment with **GitHub Actions**

---

### 🛠️ Tech Stack

| Component     | Tool/Service             |
| ------------- | ------------------------ |
| Infra as Code | Terraform (Modular)      |
| Backend       | AWS S3 (Terraform state) |
| Compute       | Amazon EKS (v1.33)       |
| Networking    | Custom VPC + Subnets     |
| CI/CD         | GitHub Actions           |
| IAM/Auth      | AWS IAM Roles            |

---

### 🧱 Architecture

```
AWS Cloud
│
├── VPC (10.0.0.0/16)
│   ├── Private Subnet 1 (AZ-a)
│   └── Private Subnet 2 (AZ-b)
│
└── EKS Cluster (1.33)
    └── Managed Node Group (t4g.medium)
```

---

### 📂 Folder Structure

```
terraform/
├── environments/
│   └── dev/
│       ├── main.tf          # S3 backend, module references
│       ├── variables.tf     # Input variables
│       └── outputs.tf       # Outputs
└── modules/
    ├── vpc/                 # Custom VPC with subnets
    └── eks/                 # EKS cluster & node group config
```

---

### 📦 Pre-Requisites

* ✅ AWS CLI configured
* ✅ Terraform v1.5+ installed
* ✅ S3 bucket for state:

  ```bash
  aws s3api create-bucket \
    --bucket eks-devops-tf-backend \
    --region ap-south-1 \
    --create-bucket-configuration LocationConstraint=ap-south-1
  ```

---

### 🚀 Deployment Steps

```bash
cd terraform/environments/dev

# Initialize Terraform with S3 backend
terraform init

# Review the execution plan
terraform plan

# Apply the infrastructure
terraform apply
```

---

### ⚙️ GitHub Actions Workflow (CI/CD)

Here’s a minimal `eks-ci.yml` example for deployment from GitHub:

```yaml
name: 🚀 Deploy EKS Cluster

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.6.0

      - name: Terraform Init
        run: terraform -chdir=terraform/environments/dev init

      - name: Terraform Plan
        run: terraform -chdir=terraform/environments/dev plan

      - name: Terraform Apply
        run: terraform -chdir=terraform/environments/dev apply -auto-approve
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

> 🔐 Set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` in your GitHub repo **Secrets**.

---

### ✅ Outputs

* EKS Cluster Name
* VPC ID
* Private Subnet IDs

---

### 🙌 Contributing

Feel free to fork and enhance this repo. Ideal for:

* DevOps students
* Workshop trainers
* Cloud engineers practicing Terraform + EKS

---

### 📩 Connect with Me

👤 **Namdev Rathod**
📺 YouTube: [DevOps With Namdev](https://github.com/namdev-rathod)
🔗 GitHub: [namdev-rathod](https://github.com/namdev-rathod)

---