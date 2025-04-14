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