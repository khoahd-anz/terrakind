terraform {
    required_providers {
      kind = {
        source  = "tehcyx/kind"
        version = "0.0.17"
      }
    }

    // use local backend
    backend "local" {
      path = "tf_states/clusters.tfstate"
    }
}
