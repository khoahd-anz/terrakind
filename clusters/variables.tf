variable "clusters" {
  type = list(object({
    name       = string
    node_image = optional(string, "kindest/node:v1.31.0")
    nodes = list(object({
      role                   = string
      kubeadm_config_patches = optional(list(string))
      extra_port_mappings = optional(list(object({
        listen_address = optional(string, "0.0.0.0")
        container_port = string
        host_port      = string
        protocol       = string
      })), [])
    }))
  }))
  default = []

  validation {
    condition = alltrue(
      [
        for cluster in var.clusters : alltrue(
          [for node in cluster.nodes : contains(
            ["control-plane", "worker"], node.role)
          ]
        )
      ]
    )
    error_message = "Invalid node type, nodes can only be \"control-plane\" or \"worker\"."
  }
}
