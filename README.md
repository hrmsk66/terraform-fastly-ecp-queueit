# Terraform module for provisioning Queue-it connectors on the Fastly Compute@Edge platform

An example Terraform module that creates a Fastly service for the Queue-it connector, issues and deploys a certificate, and adds DNS records to point traffic to Fastly. Once the changes are completed successfully, the Fastly service will be ready to process requests over HTTPS.

In this example, we assume that the DNS records are added to Route 53.

## Usage

Start by creating a directory in your Compute@Edge project root directory and create a .tf file in it.

```
mkdir tf && touch tf/main.tf
```

Example of a .tf file:

```hcl
provider "aws" {
    region = "ap-northeast-1"
}

locals {
  service_name = "my-queueit-connector"

  domain = "my.example.com"

  dns_zone = "example.com"

  queueit_hostname = "my-customer-id.queue-it.net?ref=latest"

  dictionary = {
    name = "integrationConfiguration"

    items = {
      "apiKey"        = "XXX"
      "customerId"    = "XXX"
      "queueItOrigin" = "queue-it"
      "secret"        = "XXX"
    }
  }
}

module "service" {
    source = "github.com/hrmsk66/terraform-fastly-ecp-queueit"
    service_name = local.service_name
    domain = local.domain
    dns_zone = local.dns_zone
    queueit_hostname = local.queueit_hostname
    dictionary = local.dictionary
}

output "service" {
    value = module.service.service
}
```

Then...

```
terraform init
terraform apply
```
