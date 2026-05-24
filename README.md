# Terraform GitHub Actions Teaching Repo

This repository is a classroom-friendly example for deploying a small AWS EC2 web server with Terraform, building a Docker image with GitHub Actions, and optionally deploying that image to an existing EKS cluster.

The examples are intentionally small so students can see the moving parts:

- `Terraform/` provisions a demo EC2 instance and security group.
- `Docker/` contains a tiny Apache-based web page image.
- `deployment.yml` is a Kubernetes Deployment manifest for the image.
- `.github/workflows/` contains CI/CD examples for Terraform, Docker, and EKS.

## Prerequisites

- AWS account access.
- Terraform 1.8 or newer for local runs.
- Docker for local image testing.
- GitHub repository secrets for workflow runs.

## Required GitHub Secrets

For the Terraform workflows:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `TF_STATE_BUCKET`
- `TF_STATE_LOCK_TABLE`

For Docker Hub publishing:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

For the EKS deployment workflow:

- `EKS_CLUSTER_NAME`

The workflows use `us-east-1` by default. Change `AWS_REGION` in the workflow `env` block if your class uses a different region.

## Terraform State Setup

The Terraform workflow expects an S3 backend and DynamoDB lock table. Create those once before running the deploy workflow.

Example backend values:

```text
Bucket: my-terraform-state-bucket
Key: tf-github-workflow/terraform.tfstate
Region: us-east-1
DynamoDB table: terraform-locks
```

For local practice without remote state, run:

```bash
cd Terraform
terraform init -backend=false
terraform fmt
terraform validate
terraform plan
```

For real deploys, use remote state:

```bash
cd Terraform
terraform init \
  -backend-config="bucket=$TF_STATE_BUCKET" \
  -backend-config="key=tf-github-workflow/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="dynamodb_table=$TF_STATE_LOCK_TABLE" \
  -backend-config="encrypt=true"
terraform apply
```

## GitHub Actions

| Workflow | Purpose | Trigger |
| --- | --- | --- |
| `terraform-deploy.yml` | Formats, validates, plans, and applies Terraform | Push/PR to `main`, manual run |
| `terraform-destroy.yml` | Destroys Terraform-managed resources | Manual run only |
| `docker-build-image.yml` | Builds and pushes Docker images for Git tags | Tag push |
| `simple-docker-build-image.yml` | Simple branch-based Docker image build/push | Push to `main` |
| `deploy-eks.yml` | Applies `deployment.yml` to an existing EKS cluster | After Docker workflow completes |

## Local Docker Test

```bash
cd Docker
docker build -t tf-github-workflow-demo .
docker run --rm -p 8080:80 tf-github-workflow-demo
```

Open `http://localhost:8080`.

## Teaching Flow

1. Review the Terraform files and explain providers, variables, data sources, resources, and outputs.
2. Run `terraform fmt`, `terraform validate`, and `terraform plan` locally.
3. Configure GitHub secrets and run the Terraform workflow.
4. Build the Docker image locally, then push a Git tag to trigger image publishing.
5. If an EKS cluster already exists, run the EKS deployment workflow.

## Cleanup

Destroy AWS resources when class is done:

```bash
cd Terraform
terraform destroy
```

Or run the `Terraform Destroy` workflow manually in GitHub Actions.
