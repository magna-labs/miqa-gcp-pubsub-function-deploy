provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_pubsub_topic" "miqa_topic" {
  name = var.topic_name
}

resource "google_pubsub_topic_iam_member" "pubsub_publisher" {
  topic  = google_pubsub_topic.miqa_topic.name
  role   = "roles/pubsub.publisher"
  member = "serviceAccount:${var.publisher_sa_email}"
}

resource "google_cloudfunctions2_function" "miqa_function" {
  name     = "miqa-function"
  location = var.region
  description = "Triggered by Pub/Sub messages"
  
  build_config {
    runtime     = "python311"
    entry_point = "hello_pubsub"
    source {
      storage_source {
        bucket = var.function_bucket
        object = var.function_zip
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }

  event_trigger {
    event_type   = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic = google_pubsub_topic.miqa_topic.id
    retry_policy = "RETRY_POLICY_RETRY"
  }
}