resource "google_compute_project_metadata" "ssh_key" {
  metadata = {
    ssh-keys = "ssh-keys:${file(var.ssh_key)}"
  }
}
