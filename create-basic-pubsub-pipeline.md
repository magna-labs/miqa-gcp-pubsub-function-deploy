# Miqa GCP Pub/Sub Pipeline Setup Guide

This guide walks through how to deploy and connect a Pub/Sub-triggered Cloud Function to Miqa.

---

## ✅ Step-by-Step Instructions

### 1. Deploy the Cloud Function with Terraform

This Terraform setup:
- Creates a Pub/Sub topic
- Grants a service account Pub/Sub publish rights
- Deploys a Cloud Function triggered by that topic

## Prerequisites

- GCP Project with billing enabled
- Terraform installed (`brew install terraform`)
- gsutil installed and authenticated

Run the following in your terminal:
```bash
YOUR_PROJECT_ID=your-project
SA_EMAIL=your-sa@your-project.iam.gserviceaccount.com

git clone https://github.com/gwenn-magna/miqa-gcp-pubsub-function-deploy.git
cd miqa-gcp-pubsub-function-deploy

# Make sure your function zip is uploaded:
# zip gcp-demo-function-source.zip main.py
# gsutil cp gcp-demo-function-source.zip gs://miqa-resources/runners/

terraform init

terraform apply \
  -var="project_id=$YOUR_PROJECT_ID" \
  -var="region=us-central1" \
  -var="topic_name=miqa-topic" \
  -var="publisher_sa_email=$SA_EMAIL" \
  -var="function_bucket=miqa-resources" \
  -var="function_zip=runners/gcp-demo-function-source.zip"
```


---

### 2. Create a New Pipeline in Miqa
- Navigate to the pipeline menu (top right corner of Miqa UI)
- Click **More Pipelines** > **Add Pipeline**
- Select **GCP Pub/Sub** as the pipeline type

---

### 3. Configure the Pipeline
- Go to **Pipeline > Components**
- Click the component name to view its details
- In the **Summary** card, click the **Edit (pencil)** button
  - Set the `project_id` and `topic_name`
- Scroll to the **Versions** table
  - Click into the initially created version
  - Edit and set the same `project_id` and `topic_name`
  - Save

---

### 4. Run a Dataset
- Go to the **Datasets** page
- Click **Add Dataset**
- On the new dataset page, choose your component version from the dropdown
- This will kick off the test automatically
- You should see results within a few seconds (if using the demo function)

---
Let us know if you run into issues!

