resource "digitalocean_domain" "host_domains" {
  name = var.host_domain
}

resource "digitalocean_record" "a_records" {
  for_each = toset(var.host_names)
  domain = var.host_domain
  type = "A"
  ttl = 60
  name = each.value
  value = digitalocean_loadbalancer.ingress_load_balancer.ip
  depends_on = [
    digitalocean_loadbalancer.ingress_load_balancer
  ]
}

