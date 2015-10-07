variable "cloudstack_api_url" {}
variable "cloudstack_api_key" {}
variable "cloudstack_secret_key" {}
variable "zone" {
  default = "Sandbox-simulator"
}

provider "cloudstack" {
  api_url = "${var.cloudstack_api_url}"
  api_key = "${var.cloudstack_api_key}"
  secret_key = "${var.cloudstack_secret_key}"
}

module "vpc01" {
  source = "./vpc"
  name = "vpc01"
  zone = "${var.zone}"
}

resource "cloudstack_instance" "bastion" {
  name             = "bastion"
  zone             = "${var.zone}"
  template         = "CentOS 5.3(64-bit) no GUI (Simulator)"
  service_offering = "Small Instance"
  network          = "${module.vpc01.public_network_id}"
  expunge          = true
}

resource "cloudstack_port_forward" "bastion" {
  ipaddress = "${module.vpc01.public_ipaddress_id}"

  forward {
    protocol = "tcp"
    private_port = 22
    public_port = 22
    virtual_machine = "${cloudstack_instance.bastion.id}"
  }
}

resource "cloudstack_instance" "vm01" {
  name             = "vm01"
  zone             = "${var.zone}"
  template         = "CentOS 5.3(64-bit) no GUI (Simulator)"
  service_offering = "Small Instance"
  network          = "${module.vpc01.private_network_id}"
  expunge          = true
}

