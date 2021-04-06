## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "random_string" "autonomous_data_warehouse_wallet_password" {
  length  = 16
  special = true
}

resource "oci_database_autonomous_database_wallet" "autonomous_data_warehouse_wallet" {
  autonomous_database_id = oci_database_autonomous_database.autonomous_data_warehouse.id
  password               = random_string.autonomous_data_warehouse_wallet_password.result
  base64_encode_content  = "true"
}

resource "local_file" "autonomous_data_warehouse_wallet_file" {
  content_base64 = oci_database_autonomous_database_wallet.autonomous_data_warehouse_wallet.content
  filename       = "${path.module}/wallet_${oci_database_autonomous_database.autonomous_data_warehouse.db_name}.zip"
}

resource "oci_objectstorage_object" "database_wallet" {
  bucket    = oci_objectstorage_bucket.database_wallet.name
  content   = oci_database_autonomous_database_wallet.autonomous_data_warehouse_wallet.content
  namespace = var.object_storage_namespace
  object    = "wallet_${oci_database_autonomous_database.autonomous_data_warehouse.db_name}.zip"

  depends_on = [
    oci_objectstorage_bucket.database_wallet
  ]
}
