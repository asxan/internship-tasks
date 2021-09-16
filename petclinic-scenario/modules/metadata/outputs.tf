output "ssh_id" {
  value = google_compute_project_metadata.ssh_key.id
}

output "ssh_name" {
  value = google_compute_project_metadata.ssh_key.metadata
}