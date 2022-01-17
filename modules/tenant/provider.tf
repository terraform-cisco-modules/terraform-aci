terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">= 1.2.0"
    }
    netascode = {
      source  = "netascode/aci"
      version = ">=0.2.3"
    }
    mso = {
      source  = "CiscoDevNet/mso"
      version = ">= 0.4.1"
    }
  }
}

provider "aci" {
  cert_name   = var.certName
  password    = var.apicPass
  private_key = var.privateKey
  url         = var.apicUrl
  username    = var.apicUser
  insecure    = true
}

provider "mso" {
  domain   = var.ndoDomain
  insecure = true
  password = var.ndoPass
  platform = "nd"
  url      = var.ndoUrl
  username = var.ndoUser
}

provider "netascode" {
  cert_name   = var.certName
  password    = var.apicPass
  private_key = var.privateKey
  url         = var.apicUrl
  username    = var.apicUser
  insecure    = true
}
