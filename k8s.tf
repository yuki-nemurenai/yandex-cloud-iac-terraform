resource "yandex_kubernetes_cluster" "this" {
  name                    = "${var.name_prefix}-k8s-cluster"
  network_id              = yandex_vpc_network.this.id
  labels                  = var.labels
  release_channel         = var.release_channel
  network_policy_provider = var.network_policy_provider
  master {
    version = var.k8s_version

    regional {
      region = "ru-central1"
      dynamic "location" {
        for_each = toset(var.az)
        content {
          zone      = location.value
          subnet_id = yandex_vpc_subnet.this[location.value].id
        }
      }
    }
    public_ip          = true
    security_group_ids = [yandex_vpc_security_group.this.id]
  }
  service_account_id      = yandex_iam_service_account.this.id
  node_service_account_id = yandex_iam_service_account.this.id
  depends_on = [
    yandex_iam_service_account.this,
    yandex_resourcemanager_folder_iam_binding.this,
    yandex_kms_symmetric_key.this,
    yandex_kms_symmetric_key_iam_binding.this
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.this.id
  }
}

resource "yandex_kubernetes_node_group" "this" {
  cluster_id = yandex_kubernetes_cluster.this.id
  name       = "${var.name_prefix}-k8s-node-group"
  version    = var.k8s_version
  labels     = var.labels

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [for k, v in yandex_vpc_subnet.this : yandex_vpc_subnet.this[k].id]
      security_group_ids = [yandex_vpc_security_group.this.id]
    }

    resources {
      memory = var.resources.memory
      cores  = var.resources.cpu
    }

    boot_disk {
      type = var.resources.disk_type
      size = var.resources.disk_size
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = var.container_runtime
    }
  }

  scale_policy {
    fixed_scale {
      size = var.scale_count
    }
  }

  allocation_policy {
    dynamic "location" {
      for_each = toset(var.az)
      content {
        zone = location.value
      }
    }
  }
}
