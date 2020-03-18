variable "region" {}

variable "cluster_name" {}

variable "domain" {}

variable "ssh_public_key_file" {}

variable "master_instance_type" {
    default = "t2.large"
}

variable "worker_instance_type" {
    default = "t2.large"
}

variable "workers_count" {
    default = 1
}