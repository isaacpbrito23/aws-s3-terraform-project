# Project 1: Automated Static Website Deployment on AWS S3

This project demonstrates the deployment of a simple static HTML website to an AWS S3 bucket. The entire infrastructure is provisioned and managed using Terraform, showcasing Infrastructure as Code (IaC) principles.

## Project Overview

The goal of this project was to gain hands-on experience with core cloud and DevOps tools. It involved two main phases:
1.  **Manual Deployment:** I first deployed the website manually through the AWS Management Console to understand the underlying services, including S3 bucket configuration, public access settings, and bucket policies.
2.  **Automated Deployment:** I then destroyed the manual setup and re-created the entire infrastructure using a Terraform script. This automates the process, making it repeatable, versionable, and less prone to human error.

---

### Technologies Used
Cloud Provider: Amazon Web Services (AWS)
Core AWS Services: S3 (Simple Storage Service)
Infrastructure as Code: Terraform
Language: HCL (HashiCorp Configuration Language)

---

### What I Learned
Infrastructure as Code (IaC): I learned how to define and manage cloud resources declaratively using Terraform. This project taught me the value of IaC for creating consistent and reproducible environments.
AWS Fundamentals: I gained practical experience with S3, including bucket creation, static website hosting, and the critical importance of IAM policies and permissions for public access.
he Full Development Lifecycle: By building, destroying, and rebuilding the infrastructure, I experienced the full lifecycle of a cloud resource, reinforcing the power and efficiency of automation.
