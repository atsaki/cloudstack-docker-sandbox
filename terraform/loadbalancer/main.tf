variable "cloudstack_api_url" {}
variable "cloudstack_api_key" {}
variable "cloudstack_secret_key" {}

provider "cloudstack" {
  api_url = "${var.cloudstack_api_url}"
  api_key = "${var.cloudstack_api_key}"
  secret_key = "${var.cloudstack_secret_key}"
}

resource "cloudstack_network" "nw01" {
  name = "nw01"
  zone = "Sandbox-simulator"
  cidr = "10.0.0.0/16"
  network_offering = "DefaultIsolatedNetworkOfferingWithSourceNatService"
}

resource "cloudstack_instance" "web" {
  count = 3
  name = "${format("web%02d", count.index+1)}"
  zone = "Sandbox-simulator"
  template = "CentOS 5.3(64-bit) no GUI (Simulator)"
  service_offering = "Small Instance"
  network = "${cloudstack_network.nw01.id}"
}
