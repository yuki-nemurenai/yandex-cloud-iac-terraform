variable "k8s_version" {
  type        = string
  description = "Version of the k8s cluster"
}

variable "psql_version" {
  type        = number
  description = "Version of the PostgreSQL cluster"
}

variable "labels" {
  type        = map(string)
  description = "Labels to add to resources"
}

variable "cidr_blocks" {
  type        = list(list(string))
  description = "List of lists of IPv4 CIDR blocks for subnets"
}

variable "resources" {
  type = object({
    disk_size = number
    disk_type = string
    cpu       = number
    memory    = number

  })
  description = "Nodes resources: CPU, Memory and Disk size/type"
}

variable "psql_resources" {
  type = object({
    resource_preset_id = string
    disk_type_id       = string
    disk_size          = number
  })
  description = "Resources allocated to hosts of the PostgreSQL cluster."
}

variable "container_runtime" {
  type        = string
  default     = "docker"
  description = "Type of container runtime. Possible values: docker or containerd"
}

variable "az" {
  type = list(string)
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
  ]
  description = "Availability Zones"
}

variable "scale_count" {
  type        = number
  description = "Number of nodes to create in the k8s cluster"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID (exported from environment variables)"
}

variable "name_prefix" {
  type        = string
  description = "Name prefix"
}

variable "release_channel" {
  type        = string
  default     = "STABLE"
  description = "Cluster release channel. Possible values: RAPID, REGULAR, STABLE"
}

variable "network_policy_provider" {
  type        = string
  default     = "CALICO"
  description = "Network policy provider for the cluster. Possible values: CALICO, CILIUM"
}

variable "psql_environment" {
  type        = string
  default     = "PRODUCTION"
  description = "Deployment environment of the PostgreSQL cluster. Possible values: PRODUCTION, PRESTABLE"
}

variable "psql_db" {
  type = object({
    name = string
    user = string
  })
  description = "Parameters of the PostgreSQL Database"
}

variable "psql_db_password" {
  type        = string
  description = "Sensitive value. Can be set by environment variables"
}

variable "redis" {
  type = object({
    environment        = string
    version            = string
    disk_size          = number
    resource_preset_id = string
  })
  description = "MDB Redis Cluster variables"
}

variable "redis_password" {
  type        = string
  description = "MDB Redis Cluster password"
}
