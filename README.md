# ShipIt 🚀

**ShipIt** is a CI/CD-driven pet project focused on practicing DevOps methodologies.  
From structured logging to containerization, we're shipping code with confidence.

## Key Features:

- **Health Checks**: Validate system readiness.
- **CI/CD Pipelines**: Automated testing and deployments using GitHub Actions.
- **Dockerized Builds**: Lightweight, containerized application delivery.
- **Infrastructure as Code**: Provisioning AWS infrastructure with Terraform.

### Why "ShipIt"? 

Because every developer loves the feeling of confidently shipping great code! 🚀


## Installation

1. Clone the repository:

```zsh
git clone https://github.com/danielolaszy/ShipIt.git
```

2. Install dependencies:

```zsh
go mod tidy
```

3. Build Docker image:

```zsh
docker build -t shipit .
```

4. Run the Docker container:

```zsh
docker run -p 8080:8080 shipit
```

5. Visit `http://localhost:8080/health` to check the health status.

## Usage

The app exposes a simple `/health` endpoint.

Example request:

```zsh
curl http://localhost:8080/health
```

Example response:

```json
{
  "status": "healthy"
}
```

