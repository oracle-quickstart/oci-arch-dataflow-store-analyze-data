## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


data "oci_core_services" "test_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

output "services" {
  value = [data.oci_core_services.test_services.services]
}

resource "oci_core_service_gateway" "test_service_gateway" {
  #Required
  compartment_id = var.compartment_ocid

  services {
    service_id = data.oci_core_services.test_services.services[0]["id"]
  }

  vcn_id = oci_core_virtual_network.VCN.id

  #Optional
  display_name   = "testServiceGateway"
  route_table_id = oci_core_route_table.test_route_table_transit_routing.id
}

data "oci_core_service_gateways" "test_service_gateways" {
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  state  = "AVAILABLE"
  vcn_id = oci_core_virtual_network.VCN.id
}

output "service_gateways" {
  value = [data.oci_core_service_gateways.test_service_gateways.service_gateways]
}

resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.VCN.id
  display_name   = "testRouteTable"

  route_rules {
    destination       = data.oci_core_services.test_services.services[0]["cidr_block"]
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.test_service_gateway.id
  }
}

resource "oci_core_route_table" "test_route_table_transit_routing" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.VCN.id
  display_name   = "testRouteTableTransitRouting"
}

resource "oci_core_security_list" "test_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.VCN.id
  display_name   = "natSecurityList"

  egress_security_rules {
    destination      = data.oci_core_services.test_services.services[0]["cidr_block"]
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "all"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }
}