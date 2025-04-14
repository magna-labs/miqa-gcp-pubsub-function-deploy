# Miqa Pub/Sub Function Deployment (Terraform)

This Terraform setup:
- Creates a Pub/Sub topic
- Grants a service account Pub/Sub publish rights
- Deploys a Cloud Function triggered by that topic

## Prerequisites

- GCP Project with billing enabled
- Terraform installed (`brew install terraform`)
- gsutil installed and authenticated

## Steps

1. **Upload your function to GCS**
```bash
zip gcp-demo-function-source.zip main.py
gsutil cp gcp-demo-function-source.zip gs://miqa-resources/runners/
```

2. **Deploy via Terraform**
```bash
terraform init
terraform apply \
  -var="project_id=YOUR_PROJECT_ID" \
  -var="region=us-central1" \
  -var="topic_name=miqa-topic" \
  -var="publisher_sa_email=your-sa@your-project.iam.gserviceaccount.com" \
  -var="function_bucket=miqa-resources" \
  -var="function_zip=runners/gcp-demo-function-source.zip"
```