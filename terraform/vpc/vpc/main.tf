resource "cloudstack_vpc" "vpc" {
    name         = "${var.name}"
    cidr         = "${var.vpc_cidr}"
    vpc_offering = "Default VPC Offering"
    zone         = "${var.zone}"
}

resource "cloudstack_ipaddress" "public_ipaddress" {
  vpc = "${cloudstack_vpc.vpc.id}"
}

resource "cloudstack_network" "public" {
    name             = "${cloudstack_vpc.vpc.name}-public"
    cidr             = "${var.public_cidr}"
    network_offering = "DefaultIsolatedNetworkOfferingForVpcNetworks"
    vpc              = "${cloudstack_vpc.vpc.id}"
    zone             = "${var.zone.id}"
}

resource "cloudstack_network_acl" "public" {
    name = "public"
    vpc  = "${cloudstack_vpc.vpc.id}"
}

resource "cloudstack_network_acl_rule" "public" {
  aclid = "${cloudstack_network_acl.public.id}"

  rule {
    action = "allow"
    source_cidr = "0.0.0.0/0"
    protocol = "tcp"
    ports = [22]
    traffic_type = "ingress"
  }

  rule {
    action = "allow"
    source_cidr = "0.0.0.0/0"
    protocol = "all"
    traffic_type = "egress"
  }
}

resource "cloudstack_network" "private" {
    name             = "${cloudstack_vpc.vpc.name}-private"
    cidr             = "${var.private_cidr}"
    network_offering = "DefaultIsolatedNetworkOfferingForVpcNetworksNoLB"
    vpc              = "${cloudstack_vpc.vpc.id}"
    zone             = "${var.zone.id}"
}

resource "cloudstack_network_acl" "private" {
    name = "private"
    vpc  = "${cloudstack_vpc.vpc.id}"
}

resource "cloudstack_network_acl_rule" "private" {
  aclid = "${cloudstack_network_acl.private.id}"

  rule {
    action = "allow"
    source_cidr = "${var.vpc_cidr}"
    protocol = "tcp"
    ports = [22]
    traffic_type = "ingress"
  }
}

