# 🔐 Login App Frontend

A clean and lightweight frontend login application built using **HTML**, **CSS**, and **JavaScript**.  
This repository also includes step-by-step instructions to deploy the application on an **Azure Virtual Machine** using **Docker** or **Nginx**.

---

## 📂 Tech Stack

- **HTML5** – Application structure  
- **CSS3** – Styling and layout  
- **JavaScript** – Client-side logic  
- **Nginx** – Web server  
- **Docker** – Containerization  

---

## 🚀 Deployment Guide

You can deploy this application on an **Azure Ubuntu VM** using either **Docker (recommended)** or **manual Nginx setup**.

---

## ✅ Prerequisites

- Azure Virtual Machine (Ubuntu 20.04 / 22.04 / 24.04)
- Port **80** **22** **30000-32767** allowed in Azure **Network Security Group (NSG)**
- SSH access to the VM

---

## 📥 Get the Source Code

Connect to your VM and clone the repository:

```bash
sudo apt update && sudo apt install git -y
git clone https://github.com/vikasveldi/login-app.git
cd login-app
````

---

## 🐳 Option A: Docker Deployment (Recommended)

This method runs the application inside a container.

### 1️⃣ Create a Dockerfile (if not present)

```bash
echo -e "FROM nginx:alpine\nCOPY . /usr/share/nginx/html\nEXPOSE 80" > Dockerfile
```

### 2️⃣ Install Docker

```bash
sudo apt install docker.io -y
```

### 3️⃣ Stop Existing Nginx (if running)

```bash
sudo systemctl stop nginx
```

### 4️⃣ Build the Docker Image

```bash
sudo docker build -t login-app .
```

### 5️⃣ Run the Container

```bash
sudo docker run -d -p 80:80 --name my-login-app login-app
```

✅ **Application URL:**

```
http://<your-vm-public-ip>
```

---

## 🛠️ Option B: Manual Nginx Deployment

This method installs and configures Nginx directly on the VM.

### 1️⃣ Install Nginx

```bash
sudo apt install nginx -y
```

### 2️⃣ Remove Default Web Files

```bash
sudo rm -rf /var/www/html/*
```

### 3️⃣ Copy Application Files

```bash
sudo cp -r ./* /var/www/html/
```

### 4️⃣ Restart Nginx

```bash
sudo systemctl restart nginx
```

✅ **Application URL:**

```
http://<your-vm-public-ip>
```

---

## 📌 Notes

* Ensure port **80** is open in your Azure NSG
* Docker deployment is recommended for better isolation and scalability
* This project is frontend-only and does not include backend authentication


# 🚀 Login App CI/CD Pipeline using Jenkins & Docker

This repository demonstrates a **Jenkins Declarative Pipeline** used to **build, push, and deploy a Login Application** using **Docker**.

The pipeline automates the complete CI/CD workflow:

* Source code checkout from GitHub
* Docker image build
* Secure login to Docker Hub
* Push image to Docker Hub
* Deploy application as a Docker container

---

## 🧰 Technologies Used

* **Jenkins** – CI/CD automation
* **Docker** – Containerization
* **Docker Hub** – Image registry
* **GitHub** – Source code management
* **Linux (Ubuntu)** – Jenkins/Docker host

---

## 📁 Repository Structure

```text
login-app/
├── Dockerfile
├── index.html / application files
├── Jenkinsfile
└── README.md
```

---

## 🔄 Jenkins Pipeline Overview

```groovy
pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/vikasveldi/login-app.git'
      }
    }

    stage('Build') {
      steps {
        sh 'docker build -t vikasveldi/login-app:v1 .'
      }
    }

    stage('Login to DockerHub') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'docker-credentials',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
        }
      }
    }

    stage('Push') {
      steps {
        sh 'docker push vikasveldi/login-app:v1'
      }
    }

    stage('Deploy') {
      steps {
        sh 'docker run -dt --name login-con -p 80:80 vikasveldi/login-app:v1'
      }
    }
  }
}
```

---

## 📌 Pipeline Stages Explained

### 1️⃣ Checkout

* Clones the source code from the **main branch** of the GitHub repository.

### 2️⃣ Build

* Builds a Docker image using the `Dockerfile`.
* Tags the image as:

  ```
  vikasveldi/login-app:v1
  ```

### 3️⃣ Login to Docker Hub

* Uses **Jenkins Credentials** to securely authenticate with Docker Hub.
* Prevents hardcoding of sensitive credentials.
* Uses `--password-stdin` for enhanced security.

### 4️⃣ Push

* Pushes the Docker image to **Docker Hub**.
* Makes the image available for deployment anywhere.

### 5️⃣ Deploy

* Runs the Docker container using the pushed image.
* Maps container port **80** to host port **80**.
* Application becomes accessible via browser.

---

## 🔐 Jenkins Credentials Configuration

Before running the pipeline, configure Docker Hub credentials:

1. Jenkins → **Manage Jenkins**
2. **Credentials** → (Global)
3. Add **Username with Password**

   * **ID:** `docker-credentials`
   * **Username:** Docker Hub username
   * **Password:** Docker Hub access token

---

## ⚙️ Prerequisites

Ensure the Jenkins server has:

* Docker installed
* Jenkins user added to Docker group:

  ```bash
  sudo usermod -aG docker jenkins
  sudo systemctl restart jenkins
  ```

---

## 🌐 Application Access

After successful deployment:

```
http://<jenkins-server-ip>:80
```

---

## 📄 License

This project is open-source and available under the **MIT License**.

