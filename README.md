Task-CI-CD Repository
This repository contains a Flask application with a CI/CD pipeline, Docker containerization, and Terraform infrastructure setup for deployment on AWS EKS. Below is a comprehensive guide to the project structure, setup, and deployment process.
Project Structure
The repository is organized as follows:
Task-CI-CD/
├── app/
│   ├── app.py              # Main Flask application code
│   ├── requirements.txt    # Python dependencies for the application
│   └── Dockerfile          # Dockerfile for containerizing the Flask app
├── terraform/
│   ├── main.tf             # Terraform configuration for VPC, EKS, and other resources
│   ├── backend.tf          # Remote backend configuration for Terraform state
│   ├── deployment.yaml     # Kubernetes deployment manifest for the Flask app
│   └── service.yaml        # Kubernetes service manifest for LoadBalancer
└── README.md               # Project documentation

Steps Performed in This Repository

Created the app Directory:

Contains all application-related files for better organization.


Developed the app.py File:

Implements the Flask application logic.


Added the requirements.txt File:

Lists Python dependencies:
Flask==2.3.3
pytz==2024.1




Built a Docker Image:

Created a Dockerfile to containerize the Flask application for consistent environments.


Terraform Infrastructure Setup:

Configured AWS resources (VPC, EKS cluster, etc.) using Terraform.
Set up a remote S3 backend for Terraform state management.


Deployed to EKS:

Deployed the Flask application to an EKS cluster using Kubernetes manifests.



How to Run the Application Locally
Prerequisites

Docker installed.

Steps to Run

Clone the Repository:
git clone https://github.com/mrmonarch20/Task-CI-CD.git
cd Task-CI-CD


Build the Docker Image:
docker build -t flask-app ./app


Run the Docker Container:
docker run -p 5000:5000 flask-app


Access the Application:

Open http://localhost:5000 in a web browser to see the Flask app response.


Optional: Pull Docker Image:

Pull the pre-built image from Docker Hub:
docker pull raja7977/app





Terraform Infrastructure Setup
This section explains how to set up and deploy the AWS infrastructure using Terraform for hosting the Flask application on an EKS cluster.
Prerequisites

AWS CLI installed and configured.
Terraform CLI installed.
An AWS account with permissions to create resources (VPC, EKS, S3, etc.).
kubectl installed for EKS deployment.

Step 1: Install and Verify Tools

Install AWS CLI:

Follow the AWS CLI installation guide.

Verify installation:
aws --version




Install Terraform:

Follow the Terraform installation guide.

Verify installation:
terraform -version





Step 2: Configure AWS CLI
Configure your AWS credentials:
aws configure

Provide:

AWS Access Key ID
AWS Secret Access Key
Default region (e.g., ap-south-1)
Default output format (e.g., json)

Step 3: Set Up the Remote Backend

Create an S3 Bucket:
aws s3api create-bucket --bucket <your-bucket-name> --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1

Replace <your-bucket-name> with a unique bucket name.

Enable Versioning:
aws s3api put-bucket-versioning --bucket <your-bucket-name> --versioning-configuration Status=Enabled


Configure Remote Backend: Update terraform/backend.tf:
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

Initialize Terraform:
terraform init

Step 5: Deploy the Infrastructure

Plan the Infrastructure:
terraform plan


Apply the Infrastructure:
terraform apply -auto-approve



Step 6: Verify the Infrastructure
Check the AWS Management Console for:

VPC: Created VPC, subnets, and NAT Gateway.
EKS Cluster: EKS cluster and worker nodes.

Step 7: Deploy the Application to EKS

Apply Kubernetes Manifests:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml


Get the LoadBalancer URL:
kubectl get svc

Example output:
NAME                  TYPE           CLUSTER-IP      EXTERNAL-IP                              PORT(S)        AGE
simpletime-service    LoadBalancer   10.100.200.200  a1b2c3d4e5f6g7h8-1234567890.ap-south-1.elb.amazonaws.com  80:30777/TCP   10m


Access the Application:

Copy the EXTERNAL-IP (LoadBalancer URL) and paste it into a web browser.

Expected JSON response:
{
  "timestamp": "2025-04-14T21:15:43.000000+05:30",
  "ip": "127.0.0.1"
}





Notes

Ensure your AWS credentials have sufficient permissions for creating and managing resources.
The Docker image is publicly available on Docker Hub for convenience.
For production, secure the S3 bucket and EKS cluster with appropriate IAM roles and policies.

