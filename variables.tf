## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "compartment_ocid" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "region" {}
variable "object_storage_namespace" {}
variable "logs_bucket_name" {}
variable "apps_bucket_name" {}
variable "data_bucket_name" {}
variable "apps_bucket_object_name" {}
variable "application_display_name" {}
variable "application_driver_shape" {}
variable "application_executor_shape" {}
variable "application_language" {}
variable "application_num_executors" {}
variable "application_spark_version" {}
variable "adw_storage_size_in_tbs" {}
variable "adw_database_name" {}
variable "adw_display_name" {}
variable "vcn_cidr_blocks" {}
variable "vcn_dns_label" {}
variable "subnet_dns_label" {}
variable "subnet_cidr_block" {}
variable "path_to_sample_logs" {} 
variable "path_to_archive_zip" {} 
variable "path_to_pyspark_app" {} 