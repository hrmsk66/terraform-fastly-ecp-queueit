# Terraform module for provisioning Queue-it connectors on the Fastly Compute@Edge platform

An example Terraform module that creates a Fastly service for the Queue-it connector, issues and deploys a certificate, and adds DNS records to point traffic to Fastly. Once the changes are completed successfully, the Fastly service will be ready to process requests over HTTPS.

In this example, we assume that the DNS records are added to Route 53.

## Usage in a local environment

Start by creating a directory in your Compute@Edge project root directory and create a .tf file in it.

```
mkdir tf && touch tf/main.tf
```

Next add the following code to the main.tf file:

```hcl
provider "aws" {
    region = "ap-northeast-1"
}

locals {
  domain = "www.hkakehas.tokyo"
  dns_zone = "hkakehas.tokyo"
}

module "service" {
    source = "github.com/hkakehashi/terraform-fastly-queueitconn?ref=latest"
    domain = local.domain
}
```

Then...

```
terraform init
terraform apply
```
