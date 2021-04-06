:: Do not use quotes around the values.
:: Do not have spaces around the = signs
@echo off
set TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..
set TF_VAR_user_ocid=ocid1.user.oc1..
set TF_VAR_compartment_ocid=ocid1.compartment.oc1..
set TF_VAR_private_key_path=%HOMEPATH%\.ssh\oci_api_key.pem
set TF_VAR_fingerprint=2a:b4:ef: ...
set TF_VAR_region=ca-toronto-1