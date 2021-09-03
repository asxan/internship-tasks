resource "google_compute_firewall" "firewall_rule_ssh_http" {
  name = var.FIREWALL_RULE_SSH_HTTP
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = var.FIREWALL_RULE_SSH_HTTP_PORTS
  }

  direction = "INGRESS"
  source_ranges = [var.ALL_RANGE]
  description = "Firewall rule ssh http https"
}

resource "google_compute_firewall" "firewall_rule_smtp" {
  name = var.FIREWALL_RULE_SMTP
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = var.FIREWALL_RULE_SMTP_PORTS
  }

  direction = "INGRESS"
  source_ranges = [var.ALL_RANGE]
  description = "Firewall rule smtp ports"

}


resource "google_compute_firewall" "firewall_rule_nexus" {
  name = var.FIREWALL_RULE_NEXUS
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = var.FIREWALL_RULE_NEXUS_PORTS
  }

  direction = "INGRESS"
  source_ranges = [var.PUBLIC_RANGE]
  description = "Firewall rule with nexus port"
}

resource "google_compute_firewall" "firewall_rule_jenkins" {
  name = var.FIREWALL_RULE_FOR_JENKINS
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = var.FIREWALL_RULE_FOR_JENKINS_PORTS
  }

  direction = "INGRESS"
  source_ranges = [var.PUBLIC_RANGE]
  description = "Firewall rule for jenkins ports"
}

resource "google_compute_firewall" "firewall_rule_docker" {
  name = var.FIREWALL_RULE_FOR_DOCKER
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = var.FIREWALL_RULE_FOR_DOCKER_PORTS
  }

  direction = "INGRESS"
  source_ranges = [var.PUBLIC_RANGE]
  description = "Firewall rule for docker ports"
}
