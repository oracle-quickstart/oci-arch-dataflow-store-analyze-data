## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# VCN with Service Gateway and Private Subnet for ADW

data "oci_core_services" "adw_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

data "oci_core_service_gateways" "adw_service_gateways" {
  compartment_id = var.compartment_ocid
  state          = "AVAILABLE"
  vcn_id         = oci_core_vcn.adw_vcn.id
}

# VCN
resource "oci_core_vcn" "adw_vcn" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = var.vcn_cidr_blocks
  dns_label      = var.vcn_dns_label
  display_name   = "VCN for Log Results Database"
}

# Regional subnet
# Uncomment prohibit_public_ip_on_vnic to make a private subnet. Private subnet is
# not available on Free Tier ADW
resource "oci_core_subnet" "private_subnet" {
  cidr_block     = var.subnet_cidr_block
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.adw_vcn.id
  display_name   = "Public Subnet" #"Private Subnet"
  #prohibit_public_ip_on_vnic = "true"
  dns_label         = "subnet"
  security_list_ids = [oci_core_security_list.adw_subnet_security_list.id]
  route_table_id    = oci_core_route_table.adw_route_table.id
}

# Security List for ADW subnet
resource "oci_core_security_list" "adw_subnet_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.adw_vcn.id
  display_name   = "ADW Subnet"

  ingress_security_rules {
    protocol    = "6" # TCP
    source      = data.oci_core_services.adw_services.services[0]["cidr_block"]
    source_type = "SERVICE_CIDR_BLOCK"
    tcp_options {
      min = 1522
      max = 1522
    }
  }
}

# Route table and rules
resource "oci_core_route_table" "adw_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.adw_vcn.id
  display_name   = "Dataflow Route Table"

  route_rules {
    destination       = data.oci_core_services.adw_services.services[0]["cidr_block"]
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.adw_service_gateway.id
  }
}

# Transit route table for FastConnect or VPN Connect
resource "oci_core_route_table" "adw_transit_routing" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.adw_vcn.id
  display_name   = "ADW Transit Routing"
}

# Service Gateway
resource "oci_core_service_gateway" "adw_service_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.adw_vcn.id
  display_name   = "Dataflow Service Gateway"
  services {
    service_id = data.oci_core_services.adw_services.services[0]["id"]
  }
}

# Network Security Group
# Assumes ADW is on dedicated Exadata infrastructure.
# If ADW is NOT on dedicated Exadata infrastructure
# then you must use a Security List instead.

resource "oci_core_network_security_group" "network_security_group" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.adw_vcn.id
  display_name   = "Dataflow Network Security Group"
}

resource "oci_core_network_security_group_security_rule" "ssh_security_rule" {
  network_security_group_id = oci_core_network_security_group.network_security_group.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"
  stateless                 = false

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "adw_security_rule" {
  network_security_group_id = oci_core_network_security_group.network_security_group.id
  protocol                  = "6" # TCP
  direction                 = "INGRESS"
  source_type               = "SERVICE_CIDR_BLOCK"
  source                    = data.oci_core_services.adw_services.services[0]["cidr_block"]
  stateless                 = false

  tcp_options {
    destination_port_range {
      min = 1522
      max = 1522
    }
  }
}
// */

