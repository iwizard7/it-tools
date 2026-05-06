job "it-tools" {
  datacenters = ["dc1"]
  type        = "service"

  group "web" {
    count = 1

    network {
      port "http" {
        to = 80
      }
    }

    service {
      name     = "it-tools"
      port     = "http"
      provider = "nomad"

      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "it-tools" {
      driver = "docker"

      config {
        image = "corentinth/it-tools:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 200 # MHz
        memory = 128 # MB
      }
    }
  }
}
