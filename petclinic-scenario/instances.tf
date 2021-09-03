locals {
  image_name = "${var.IMAGE_PROJECT}/${var.IMAGE_TYPE}"
}

resource "google_compute_instance" "jenkins_nginx_instance" {
  name = var.INSTANCE_NAME1
  hostname = var.HOSTNAME1
  machine_type = var.MACHINE_TYPE
  labels = {
    name = var.INSTANCE_NAME1
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
  }


  boot_disk {
    device_name = var.BOOT_DISK_NAME
    initialize_params {
      type = var.BOOT_DISK_TYPE
      size = var.BOOT_DISK_SIZE
      image = local.image_name
    }
  }

  zone = var.AVAILABILITY_ZONE_A


  tags = [
    google_compute_firewall.firewall_rule_ssh_http.name,
    google_compute_firewall.firewall_rule_jenkins.name,
    google_compute_firewall.firewall_rule_docker.name,
    google_compute_firewall.firewall_rule_smtp.name
  ]


  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public-subnet.name
    network_ip = google_compute_address.first_internal_ip.address
    access_config {
      #var.RESERVE_INTERNAL_IP_NAME1
      nat_ip = google_compute_address.first_external_ip.address
    }
  }

  metadata = {
    ssh-keys = file(var.SSH_KEY)
  }

  depends_on = [
  google_compute_project_metadata.pet_ssh_key,
  ]
}


resource "google_compute_instance" "nexus_instance" {
  name = var.INSTANCE_NAME2
  hostname = var.HOSTNAME2
  machine_type = var.MACHINE_TYPE
  labels = {
    name = var.INSTANCE_NAME2
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
  }
  boot_disk {
    device_name = var.BOOT_DISK_NAME
    initialize_params {
      type = var.BOOT_DISK_TYPE
      size = var.BOOT_DISK_SIZE
      image = local.image_name
    }
  }

  zone = var.AVAILABILITY_ZONE_A
  tags = [
    google_compute_firewall.firewall_rule_ssh_http.name,
    google_compute_firewall.firewall_rule_nexus.name,
    google_compute_firewall.firewall_rule_docker.name
  ]


  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public-subnet.name
    network_ip = google_compute_address.second_internal_ip.address
    access_config {
      nat_ip = google_compute_address.second_external_ip.address
    }
  }

  metadata = {
    ssh-keys = file(var.SSH_KEY)
  }

  depends_on = [
  google_compute_project_metadata.pet_ssh_key,
  ]
}


resource "google_compute_instance" "slave_instance" {

  name = var.INSTANCE_NAME3
  hostname = var.HOSTNAME3
  machine_type = var.MACHINE_TYPE

  labels = {
    name = var.INSTANCE_NAME3
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
  }


  boot_disk {
    device_name = var.BOOT_DISK_NAME
    initialize_params {
      type = var.BOOT_DISK_TYPE
      size = var.BOOT_DISK_SIZE
      image = local.image_name
    }
  }


  zone = var.AVAILABILITY_ZONE_A
  tags = [
    google_compute_firewall.firewall_rule_ssh_http.name,
    google_compute_firewall.firewall_rule_nexus.name,
    google_compute_firewall.firewall_rule_docker.name,
    google_compute_firewall.firewall_rule_smtp.name,
    google_compute_firewall.firewall_rule_jenkins.name
  ]


  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public-subnet.name
    network_ip = google_compute_address.third_internal_ip.address
    access_config {
      nat_ip = google_compute_address.third_external_ip.address
    }
  }

  metadata = {
    ssh-keys = file(var.SSH_KEY)
  }

  depends_on = [
  google_compute_project_metadata.pet_ssh_key,
  ]
}


resource "google_compute_instance" "prod_instance" {
  name = var.INSTANCE_NAME4
  hostname = var.HOSTNAME4
  machine_type = var.MACHINE_TYPE


  labels = {
    name = var.INSTANCE_NAME4
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
  }


  boot_disk {
    device_name = var.BOOT_DISK_NAME
    initialize_params {
      type = var.BOOT_DISK_TYPE
      size = var.BOOT_DISK_SIZE
      image = local.image_name
    }
  }


  zone = var.AVAILABILITY_ZONE_A
  tags = [
    google_compute_firewall.firewall_rule_ssh_http.name
  ]

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public-subnet.name
    network_ip = google_compute_address.fourth_internal_ip.address
    access_config {
      nat_ip = google_compute_address.fourth_external_ip.address
    }
  }

  metadata = {
    ssh-keys = file(var.SSH_KEY)
  }

  depends_on = [
  google_compute_project_metadata.pet_ssh_key,
  ]
}
