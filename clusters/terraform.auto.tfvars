clusters = [
  {
    name = "management-cluster"
    nodes = [{
      role = "control-plane"
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]
      extra_port_mappings = [{
        container_port = "80"
        host_port      = "80"
        protocol       = "TCP"
        },
        {
          container_port = "443"
          host_port      = "443"
          protocol       = "TCP"
      }]
      },
      {
        role = "worker"
      }
    ]
  },
  {
    name = "worker-cluster-01"
    nodes = [
      {
        role = "control-plane"
      },
      {
        role = "worker"
      }
    ]
  },
  {
    name = "worker-cluster-02"
    nodes = [
      {
        role = "control-plane"
      },
      {
        role = "worker"
      }
    ]
  },
]