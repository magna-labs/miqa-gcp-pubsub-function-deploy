output "topic_name" {
  value = google_pubsub_topic.miqa_topic.name
}

output "function_name" {
  value = google_cloudfunctions2_function.miqa_function.name
}