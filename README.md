## Pet Clinic Application

## Tools used
  1 Terraform
  2 Github
  3 Jenkins
  4 AWS 
  5 Java

## Terraform Infrastructure Documentation: Infrastructure Setup for Dockerized Pet Clinic Application
-- This documentation guides you through setting up the infrastructure using Terraform to deploy a Dockerized Pet Clinic application on AWS. The infrastructure includes an Auto Scaling Group (ASG) to manage EC2 instances, a security group to control inbound and outbound traffic, and associated configurations.
# Link to the terraform infrastructure - 

[https://github.com/OkiriGabriel/Petclinic-terraform-infrastructure.git]
# Prerequisites
- AWS account credentials with appropriate permissions.
- Terraform installed on your local machine.

- Step 1: Organize Terraform Files
- Organize your Terraform configuration files into a structured format:

```
terraform/
    ├── main.tf
    ├── asg.tf
    ├── sg.tf
    └── variables.tf
```
```
main.tf: Main configuration file.
asg.tf: Auto Scaling Group configuration.
sg.tf: Security group configuration.
variables.tf: Variables used in the configuration.
```

- Step 2: Define Auto Scaling Group (ASG)
- Define the Auto Scaling Group (ASG) resource in asg.tf. This resource manages the scaling of EC2 instances based on defined conditions such as minimum and maximum instances:

```
resource "aws_autoscaling_group" "petclinic_asg" {
  # Define ASG configurations here
}
```

# Step 3: Define Launch Configuration
- Define the launch configuration for the ASG in asg.tf. This configuration includes specifications such as AMI, instance type, and security groups:

```
resource "aws_launch_configuration" "petclinic_lc" {
  # Define launch configuration here
}
```
- Step 4: Define Security Group
- Define the security group in sg.tf. This resource controls inbound and outbound traffic to the EC2 instances:
```
resource "aws_security_group" "petclinic_sg" {
  # Define security group configurations here
}
```

- Step 5: Define Variables
- Define the variables used in your Terraform configuration in variables.tf. These variables provide flexibility and reusability:

```
variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
}
```
- Define other variables as needed

- Step 6: Terraform Initialization
- Initialize Terraform in your project directory:

```
terraform init
``` 
- Step 7: Terraform Plan
- Generate and review an execution plan to ensure that Terraform will create the desired infrastructure:

```
terraform plan
```
- Step 8: Terraform Apply
- Apply the Terraform configuration to create the infrastructure:

```
terraform apply
```
- Step 9: Deploy Dockerized Pet Clinic Application
- Deploy your Dockerized Pet Clinic application on the EC2 instances provisioned by the ASG.



### **Phase 1: Initial Setup and Deployment**

**Step 1: Launch EC2 (Ubuntu 22.04):**

- Provision an EC2 instance on AWS with Ubuntu 22.04.
- Connect to the instance using SSH.

**Step 2: Clone the Code:**

- Update all the packages and then clone the code.
- Clone your application's code repository onto the EC2 instance:
    
    ```bash
    git clone https://github.com/N4si/DevSecOps-Project.git
    ```
    
## Phase 2: CI/CD Setup**

1. **Install Jenkins for Automation:**
    - Install Jenkins on the EC2 instance to automate deployment:
    Install Java
    
    ```bash
    sudo apt update
    sudo apt install fontconfig openjdk-17-jre
    java -version
    openjdk version "17.0.8" 2023-07-18
    OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
    OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)
    
    #jenkins
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    ```
    
    - Access Jenkins in a web browser using the public IP of your EC2 instance.
        
        publicIp:8080
        
2. **Install Necessary Plugins in Jenkins:**

Goto Manage Jenkins →Plugins → Available Plugins →

Install below plugins

1 Eclipse Temurin Installer (Install without restart)

2 SonarQube Scanner (Install without restart)

3 Docker Plugin (Install Without restart)

4 Email Extension Plugin

5 Maven

### **Configure Java and Nodejs in Global Tool Configuration**

Goto Manage Jenkins → Tools → Install JDK(17) -  Click on Apply and Save


**Step 3: Install Docker and Run the App Using a Container:**

- Set up Docker on the EC2 instance:
    
    ```bash
    
    sudo apt-get update
    sudo apt-get install docker.io -y
    sudo usermod -aG docker $USER  # Replace with your system's username, e.g., 'ubuntu'
    newgrp docker
    sudo chmod 777 /var/run/docker.sock
    ```
    
Create a Jenkins webhook

1. **Configure CI/CD Pipeline in Jenkins:**

```
pipeline {
    agent any

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/OkiriGabriel/application-assessment-repo-solution.git'
            }
        }

        stage('Build and Package') {
            steps {
                sh 'chmod +x mvnw' // Grant execute permission to mvnw script
                sh './mvnw clean package'
            }
        }

        stage('Deploy to Container') {
            environment {
                DOCKER_IMAGE = 'petclinic-app'
                CONTAINER_NAME = 'petclinic-app-container'
            }
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"
                    sh "docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                }
            }
        }
    }
}

```
    

## Containerising Pet Clinic app using Docker

This is a [dockerized version of the original app](https://github.com/CloudHight/application-assessment-repo.git) published by Cloudhight


## Running PetClinic app locally

Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using Maven. It is an application designed to show how the Spring stack can be used to build simple, but powerful database-oriented applications. The official version of PetClinic demonstrates the use of Spring Boot with Spring MVC and Spring Data JPA.

## How it works?

Spring boot works with MVC (Model-View-Controller) is a pattern in software design commonly used to implement user interfaces, data and control logic. It emphasizes a separation between business logic and its visualization. This "separation of concerns" provides a better division of labor and improved maintenance.We can work with the persistence or data access layer with [spring-data](https://spring.io/projects/spring-data) in a simple and very fast way, without the need to create so many classes manually. Spring data comes with built-in methods below or by default that allow you to save, delete, update and/or create.


## Getting Started
## Forked the repository from  https://github.com/dockersamples/spring-petclinic.git and then it to my local

```

git clone https://github.com/dockersamples/spring-petclinic.git
cd application-assessment-repo
./mvnw package
java -jar target/*.war
```

You can then access petclinic here: http://localhost:8080/

<img width="625" alt="image" src="https://user-images.githubusercontent.com/313480/179161406-54a28200-d52e-411f-bfbe-463cf64b64b3.png">

The applications allows you to perform the following set of functions:

- Add Pets
- Add Owners
- Finding Owners
- Finding Veterinarians
- Exceptional handling


## Building a Container

```
 docker build -t petclinic-app . -f Dockerfile
```

## References

- [Building PetClinic app using Dockerfile](https://docs.docker.com/language/java/build-images/)