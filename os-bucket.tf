## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_objectstorage_bucket" "dataflow_bucket" {
    compartment_id = var.compartment_ocid
    name = var.dataflow_bucket_name
    namespace = data.oci_objectstorage_namespace.namespace.namespace
    access_type = var.dataflow_bucket_access_type
    storage_tier = var.dataflow_bucket_storage_tier
}