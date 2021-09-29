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
  "jenkins-pet-packer-image", "nexus-pet-packer-image", "slave-pet-packer-image", "production-pet-packer-image"
  ]
}

variable "ssh_user" {
  type = string
  description = "SSH user"
  default = "vklymov"
}

source "googlecompute" "jenkins" {
  project_id = "${var.project_id}"
  source_image = "${var.source_image}"
  source_image_family = "${var.image_family}"
  ssh_username = "${var.ssh_user}"
  zone = "${var.availability_zone}"
  image_name = "${var.images[0]}-${var.image_family}"
  image_description = "VM image provisioned with ansible, and containing docker containers of jenkins and nginx"

}

source "googlecompute" "nexus" {
  project_id = "${var.project_id}"
  source_image = "${var.source_image}"
  source_image_family = "${var.image_family}"
  ssh_username = "${var.ssh_user}"
  zone = "${var.availability_zone}"
  image_name = "${var.images[1]}-${var.image_family}"
  image_description = "VM image provisioned with ansible, and containing docker containers of nexus and nginx"
}

source "googlecompute" "slave" {
  project_id = "${var.project_id}"
  source_image = "${var.source_image}"
  source_image_family = "${var.image_family}"
  ssh_username = "${var.ssh_user}"
  zone = "${var.availability_zone}"
  image_name = "${var.images[2]}-${var.image_family}"
  image_description = "VM image provisioned with ansible, for installing docker and configuring docker tcp socket"
}

source "googlecompute" "production" {
  project_id = "${var.project_id}"
  source_image = "${var.source_image}"
  source_image_family = "${var.image_family}"
  ssh_username = "${var.ssh_user}"
  zone = "${var.availability_zone}"
  image_name = "${var.images[3]}-${var.image_family}"
  image_description = "VM image provisioned with ansible, and containing docker containers of petclinic, phpmyadmin, mysql and nginx"
}

build {
  sources = ["sources.googlecompute.jenkins"]

  provisioner "shell" {
    script = "scripts/ansible_install.sh"
  }

  provisioner "file" {
    source = "../playbooks/password.txt"
    destination = "/tmp/password.txt"
  }

  provisioner "ansible-local" {
    playbook_file = "../playbooks/site.yml"
    group_vars    = "../playbooks/group_vars"
    extra_arguments = ["--vault-password-file=/tmp/password.txt", "--tags='soft,jenkins_nginx'"]
    role_paths = [
      "../playbooks/roles/deploy", 
      "../playbooks/roles/docker_install",
      "../playbooks/roles/jenkins_nginx", 
      "../playbooks/roles/nexus", 
      "../playbooks/roles/packages", 
      "../playbooks/roles/slave"
      ]
  }

  post-processors {
    post-processor "checksum"{
      checksum_types = ["sha1", "sha256"]
      output = "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
    }
  }
}

# Nexus image

build {
  name = "nexus-image"
  sources = ["sources.googlecompute.nexus"]

  provisioner "shell" {
    script = "scripts/ansible_install.sh"
  }

  provisioner "file" {
    source = "../playbooks/password.txt"
    destination = "/tmp/password.txt"
  }

  provisioner "ansible-local" {
    playbook_file = "../playbooks/site.yml"
    group_vars    = "../playbooks/group_vars"
    extra_arguments = ["--vault-password-file=/tmp/password.txt", "--tags=' soft,nexus'"]
    role_paths = [
      "../playbooks/roles/deploy", 
      "../playbooks/roles/docker_install",
      "../playbooks/roles/jenkins_nginx", 
      "../playbooks/roles/nexus", 
      "../playbooks/roles/packages", 
      "../playbooks/roles/slave"
      ]
  }

  post-processors {
    post-processor "checksum"{
      checksum_types = ["sha1", "sha256"]
      output = "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
    }
  }
}


# Slave image

build {
  name = "slave-image"
  sources = ["sources.googlecompute.slave"]

  provisioner "shell" {
    script = "scripts/ansible_install.sh"
  }

  provisioner "file" {
    source = "../playbooks/password.txt"
    destination = "/tmp/password.txt"
  }

  provisioner "ansible-local" {
    playbook_file = "../playbooks/site.yml"
    group_vars    = "../playbooks/group_vars"
    extra_arguments = ["--vault-password-file=/tmp/password.txt", "--tags=' soft,slave'"]
    role_paths = [
      "../playbooks/roles/deploy", 
      "../playbooks/roles/docker_install",
      "../playbooks/roles/jenkins_nginx", 
      "../playbooks/roles/nexus", 
      "../playbooks/roles/packages", 
      "../playbooks/roles/slave"
      ]
  }

  post-processors {
    post-processor "checksum"{
      checksum_types = ["sha1", "sha256"]
      output = "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
    }
  }
}

# Production image

build {
  name = "prod-image"
  sources = ["sources.googlecompute.production"]

provisioner "shell" {
    script = "scripts/ansible_install.sh"
  }

  provisioner "file" {
    source = "../playbooks/password.txt"
    destination = "/tmp/password.txt"
  }

  provisioner "ansible-local" {
    playbook_file = "../playbooks/site.yml"
    group_vars    = "../playbooks/group_vars"
    extra_arguments = ["--vault-password-file=/tmp/password.txt", "--tags=' soft,deploy'"]
    role_paths = [
      "../playbooks/roles/deploy", 
      "../playbooks/roles/docker_install",
      "../playbooks/roles/jenkins_nginx", 
      "../playbooks/roles/nexus", 
      "../playbooks/roles/packages", 
      "../playbooks/roles/slave"
      ]
  }

  post-processors {
    post-processor "checksum"{
      checksum_types = ["sha1", "sha256"]
      output = "packer_{{.BuildName}}_{{.ChecksumType}}.checksum"
    }
  }
}
