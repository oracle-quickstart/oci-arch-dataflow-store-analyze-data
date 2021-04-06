## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_dataflow_application" "log_analyzer_app" {

  compartment_id = var.compartment_ocid
  display_name   = var.application_display_name
  driver_shape   = var.application_driver_shape
  executor_shape = var.application_executor_shape
  file_uri       = "oci://${var.apps_bucket_name}@${var.object_storage_namespace}/${var.apps_bucket_object_name}"
  archive_uri    = "oci://${var.apps_bucket_name}@${var.object_storage_namespace}/archive.zip"
  language       = var.application_language
  num_executors  = var.application_num_executors
  spark_version  = var.application_spark_version

  depends_on = [
    oci_objectstorage_object.spark_app
  ]
}
