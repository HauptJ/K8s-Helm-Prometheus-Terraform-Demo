resource "helm_release" "kube-prometheus-stack" {
  name = "kube-prometheus-stack"
  namespace = "default"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "kube-prometheus-stack"
  set = [
    {
      name = "grafana.adminUser"
      value = "grafanaUser"
    },
    {
      name = "grafana.adminPassword"
      value = "prom-op"
    }
  ]
  depends_on = [
    digitalocean_kubernetes_cluster.default_cluster
  ]
}

resource "helm_release" "nginx_ingress_chart" {
  name = "nginx-ingress-controller"
  namespace = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "nginx-ingress-controller"
  set = [
    {
      name = "image.repository"
      value = "bitnamilegacy/nginx-ingress-controller"
    },
    {
      name = "defaultBackend.image.repository"
      value = "bitnamilegacy/nginx"
    },
    {
      name = "service.type"
      value = "LoadBalancer"
    },
    {
      name = "service.annotations.kubernetes\\.digitalocean\\.com/load-balancer-id"
      value = digitalocean_loadbalancer.ingress_load_balancer.id
    }
  ]
  depends_on = [
    digitalocean_loadbalancer.ingress_load_balancer
  ]
}

resource "kubernetes_ingress_v1" "default_ingress" {
  depends_on = [
    helm_release.nginx_ingress_chart
  ]
  metadata {
    name = "${var.cluster_name}-ingress"
    namespace = "default"
  }

  spec { 

    ingress_class_name = "nginx"

    rule {
      host = "prom.dsort.net"
      http { 
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "kube-prometheus-stack-prometheus"
              port { 
                number = 9090
              }
            }
          }
        }
      }
    }

    rule {
      host = "alert.dsort.net"
      http { 
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "kube-prometheus-stack-alertmanager"
              port { 
                number = 9093
              }
            }
          }
        }
      }
    }

    rule {
      host = "graf.dsort.net"
      http { 
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "kube-prometheus-stack-grafana"
              port { 
                number = 80
              }
            }
          }
        }
      }
    }

    rule {
      host = "node.dsort.net"
      http { 
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "kube-prometheus-stack-prometheus-node-exporter"
              port { 
                number = 9100
              }
            }
          }
        }
      }
    }
  }
}

