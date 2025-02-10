[![ShipIt](assets/logo.gif)]()

**ShipIt** is a hands-on exploration of modern DevOps practices.
By focusing on containerized deployments, CI/CD pipelines, and infrastructure automation, **ShipIt** aims to help developers confidently ship high-quality code while learning and applying real-world workflows.
Whether you're a DevOps beginner or looking to hone your skills, **ShipIt** is here to inspire, teach, and help you ship it faster, safer, smarter. 🚀

## Key Features

- **Health Checks**: Simple `/health` endpoint to verify application readiness.
- **CI/CD Pipelines**: Automated workflows using GitHub Actions for linting, testing, and Docker builds.
- **Dockerized Builds**: Consistent, containerized deployments for seamless development and production parity.
- **Infrastructure as Code**: AWS infrastructure provisioned using Terraform, enabling repeatable and scalable setups.

## Tools & Technologies Used

**ShipIt** leverages a variety of modern tools and practices to simulate a real-world DevOps workflow:

- **[Go](https://go.dev/)**: The programming language powering the application, designed for simplicity and efficiency.
- **[Docker](https://www.docker.com/)**: Containerization for consistent application builds and deployments.
- **[Terraform](https://www.terraform.io/)**: Infrastructure as Code (IaC) tool for managing and provisioning infrastructure resources.
- **[GitHub Actions](https://github.com/features/actions)**: CI/CD workflows to automate linting, testing, building, and deploying.
- **[AWS EC2](https://aws.amazon.com/ec2/)**: Compute instances used for hosting and running the application.
- **[AWS ECR](https://aws.amazon.com/ecr/)**: A repository for storing and managing Docker images, ensuring efficient containerized application distribution.

## Getting Started

Follow these steps to set up and run the project:

### Clone the repository

```bash
git clone https://github.com/danielolaszy/ShipIt.git
cd ShipIt
```

### Install dependencies

Ensure you have Go installed, then run:

```bash
go mod tidy
```

### Build Docker image

Build a containerized version of the app:

```bash
docker build -t shipit .
```

### Run the Docker container

Launch the application:

```bash
docker run -p 8080:8080 shipit
```

### Test the Application

Access the /health endpoint in your browser or via curl:

```bash
curl http://localhost:8080/health
```

Expected response:

```json
{
  "status": "healthy"
}
```

