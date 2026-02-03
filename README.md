# ☁️ aws-ec2-secure-boot
# 🛒 Automated SSH Key Injection for AWS EC2

## 🚀 Project Overview
This project demonstrates how to provision AWS EC2 instances securely without attaching standard AWS Key Pairs. Instead, it utilizes **User Data (Cloud-Init)** to inject a specific public key and configure strict SSH permissions during the boot process.

## ❓ The Problem
Standard AWS EC2 provisioning requires selecting a pre-generated Key Pair. In enterprise environments, managing these `.pem` files across teams creates security risks.
* **Challenge:** How to grant access to a specific "Jump Host" identity without sharing private keys?
* **Constraint:** The `root` user must be accessible for specific legacy automation tasks (Note: strictly controlled).

## 🛠️ The Solution
I created a Bash script used as EC2 User Data that:
1.  **Provisions** the `.ssh` directory structure.
2.  **Injects** a pre-defined Public Key (RSA 2048) into `authorized_keys`.
3.  **Hardens** file permissions (`chmod 700/600`) to satisfy SSH security checks.
4.  **Configures** `sshd_config` to allow key-based Root login while disabling password access.

## 📄 Architecture
[Client/Bastion] --(Private Key)--> [AWS Cloud] --(User Data Script)--> [New EC2 Instance]

## 💻 Tech Stack
* **Cloud:** AWS (EC2)
* **Scripting:** Bash
* **Security:** SSH (RSA), IAM, Security Groups

## 🔧 How to Run
1.  Generate your key pair locally:
    ```bash
    ssh-keygen -t rsa -b 2048 -f ./id_rsa
    ```
2.  Copy the script from `user-data.sh` and replace `<PASTE_KEY_HERE>` with your `id_rsa.pub`.
3.  Launch an EC2 instance and paste the script into the **Advanced Details > User Data** field.
