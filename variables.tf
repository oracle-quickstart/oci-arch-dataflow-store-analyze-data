## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "region" {}
variable "user_ocid" {} #Comment when creating Resource Manager zip file
variable "tenancy_ocid" {}
variable "compartment_ocid" {}

variable "dataflow_bucket_name" {}
variable "dataflow_bucket_access_type" {}
variable "dataflow_bucket_storage_tier" {}

variable "dataflow_admins_group_name" {}
variable "dataflow_admins_group_description" {}

variable "dataflow_admins_policy_name" {}
variable "dataflow_admins_policy_description" {}

variable "dataflow_users_group_name" {}
variable "dataflow_users_group_description" {}

variable "dataflow_users_policy_name" {}
variable "dataflow_users_policy_description" {}

variable "application_display_name" {
  default = "tf_app"
}

variable "application_driver_shape" {
  default = "VM.Standard2.1"
}

variable "application_executor_shape" {
  default = "VM.Standard2.1"
}

variable "application_file_uri" {}

variable "application_archive_uri" {}

variable "dataflow_logs_bucket_uri" {}

variable "dataflow_warehouse_bucket_uri" {}

variable "application_language" {
  default = "PYTHON"
}

variable "application_num_executors" {
  default = 1
}

variable "application_spark_version" {
  default = "2.4"
}

variable "invoke_run_display_name" {
  default = "tf_run"
}

# VCN variables

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "ATP_PrivateSubnet-CIDR" {
  default = "10.0.2.0/24"
}

variable "fingerprint" {}
variable "private_key_path" {}
variable "ATP_password" {
    default = "Oracle2021"
}

variable "VCNname" {
  default = "VCN"
}

variable "Shape" {
  default = "VM.Standard.E2.1"
}

variable "OsImage" {
   default = "Oracle-Linux-7.8-2020.05.26-0"
}

variable "ATP_database_cpu_core_count" {
  default = 1
}

variable "ATP_database_data_storage_size_in_tbs" {
  default = 1
}

variable "ATP_database_db_name" {
  default = "atpdb1"
}

variable "ATP_database_db_version" {
  default = "19c"
}

variable "ATP_database_defined_tags_value" {
  default = ""
}

variable "ATP_database_display_name" {
  default = "ATP"
}

variable "ATP_database_freeform_tags" {
  default = {
    "Owner" = "ATP"
  }
}

variable "ATP_database_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "ATP_tde_wallet_zip_file" {
  default = "tde_wallet_ATPdb1.zip"
}

variable "ATP_private_endpoint_label" {
  default = "ATPPrivateEndpoint"
}


