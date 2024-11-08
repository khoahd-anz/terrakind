locals {
    k8s_config_path = pathexpand("${path.cwd}/../contexts/kubeconfig")
}