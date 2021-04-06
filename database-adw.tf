## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "random_string" "autonomous_data_warehouse_admin_password" {
  length      = 16
  min_numeric = 1
  min_lower   = 1
  min_upper   = 1
  min_special = 1
}

# Uncomment nsg_ids if using a non-Free Tier database. NSG is only available on database
# with dedicated Exadata infrastructure.
resource "oci_database_autonomous_database" "autonomous_data_warehouse" {
  compartment_id           = var.compartment_ocid
  cpu_core_count           = "1"
  db_name                  = var.adw_database_name
  admin_password           = random_string.autonomous_data_warehouse_admin_password.result
  data_storage_size_in_tbs = var.adw_storage_size_in_tbs
  display_name             = var.adw_display_name
  is_free_tier             = "true"
  #  subnet_id                = oci_core_subnet.private_subnet.id
  db_workload              = "DW"
  license_model            = "LICENSE_INCLUDED"
  #  nsg_ids                  = [oci_core_network_security_group.network_security_group.id]
}

output "autonomous_data_warehouse_admin_password" {
  value = random_string.autonomous_data_warehouse_admin_password.result
}

