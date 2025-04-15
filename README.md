# Task-CI-CD
# Task-CI-CD Repository

This repository contains a simple Flask application setup, including the necessary files and instructions to run the application using Docker.

## Project Structure

The repository is organized as follows:

## Steps Performed in This Repository

1. **Created the `app` Directory**:
   - All application-related files are stored in the `app` directory for better organization.

2. **Added the `app.py` File**:
   - This file contains the main Flask application code.

3. **Created the `requirements.txt` File**:
   - This file lists the Python dependencies required for the application:
     ```
     Flask==2.3.3
     pytz==2024.1
     ```

4. **Built a Docker Image**:
   - A `Dockerfile` was created to containerize the Flask application. The Docker image ensures the application runs consistently across different environments.

## How to Run the Application

### Prerequisites
- Install [Docker](https://www.docker.com/).

### Steps to Run
1. **Build the Docker Image**:
   Run the following command in the terminal:
   ```bash
   docker build -t flask-app .

2. **Run the Docker image to create container**:
   ```bash
   docker run -p 5000:5000 flask-app


   ###Terraform Infrastructure Setup###

This guide explains how to set up the Terraform infrastructure for the project, including installing the required tools, configuring the AWS CLI, setting up a remote backend, and deploying the infrastructure.

---

## Prerequisites

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


Install Terraform.  ---> Verify Installation

```bash
terraform -version

## Step 2: Configure AWS CLI

```bash
aws configure
AWS Access Key ID
AWS Secret Access Key
Default region (e.g., ap-south-1)
Default output format (e.g., json)

## Step 3: Set Up the Remote Backend

Create an S3 Bucket for Remote Backend
Run the following commands to create an S3 bucket for storing the Terraform state file:

```bash
aws s3api create-bucket --bucket <your-bucket-name> --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1

Replace <your-bucket-name> with a unique name for your bucket.

Enable versioning for the bucket:

```bash
aws s3api put-bucket-versioning --bucket <your-bucket-name> --versioning-configuration Status=Enabled


Configure the Remote Backend
Update the backend.tf file to configure the remote backend:

terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "terraform/state"
    region         = "ap-south-1"
    encrypt        = true
  }
}

 ## Step 4: Initialize Terraform
Navigate to the terraform directory:


```bash
cd terraform

Initialize Terraform to download the required providers and configure the backend:
```bash
terraform init

## Step 5: Deploy the Infrastructure
Plan the Infrastructure
Run the following command to see the changes Terraform will make:

```bash
terraform plan

Apply the Infrastructure
Deploy the infrastructure:

```bash
terraform apply -auto-approve

## Step 6: Verify the Infrastructure
Once the infrastructure is deployed, verify the resources in the AWS Management Console:

VPC: Check the created VPC, subnets, and NAT Gateway.
EKS Cluster: Verify the EKS cluster and worker nodes.

