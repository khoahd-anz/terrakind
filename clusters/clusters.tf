resource "kind_cluster" "this" {
  for_each = { for cluster in var.clusters : cluster.name => cluster }

  name = each.value.name
  node_image = each.value.node_image
  wait_for_ready = true
  kubeconfig_path = local.k8s_config_path

  kind_config {
    kind = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = each.value.nodes

      content {
        role = node.value.role
        kubeadm_config_patches = node.value.kubeadm_config_patches

        dynamic "extra_port_mappings" {
          for_each = node.value.extra_port_mappings

          content {
            listen_address = extra_port_mappings.value.listen_address
            container_port = extra_port_mappings.value.container_port
            host_port      = extra_port_mappings.value.host_port
            protocol       = extra_port_mappings.value.protocol
          }
        }
      }
    }
  }
}
