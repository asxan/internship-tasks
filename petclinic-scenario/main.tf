#-----------------------------------------------------
# Terraform petclinic
# Made by Vitalii Klymov
#-----------------------------------------------------

provider "google" {
  //credentials = file("/Users/vklymov/Codes/gcp-creds.json")
  project = var.project_id
  region = "us-central1"
  zone = "us-central1-a"
}
