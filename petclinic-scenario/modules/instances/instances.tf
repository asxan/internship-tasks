resource "google_compute_instance" "instance" {
  count = length(var.instance_names)
  name = element(var.instance_names, count.index)
  hostname = element(var.hostnames, count.index)
  machine_type = var.machine_type

  labels = {
    name = "${element(var.instance_names, count.index)}-instance"
    owner = var.owner
  }

  boot_disk {
    device_name = "boot-${var.owner}-${tostring(element(var.instance_names, count.index))}-disk"
    initialize_params {
      type = var.boot_disk_type
      size = var.boot_disk_size
      image = (var.machine_image != "" ? var.machine_image : data.google_compute_image.centos_image.name)
    }
  }

  zone = var.availability_zone

  tags = element(var.network_tags, count.index)

  network_interface {
    network = var.vpc_name
    subnetwork = var.subnet
    network_ip = element(var.internal_ip, count.index)
    access_config {
      nat_ip = element(var.external_ip, count.index)
    }
  }

  metadata = {
    ssh-keys = file(var.path_to_ssh_key_file)
  }

}