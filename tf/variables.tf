variable do_token {
  description = "The API token from the DO control panel"
  type = string
  sensitive = true
}

variable cluster_name {
  description = "The name of the K8s cluster to create"
  type = string
}

variable cluster_version {
  description = "The version of the cluster to create"
  type = string
}

variable region {
  description = "The DO region sluf to create the resources"
  type = string
  default = "nyc3"
}

variable host_domain {
  description = "domain to create DNS records for"
  type = string
}

variable host_names {
  description = "the hostnames to create dns records and pod names for"
  type = list(string)
}

variable min_nodes {
  description = "The min number of nodes in the default pool"
  type = number
  default = 1
}

variable max_nodes {
  description = "The max number of nodes in the default pool"
  type = number
  default = 3
}

variable default_node_size {
  description = "The default DO node slug for each node in the default pool"
  type = string
  default = "s-2vcpu-4gb"
}
