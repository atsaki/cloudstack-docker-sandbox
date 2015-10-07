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

resource "cloudstack_instance" "vm01" {
  name = "vm01"
  zone = "Sandbox-simulator"
  template = "CentOS 5.3(64-bit) no GUI (Simulator)"
  service_offering = "Small Instance"
  network = "${cloudstack_network.nw01.id}"
}

resource "cloudstack_ipaddress" "ip01" {
  network = "${cloudstack_network.nw01.id}"
}

resource "cloudstack_firewall" "fw01" {
  ipaddress = "${cloudstack_ipaddress.ip01.id}"

  rule {
    source_cidr = "0.0.0.0/0"
    protocol = "tcp"
    ports = [22, 80]
  }
}

resource "cloudstack_port_forward" "pf01" {
  ipaddress = "${cloudstack_ipaddress.ip01.id}"

  forward {
    protocol = "tcp"
    private_port = 22
    public_port = 22
    virtual_machine = "${cloudstack_instance.vm01.id}"
  }

  forward {
    protocol = "tcp"
    private_port = 80
    public_port = 80
    virtual_machine = "${cloudstack_instance.vm01.id}"
  }
}
