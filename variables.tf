variable "domain" {
  type = string
}

variable "service_name" {
  type = string
}

variable "queueit_hostname" {
  type = string
}

variable "dns_zone" {
  type = string
}

variable "dictionary" {
  type = object({ name = string, items = map(string) })
}