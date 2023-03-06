resource "yandex_iam_service_account" "this" {
  name        = "${var.name_prefix}-k8s-cluster-manager"
  description = "Service account to manage k8s cluster"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}

resource "yandex_kms_symmetric_key" "this" {
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}

resource "yandex_kms_symmetric_key_iam_binding" "this" {
  symmetric_key_id = yandex_kms_symmetric_key.this.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}

