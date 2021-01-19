## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

// These variables would commonly be defined as environment variables or sourced in a .env file

resource "oci_dataflow_application" "tf_application" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = var.application_display_name
  driver_shape   = var.application_driver_shape
  executor_shape = var.application_executor_shape
  file_uri       = var.application_file_uri
  language       = var.application_language
  num_executors  = var.application_num_executors
  spark_version  = var.application_spark_version
  archive_uri = var.application_archive_uri
}

data "oci_dataflow_applications" "tf_applications" {
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  display_name = var.application_display_name
}

resource "oci_dataflow_invoke_run" "tf_invoke_run" {
  #Required
  application_id = oci_dataflow_application.tf_application.id
  compartment_id = var.compartment_ocid
  display_name   = var.invoke_run_display_name
}

resource "oci_core_virtual_network" "test_vcn" {
  cidr_block     = "10.4.0.0/16"
  compartment_id = var.compartment_ocid
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block     = "10.4.0.0/24"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.test_vcn.id
}

resource "oci_core_network_security_group" "test_network_security_group" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.test_vcn.id
}

resource "oci_dataflow_private_endpoint" "test_private_endpoint" {
  compartment_id = var.compartment_ocid
  description    = "description"
  display_name   = "pe_name"
  dns_zones      = ["custpvtsubnet.oraclevcn.com"]

  freeform_tags = {
    "Department" = "Finance"
  }

  max_host_count = "256"
  nsg_ids        = [oci_core_network_security_group.test_network_security_group.id]
  subnet_id      = oci_core_subnet.test_subnet.id
}

resource "oci_dataflow_application" "test_application" {
  archive_uri    = var.application_archive_uri
  arguments      = ["arguments"]
  compartment_id = var.compartment_ocid

  configuration = {
    "spark.shuffle.io.maxRetries" = "10"
  }

  description    = "description"
  display_name   = "test_wordcount_app"
  driver_shape   = "VM.Standard2.1"
  executor_shape = "VM.Standard2.1"
  file_uri       = var.application_file_uri

  freeform_tags = {
    "Department" = "Finance"
  }

  language        = "PYTHON"
  logs_bucket_uri = var.dataflow_logs_bucket_uri
  num_executors   = "1"

  parameters {
    name  = "name"
    value = "value"
  }

  private_endpoint_id  = oci_dataflow_private_endpoint.test_private_endpoint.id
  spark_version        = "2.4"
  warehouse_bucket_uri = var.dataflow_warehouse_bucket_uri
}

resource "oci_dataflow_invoke_run" "test_invoke_run" {
  application_id = oci_dataflow_application.test_application.id
  compartment_id = var.compartment_ocid
  display_name   = "test_run_name"
}

data "oci_dataflow_private_endpoints" "test_private_endpoints" {
  compartment_id = var.compartment_ocid

  // service supports using only one filter at a time for LIST API call
  display_name = "pe_name"

  filter {
    name   = "id"
    values = [oci_dataflow_private_endpoint.test_private_endpoint.id]
  }
}

data "oci_dataflow_invoke_runs" "tf_invoke_runs" {
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  application_id = oci_dataflow_application.tf_application.id
}

data "oci_dataflow_run_logs" "tf_run_logs" {
  #Required
  run_id = oci_dataflow_invoke_run.tf_invoke_run.id
}