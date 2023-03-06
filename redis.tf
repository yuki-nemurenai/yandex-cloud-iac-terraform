resource "yandex_mdb_redis_cluster" "this" {
  name        = "${var.name_prefix}-redis-cluster"
  environment = var.redis.environment
  network_id  = yandex_vpc_network.this.id
  labels      = var.labels

  config {
    version  = var.redis.version
    password = var.redis_password
  }

  resources {
    resource_preset_id = var.redis.resource_preset_id
    disk_size          = var.redis.disk_size
  }

  host {
    zone      = var.az[0]
    subnet_id = yandex_vpc_subnet.this[var.az[0]].id
  }
}

