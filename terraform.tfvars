## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Tenancy access
/* Use your operating system environment variables
tenancy_ocid     = ""
user_ocid        = ""
compartment_ocid = ""
private_key_path = ""
fingerprint      = ""
region           = ""
*/

# Object Storage
object_storage_namespace = "YOUR-OBJECT-STORAGE-NAMESPACE"

# Buckets for the Dataflow app
logs_bucket_name        = "dataflow-logs"   # Required for Dataflow service to store its logs
apps_bucket_name        = "apps"            # Dataflow app goes in this bucket
apps_bucket_object_name = "dataflow-app.py" # Name of your Dataflow app
data_bucket_name        = "data"            # Your on-prem logs are stored here

# Files to upload into Object Storage
path_to_sample_logs = "sample-logs.log"
path_to_archive_zip = "archive.zip"
path_to_pyspark_app = "dataflow-app.py"

# Dataflow Application
application_display_name   = "Analyze On-prem Logs"
application_driver_shape   = "VM.Standard2.1"
application_executor_shape = "VM.Standard2.1"
application_language       = "PYTHON"
application_num_executors  = "1"
application_spark_version  = "2.4.4"

# Autonomous Data Warehouse
adw_storage_size_in_tbs = "1"
adw_database_name       = "logs"
adw_display_name        = "Processed Logs"

# Networking
vcn_cidr_blocks   = ["10.0.0.0/16"]
vcn_dns_label     = "vcn"
subnet_cidr_block = "10.0.1.0/24"
subnet_dns_label  = "subnet"