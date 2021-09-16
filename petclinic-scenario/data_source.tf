data "google_compute_image" "centos_image" {
  family = var.image_family
  project = var.image_project
}

data "google_compute_zones" "available" {}