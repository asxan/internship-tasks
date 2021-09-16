output "image" {
  value = data.google_compute_image.centos_image.name
}

output "instance_names" {
  value = google_compute_instance.instance[*].name
}

output "instance_ids" {
  value = google_compute_instance.instance[*].id
}

output "instance_hostnames" {
  value = google_compute_instance.instance[*].hostname
}