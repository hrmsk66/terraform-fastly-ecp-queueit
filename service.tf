resource "fastly_service_compute" "service" {
  name = var.service_name

  domain {
    name = var.domain
  }

  backend {
    address           = var.queueit_hostname
    name              = "queue-it"
    port              = 443
    use_ssl           = true
    ssl_cert_hostname = var.queueit_hostname
    ssl_sni_hostname  = var.queueit_hostname
    override_host     = var.queueit_hostname
  }

  package {
    filename         = "../pkg/${var.service_name}.tar.gz"
    source_code_hash = filesha512("../pkg/${var.service_name}.tar.gz")
  }

  dictionary {
    name = var.dictionary.name
  }

  force_destroy = true
}

resource "fastly_service_dictionary_items" "items" {
  for_each = {
    for d in fastly_service_compute.service.dictionary : d.name => d if d.name == var.dictionary.name
  }

  service_id    = fastly_service_compute.service.id
  dictionary_id = each.value.dictionary_id
  items         = var.dictionary.items

  manage_items = true
}
