Task-CI-CD Repository
This repository contains a simple Flask application setup, including the necessary files and instructions to run the application using Docker and deploy infrastructure using Terraform.
Clone the Repository
git clone https://github.com/mrmonarch20/Task-CI-CD.git

Project Structure
The repository is organized as follows:
Task-CI-CD/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── terraform/
│   ├── backend.tf
│   ├── deployment.yaml
│   └── service.yaml
└── README.md

Steps Performed in This Repository

Created the app Directory:

All application-related files are stored in the app directory for better organization.


Added the app.py File:

This file contains the main Flask application code.


Created the requirements.txt File:

Lists the Python dependencies required for the application:Flask==2.3.3
pytz==2024.1




Built a Docker Image:

A Dockerfile was created to containerize the Flask application, ensuring consistent execution across environments.



How to Run the Application
Prerequisites

Install Docker.

Steps to Run

Build the Docker Image:
docker build -t flask-app .


Run the Docker Container:
docker run -p 5000:5000 flask-app


Pull the Docker Image (Optional):
docker pull raja7977/app


Note: The Docker image is available in a public Docker Hub repository.



Terraform Infrastructure Setup
This section explains how to set up the Terraform infrastructure for the project, including installing tools, configuring the AWS CLI, setting up a remote backend, and deploying the infrastructure.
Prerequisites

AWS CLI: Ensure the AWS CLI is installed and configured.
Terraform: Install the Terraform CLI.
AWS Account: An AWS account with sufficient permissions to create resources.

Step 1: Install AWS CLI and Terraform
Install AWS CLI
Follow the AWS CLI installation guide for your operating system.
Verify the installation:
aws --version

Install Terraform
Follow the Terraform installation guide.
Verify the installation:
terraform -version

Step 2: Configure AWS CLI
Configure the AWS CLI with your credentials:
aws configure

Provide the following:

AWS Access Key ID
AWS Secret Access Key
Default region (e.g., ap-south-1)
Default output format (e.g., json)

Step 3: Set Up the Remote Backend
Create an S3 Bucket for Remote Backend
Create an S3 bucket to store the Terraform state file:
aws s3api create-bucket --bucket <your-bucket-name> --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1

Replace <your-bucket-name> with a unique bucket name.
Enable versioning for the bucket:
aws s3api put-bucket-versioning --bucket <your-bucket-name> --versioning-configuration Status=Enabled

Configure the Remote Backend
Update the backend.tf file in the terraform directory to configure the remote backend:
terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "terraform/state"
    region         = "ap-south-1"
    encrypt        = true
  }
}

Step 4: Initialize Terraform
Navigate to the terraform directory:
cd terraform

Initialize Terraform to download providers and configure the backend:
terraform init

Step 5: Deploy the Infrastructure
Plan the Infrastructure
Preview the changes Terraform will make:
terraform plan

Apply the Infrastructure
Deploy the infrastructure:
terraform apply -auto-approve

Step 6: Verify the Infrastructure
After deployment, verify the resources in the AWS Management Console:

VPC: Check the created VPC, subnets, and NAT Gateway.
EKS Cluster: Verify the EKS cluster and worker nodes.

To access the cluster:
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
kubectl get nodes

Step 7: Deploy the Application to the EKS Cluster
Deploy the application using the provided Kubernetes manifests:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

Retrieve the LoadBalancer URL:
kubectl get svc

Example output:
NAME                  TYPE           CLUSTER-IP      EXTERNAL-IP                              PORT(S)        AGE
simpletime-service    LoadBalancer   10.100.200.200  a1b2c3d4e5f6g7h8-1234567890.ap-south-1.elb.amazonaws.com  80:30777/TCP   10m

Paste the EXTERNAL-IP (e.g., a1b2c3d4e5f6g7h8-1234567890.ap-south-1.elb.amazonaws.com) into a web browser to access the application. You should see a JSON response like:
{
  "timestamp": "2025-04-14T21:15:43.000000+05:30",
  "ip": "127.0.0.1"
}

