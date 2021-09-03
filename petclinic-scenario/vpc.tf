resource    "google_compute_network"    "vpc_network" {
    name    =   var.NETWORK_NAME
    description = "This network is for hosting all infrastruction"
    routing_mode = "REGIONAL"
    mtu = var.MTU
    project = var.project_id
}
