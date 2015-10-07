output "vpc_id" {
  value = "${cloudstack_vpc.vpc.id}"
}
output "public_network_id" {
  value = "${cloudstack_network.public.id}"
}
output "public_ipaddress_id" {
  value = "${cloudstack_ipaddress.public_ipaddress.id}"
}
output "private_network_id" {
  value = "${cloudstack_network.private.id}"
}
