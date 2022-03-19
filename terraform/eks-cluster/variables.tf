locals {
  k8s_cluster_name = "cloudcat-eks"
}

variable "k8s_version" {
  default = "1.21"
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}
variable "nodegroup_desired_size" {
  type    = number
  default = 2
}

variable "nodegroup_min_size" {
  type    = number
  default = 1
}

variable "nodegroup_max_size" {
  type    = number
  default = 3
}

variable "nodegroup_disk_size" {
  type    = string
  default = 50
}

variable "nodegroup_instance_types" {
  type    = list(string)
  default = ["t2.small", "t2.micro"]
}

variable "capacity_type" {
  type    = string
  default = "SPOT"
}