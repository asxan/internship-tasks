locals
{
  image_name = "${var.IMAGE_PROJECT}/${var.IMAGE_TYPE}"
}

resource "google_compute_instance" "jenkins_nginx_instance" {
  name = var.INSTANCE_NAME1
  hostname = var.HOSTNAME1
  machine_type = var.MACHINE_TYPE
  labels = {
    name  = var.INSTANCE_NAME1
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
    hostname = var.HOSTNAME1
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
    var.FIREWALL_RULE_SSH_HTTP,
    var.FIREWALL_RULE_FOR_JENKINS,
    var.FIREWALL_RULE_FOR_DOCKER,
    var.FIREWALL_RULE_SMTP
  ]


  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_network.vpc_network.name
    network_ip = var.RESERVE_INTERNAL_IP_NAME1
    access_config {
      nat_ip = var.RESERVE_EXTERNAL_IP_NAME1
    }
  }
}



resource "google_compute_instance" "nexus_instance" {
  name = var.INSTANCE_NAME2
  hostname = var.HOSTNAME2
  machine_type = var.MACHINE_TYPE
  labels = {
    name = var.INSTANCE_NAME2
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
    hostname = var.HOSTNAME2
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
    var.FIREWALL_RULE_SSH_HTTP,
    var.FIREWALL_RULE_NEXUS,
    var.FIREWALL_RULE_FOR_DOCKER
  ]


  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_network.vpc_network.name
    network_ip = var.RESERVE_INTERNAL_IP_NAME2
    access_config {
      nat_ip = var.RESERVE_EXTERNAL_IP_NAME2
    }
  }
}




resource "google_compute_instance" "slave_instance" {

  name =  var.INSTANCE_NAME3
  hostname = var.HOSTNAME3
  machine_type = var.MACHINE_TYPE

  labels = {
    name = var.INSTANCE_NAME3
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
    hostname = var.HOSTNAME3
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
    var.FIREWALL_RULE_SSH_HTTP,
    var.FIREWALL_RULE_NEXUS,
    var.FIREWALL_RULE_FOR_DOCKER,
    var.FIREWALL_RULE_SMTP,
    var.FIREWALL_RULE_FOR_JENKINS
  ]


  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_network.vpc_network.name
    network_ip = var.RESERVE_INTERNAL_IP_NAME3
    access_config {
      nat_ip = var.RESERVE_EXTERNAL_IP_NAME3
    }
  }
}


resource "google_compute_instance" "prod_instance" {
  name = var.INSTANCE_NAME4
  hostname = var.HOSTNAME4
  machine_type = var.MACHINE_TYPE


  labels = {
    name = var.INSTANCE_NAME4
    owner = var.OWNER
    subnet = var.PUBLIC_SUBNET_NAME
    hostname = var.HOSTNAME4
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
    var.FIREWALL_RULE_SSH_HTTP
  ]

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_network.vpc_network.name
    network_ip = var.RESERVE_INTERNAL_IP_NAME4
    access_config {
      nat_ip = var.RESERVE_EXTERNAL_IP_NAME4
    }
  }
}