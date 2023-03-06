locals {
  kubectl_config = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${yandex_kubernetes_cluster.this.master[0].external_v4_endpoint}
    certificate-authority-data: ${base64encode(yandex_kubernetes_cluster.this.master[0].cluster_ca_certificate)}
  name: slurm-k8s-cluster
contexts:
- context:
    cluster: slurm-k8s-cluster
    user: yc
  name: slurm-k8s-cluster
current-context: slurm-k8s-cluster
users:
- name: yc
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: yc
      args:
      - k8s
      - create-token
KUBECONFIG
}
