## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

## Create the buckets

resource "oci_objectstorage_bucket" "dataflow_logs" {
  compartment_id = var.compartment_ocid
  name           = var.logs_bucket_name
  namespace      = var.object_storage_namespace
}

resource "oci_objectstorage_bucket" "dataflow_apps" {
  compartment_id = var.compartment_ocid
  name           = var.apps_bucket_name
  namespace      = var.object_storage_namespace
}

resource "oci_objectstorage_bucket" "dataflow_data" {
  compartment_id = var.compartment_ocid
  name           = var.data_bucket_name
  namespace      = var.object_storage_namespace
}

resource "oci_objectstorage_bucket" "database_wallet" {
  compartment_id = var.compartment_ocid
  name           = "Wallet"
  namespace      = var.object_storage_namespace
}

# Upload the sample log file
resource "oci_objectstorage_object" "sample_logs" {
  bucket    = var.data_bucket_name
  namespace = var.object_storage_namespace
  source    = var.path_to_sample_logs
  object    = "sample_logs.log"

  depends_on = [
    oci_objectstorage_bucket.dataflow_data
  ]
}

# Upload the app dependencies
resource "oci_objectstorage_object" "dependencies" {
  bucket    = var.apps_bucket_name
  namespace = var.object_storage_namespace
  source    = var.path_to_archive_zip
  object    = "archive.zip"
}

# Upload the PySpark app
resource "oci_objectstorage_object" "spark_app" {
  bucket    = var.apps_bucket_name
  namespace = var.object_storage_namespace
  source    = var.path_to_pyspark_app
  object    = var.apps_bucket_object_name

  depends_on = [
    oci_objectstorage_bucket.dataflow_apps
  ]
}

