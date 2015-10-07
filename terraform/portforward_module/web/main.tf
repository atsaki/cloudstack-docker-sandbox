variable "name" {}
variable "zone" {}
variable "template" {}
variable "service_offering" {}
variable "network" {}

resource "cloudstack_instance" "instance" {
  name = "${var.name}"
  zone = "${var.zone}"
  template = "${var.template}"
  service_offering = "${var.service_offering}"
  network = "${var.network}"
}

resource "cloudstack_ipaddress" "ip" {
  network = "${cloudstack_instance.instance.network}"
}

resource "cloudstack_firewall" "firewall" {
  ipaddress = "${cloudstack_ipaddress.ip.id}"

  rule {
    source_cidr = "0.0.0.0/0"
    protocol = "tcp"
    ports = [80]
  }
}

resource "cloudstack_port_forward" "port_forward" {
  ipaddress = "${cloudstack_ipaddress.ip.id}"

  forward {
    protocol = "tcp"
    private_port = 80
    public_port = 80
    virtual_machine = "${cloudstack_instance.instance.id}"
  }
}
