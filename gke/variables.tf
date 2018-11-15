// General variables
variable "project" {
  default = "dummy-charged-state"
}

// GCP Variables
variable "gcp_cluster_count" {
    type = "string"
    description = "Count of cluster instances to start."
    default = "1"
}
variable "cluster_name" {
    type = "string"
    description = "Cluster name for the GCP Cluster."
}
variable "zone" {
    type = "string"
    description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
}
variable "additional_zones" {
    type = "list"
    description = "GCP additional zones, e.g. us-east1-c (which must be in gcp_region)"
}
variable "node_machine_type" {
    type = "string"
    description = "GCE machine type"
    default = "n1-standard-1"
}
variable "node_disk_size" {
    description = "Node disk size in GB"
    default = "20"
}	
variable "preemptible"{
    description = "Preemptible instances last for up to 24 hours"
    default = "false"
}
