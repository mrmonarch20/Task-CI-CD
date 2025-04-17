# Task Repository

This repository contains a simple Flask application setup, including the necessary files and instructions to run the application using Docker.

---

## Clone the Repository

```bash
git clone https://github.com/mrmonarch20/Task-CI-CD.git
```

---

## Project Structure

```
|---app
|   |--Dockerfile
|   |--app.py
|   |--requirements.txt
|
|---terraform
|   |--main.tf
|   |--outputs.tf
|   |--variables.tf
|   |--deployment.yaml
|   |--service.yaml
```

---

## Steps Performed in This Repository

1. **Created the `app` Directory**:
   - All application-related files are stored in the `app` directory for better organization.

2. **Added the `app.py` File**:
   - This file contains the main Flask application code.

3. **Created the `requirements.txt` File**:
   - This file lists the Python dependencies required for the application:
     ```plaintext
     Flask==2.3.3
     pytz==2024.1
     ```

4. **Built a Docker Image**:
   - A `Dockerfile` was created to containerize the Flask application. The Docker image ensures the application runs consistently across different environments.

---

## How to Run the Application

### Prerequisites
- Install [Docker](https://www.docker.com/).

### Steps to Run

1. **Build the Docker Image**:
   ```bash
   docker build -t flask-app .
   ```

2. **Run the Docker Image to Create a Container**:
   ```bash
   docker run -p 5000:5000 flask-app
   ```

3. **Pull the Docker Image**:
   ```bash
   docker pull raja7977/app
   ```
   > **Note**: The Docker image has been pushed to a public repository on Docker Hub.

---

## Terraform Infrastructure Setup

This guide explains how to set up the Terraform infrastructure for the project, including installing the required tools, configuring the AWS CLI, setting up a remote backend, and deploying the infrastructure.

### Prerequisites

1. **AWS CLI**: Ensure the AWS CLI is installed and configured.
2. **Terraform**: Install Terraform CLI.
3. **AWS Account**: You need an AWS account with sufficient permissions to create resources.

---

## Step 1: Install AWS CLI and Terraform

### Install AWS CLI
Follow the [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) for your operating system.

Verify the installation:
```bash
aws --version
```

### Install Terraform
Install Terraform and verify the installation:
```bash
terraform -version
```

---

## Step 2: Configure AWS CLI

Run the following command to configure the AWS CLI:
```bash
aws configure
```

Provide the following details:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., ap-south-1)
- Default output format (e.g., json)

---

## Step 3: Set Up the Remote Backend

### Create an S3 Bucket for Remote Backend
Run the following command to create an S3 bucket for storing the Terraform state file:
```bash
aws s3api create-bucket --bucket <your-bucket-name> --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
```
Replace `<your-bucket-name>` with a unique name for your bucket.

### Enable Versioning for the Bucket
```bash
aws s3api put-bucket-versioning --bucket <your-bucket-name> --versioning-configuration Status=Enabled
```

### Configure the Remote Backend
Update the `backend.tf` file to configure the remote backend:
```hcl
terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "terraform/state"
    region         = "ap-south-1"
    encrypt        = true
  }
}
```

---

## Step 4: Initialize Terraform

Navigate to the Terraform directory:
```bash
cd terraform
```

Initialize Terraform to download the required providers and configure the backend:
```bash
terraform init
```

---

## Step 5: Deploy the Infrastructure

### Plan the Infrastructure
Run the following command to see the changes Terraform will make:
```bash
terraform plan
```

### Apply the Infrastructure
Deploy the infrastructure:
```bash
terraform apply -auto-approve
```

---

## Step 6: Verify the Infrastructure

Once the infrastructure is deployed, verify the resources in the AWS Management Console:
- **VPC**: Check the created VPC, subnets, and NAT Gateway.
- **EKS Cluster**: Verify the EKS cluster and worker nodes.

### Accessing the Cluster
To access the cluster, use this command:
```bash
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
kubectl get nodes
```

---

## Step 7: Deploy the Application into the EKS Cluster

Apply the deployment and service YAML files:
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

After that, fetch the LoadBalancer URL using:
```bash
kubectl get svc
```

Example output:
```plaintext
NAME                  TYPE           CLUSTER-IP      EXTERNAL-IP                                         PORT(S)        AGE
simpletime-service    LoadBalancer   10.100.200.200  a1b2c3d4e5f6g7h8-1234567890.ap-south-1.elb.amazonaws.com  80:30777/TCP   10m
```

Paste the `EXTERNAL-IP` in the web browser to get the JSON response.

**Example JSON Response**:
```json
{
  "timestamp": "2025-04-14T21:15:43.000000+05:30",
  "ip": "127.0.0.1"
}
```

--- 
