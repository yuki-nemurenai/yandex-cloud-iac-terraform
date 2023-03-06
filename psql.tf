resource "yandex_mdb_postgresql_cluster" "this" {
  name               = "${var.name_prefix}-psql-cluster"
  environment        = var.psql_environment
  network_id         = yandex_vpc_network.this.id
  security_group_ids = [yandex_vpc_security_group.this.id]

  config {
    version = var.psql_version
    resources {
      resource_preset_id = var.psql_resources.resource_preset_id
      disk_type_id       = var.psql_resources.disk_type_id
      disk_size          = var.psql_resources.disk_size
    }
  }

  dynamic "host" {
    for_each = toset(var.az)
    content {
      zone      = host.value
      subnet_id = yandex_vpc_subnet.this[host.value].id
    }
  }
}

resource "yandex_mdb_postgresql_database" "this" {
  cluster_id = yandex_mdb_postgresql_cluster.this.id
  name       = var.psql_db.name
  owner      = var.psql_db.user
  depends_on = [
    yandex_mdb_postgresql_user.this
  ]
}

resource "yandex_mdb_postgresql_user" "this" {
  cluster_id = yandex_mdb_postgresql_cluster.this.id
  name       = var.psql_db.user
  password   = var.psql_db_password
}
