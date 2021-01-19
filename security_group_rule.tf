## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Rules related to ATPSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "ATPSecurityEgressGroupRule" {
    network_security_group_id = oci_core_network_security_group.ATPSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = var.VCN-CIDR
    destination_type = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "ATPSecurityIngressGroupRules" {
    network_security_group_id = oci_core_network_security_group.ATPSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = var.VCN-CIDR
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = 1522
            min = 1522
        }
    }
}

# Rules related to SSHSecurityGroup

# EGRESS

resource "oci_core_network_security_group_security_rule" "SSHSecurityEgressGroupRule" {
    network_security_group_id = oci_core_network_security_group.SSHSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

# INGRESS

resource "oci_core_network_security_group_security_rule" "SSHSecurityIngressGroupRules" {
    network_security_group_id = oci_core_network_security_group.SSHSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = 22
            min = 22
        }
    }
}