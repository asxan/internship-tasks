packer {
 required_plugins {
  googlecompute = {
   version = "1.0.5"
   source = "github.com/hashicorp/googlecompute"
  }
 }
}

variable "project_id" {
  type = string
  description = "The project id for which will be created images"
  default = "gd-gcp-gd-internship-kha"
}

variable "availability_zone" {
  type = string
  description = "The availability zone"
  default = "us-central1-a"
}

variable "source_image" {
   type = string
   description = "The source image for building"
   default = "centos-7-v20210916"
}

variable "image_family" {
  type = string
  description = "Image family"
  default = "centos-7"
}

variable "bucket" {
  type = string
  description = "The gcs bucket path"
  default =  "packer-grid-internship"
}

variable "images" {
  type = list(string)
  description = "List of images names"
  default = [
  "jenkins", "nexus", "slave", "production"
  ]
}

variable "ssh_user" {
  type = string
  description = "SSH user"
  default = "packer"
}

source "googlecompute" "centos" {
  project_id = "${var.project_id}"
  source_image = "${var.source_image}"
  source_image_family = "${var.image_family}"
  ssh_username = "${var.ssh_user}"
  zone = "${var.availability_zone}"
}

build {
  name = "jenkins-image"
  sources = ["sources.googlecompute.centos"]

  provisioner "file"{
    source = "provision.sh"
    destination = "/tmp/provision.sh"
  }


  provisioner "shell" {
    only = ["googlecompute.centos"]
    inline = [
      "sudo chmod 777 /tmp/provision.sh",
      "/tmp/provision.sh"]
  }

  post-processors {

    post-processor "checksum"{
      checksum_types = ["sha1", "sha256"]
      output = "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
    }

    post-processor "compress" {
      output = "/tmp/${var.images[0]}-${var.image_family}.tar.gz"
    }

    post-processor "googlecompute-import" {
      project_id = "${var.project_id}"
      bucket = "${var.bucket}"
      image_name = "${var.images[0]}-${var.image_family}"
      image_description = "Centos jenkins image"
      image_family = "${var.image_family}"
    }
  }
}

//build {
//  name = "nexus-image"
//  sources = ["sources.googlecompute.centos"]
//}
//
//build {
//  name = "slave-image"
//  sources = ["sources.googlecompute.centos"]
//}
//
//build {
//  name = "prod-image"
//  sources = ["sources.googlecompute.centos"]
//}



