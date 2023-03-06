k8s_version  = "1.23"
psql_version = 14

labels = {
  "project" = "slurm"
  "env"     = "lab"
}

cidr_blocks = [
  ["172.20.0.0/27"],
  ["172.21.0.0/27"],
  ["172.22.0.0/27"],
]

resources = {
  disk_size = 30
  disk_type = "network-hdd"
  cpu       = 2
  memory    = 2
}

psql_resources = {
  resource_preset_id = "b1.medium"
  disk_type_id       = "network-ssd"
  disk_size          = 10
}

psql_db = {
  name = "yelb-db"
  user = "yelb-db-user"
}

scale_count = 3

name_prefix = "slurm"

redis = {
  environment        = "PRODUCTION"
  version            = "7.0"
  disk_size          = 8
  resource_preset_id = "b3-c1-m4"
}
