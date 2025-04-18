# Task  Repository

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

4. **Verify the Application**:
   - Open a browser and navigate to `http://localhost:5000/` to confirm the Flask application is running.
   - You can also check a specific endpoint like `/health` for a health check.

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
```hcl name=backend.tf
terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "terraform/state"
    region         = "ap-south-1"
    encrypt        = true

    # Option to use lock_file instead of DynamoDB for state locking
    lock_file = true
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
aws eks --region ap-south-1 update-kubeconfig --name my-eks-cluster
kubectl get nodes
```

---
## Accessing the EKS Cluster from Outside the VPC

If you are accessing the EKS cluster from outside the VPC, follow these steps:

### Check EKS Endpoint Configuration:
```bash
aws eks describe-cluster --region ap-south-1 --name <cluster_name> --query "cluster.resourcesVpcConfig"
```
-Replace <cluster_name> with your EKS cluster name.
-Ensure endpointPublicAccess is set to true and endpointPrivateAccess is set to false.

Update EKS Endpoint to Public:
```bash
aws eks update-cluster-config --region ap-south-1 --name <cluster-name> --resources-vpc-config endpointPublicAccess=true
```
Find the Security Group Attached to the EKS Cluster:
```bash
aws eks describe-cluster --region ap-south-1 --name <cluster_name> --query "cluster.resourcesVpcConfig.clusterSecurityGroupId"
```
Allow Inbound Traffic on Port 443:
```bash
aws ec2 authorize-security-group-ingress --group-id <security-group-id> --protocol tcp --port 443 --cidr 0.0.0.0/0
```
Verify the Security Group Rules:
```bash
aws ec2 describe-security-groups --group-ids <security-group-id> --query "SecurityGroups[0].IpPermissions"
```
Test the EKS Cluster:
```bash
kubectl get nodes
```
---
## Step 7: Deploy the Application into the EKS Cluster

Apply the deployment and service YAML files:

1. Apply the Deployment configuration:
   ```bash
   kubectl apply -f deployment.yaml
   ```

2. Apply the Service configuration to expose the application:
   ```bash
   kubectl apply -f service.yaml
   ```

3. Fetch the LoadBalancer URL using:
   ```bash
   kubectl get svc
   ```

Example output:
```plaintext
NAME                  TYPE           CLUSTER-IP      EXTERNAL-IP                                         PORT(S)        AGE
simpletime-service    LoadBalancer   10.100.200.200  a1b2c3d4e5f6g7h8-1234567890.ap-south-1.elb.amazonaws.com  5000:31301/TCP   10m
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

## Contact

For questions or feedback, contact [mrmonarch20](https://github.com/mrmonarch20).
