resource "google_compute_instance" "instance" {
  count = length(var.instance_names)
  name = element(var.instance_names, count.index)
  hostname = element(var.hostnames, count.index)
  machine_type = var.machine_type

  labels = {
    name = "${element(var.instance_names, count.index)}-instance"
    owner = var.owner
    subnet = var.PUBLIC_SUBNET_NAME
  }


  boot_disk {
    device_name = "boot-${var.owner}-disk"
    initialize_params {
      type = var.boot_disk_type
      size = var.boot_disk_size
      image = data.google_compute_image.centos_image.name
    }
  }

  zone = var.availability_zone_a


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