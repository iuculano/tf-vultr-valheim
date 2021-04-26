terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.1.3"
    }
  }
}

provider "vultr" {
  api_key = "YFC6IX22I3WFCFEP4GCR2FB4G63XDFO56E5A"
}
