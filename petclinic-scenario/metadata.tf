resource "google_compute_project_metadata" "pet_ssh_key" {
  metadata = {
    ssh-keys = "ssh-keys:${file(var.SSH_KEY)}"
  }
}