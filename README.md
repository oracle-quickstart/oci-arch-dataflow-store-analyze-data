# oci-arch-dataflow-store-analyze-data

Oracle Cloud Infrastructure Data Flow is a fully managed Apache Spark ™ service that is ideal for processing large volumes of log files.

Data Flow allows for centralized storage of log data in Oracle Cloud Infrastructure Object Storage. It enables analysis of the data by creating an Apache Spark application once and then running it on new logs files as they arrive in Object Storage. The output of this analysis can then be loaded to Autonomous Data Warehouse for querying and reporting. And all of this is done with no overhead such as provisioning of clusters or software installs.

These terraform scripts cover the administrative steps you have to do before using OCI DataFlow. 

## Terraform Provider for Oracle Cloud Infrastructure

The OCI Terraform Provider is now available for automatic download through the Terraform Provider Registry. 
For more information on how to get started view the [documentation](https://www.terraform.io/docs/providers/oci/index.html) 
and [setup guide](https://www.terraform.io/docs/providers/oci/guides/version-3-upgrade.html).

* [Documentation](https://www.terraform.io/docs/providers/oci/index.html)
* [OCI forums](https://cloudcustomerconnect.oracle.com/resources/9c8fa8f96f/summary)
* [Github issues](https://github.com/terraform-providers/terraform-provider-oci/issues)
* [Troubleshooting](https://www.terraform.io/docs/providers/oci/guides/guides/troubleshooting.html)

## Clone the Module
Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-quickstart/oci-arch-data-flow.git
    cd oci-arch-data-flow
    ls

## Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Secondly, create a `terraform.tfvars` file and populate with the following information:

```
# Authentication
tenancy_ocid         = "<tenancy_ocid>"
user_ocid            = "<user_ocid>"
fingerprint          = "<finger_print>"
private_key_path     = "<pem_private_key_path>"

# SSH Keys
ssh_public_key  = "<public_ssh_key_path>"

# Region
region = "<oci_region>"

# Compartment
compartment_ocid = "<compartment_ocid>"

````

For your convenience, there is a template file included.

Deploy:

    terraform init
    terraform plan
    terraform apply

## Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy it:

    terraform destroy

## Architecture

![](./images/architecture-analyze-logs.png.png)


## Reference Architecture

- [Store and analyze your on-premises logs in Oracle Cloud Infrastructure](https://docs.oracle.com/en/solutions/analyze-logs/#GUID-6A904B1A-498A-4552-98E2-EA30B6328C4C)
