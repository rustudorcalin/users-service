resource "google_container_cluster" "k8s" {
    name               = "${var.cluster_name}"
    zone               = "${var.zone}"
    initial_node_count = "${var.gcp_cluster_count}"
    additional_zones = "${var.additional_zones}"
    node_config {
        machine_type = "${var.node_machine_type}"
        disk_size_gb = "${var.node_disk_size}"
        preemptible = "${var.preemptible}"
        oauth_scopes = [
          "https://www.googleapis.com/auth/compute",
          "https://www.googleapis.com/auth/devstorage.read_only",
          "https://www.googleapis.com/auth/logging.write",
          "https://www.googleapis.com/auth/monitoring",
        ]
    }
    provisioner "local-exec" {
        command = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${var.zone} --project=${var.project}"
    }
}

