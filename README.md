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


