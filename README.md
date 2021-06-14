Terraform Module: Google Cloud Spanner
======================================

A Terraform module for [Google Cloud](https://cloud.google.com) that simplifies the creation of a Spanner instance and databases.

## Basic usage

```hcl-terraform
module spanner_instance {
  source                  = "github.com/activeops-io/terraform-google-cloud-spanner"
  project_name            = "my-project"
  region                  = "asia-southeast1"
  spanner_name            = "span01"
  spanner_name            = "spanner01" 
  spanner_instance_config = "regional-asia-southeast1"
  spanner_nodes           = 1
  spanner_admins          = ["user:mark@activesops.io"]
  spanner_databases       = {    
    spanner-db01 = {
      role = "roles/spanner.databaseUser"
      sa_name = "span01-db01-sa"
    }
}
```

## Inputs

| Name                    | Description                                                                                                       | Type         | Default                 | Required |
|-------------------------|-------------------------------------------------------------------------------------------------------------------|--------------|-------------------------|----------|
| project_name            | Name of the project                                                                                               | string       |                         | Yes      |
| region                  | Region where the Spanner instance needs to be hosted                                                              | string       |                         | Yes      |
| spanner_name            | Name of the Spanner instance                                                                                      | string       |                         | Yes      |
| spanner_display_name    | Display Name of the Spanner instance                                                                              | string       |                         | Yes      |
| spanner_instance_config | Configuration for the Spanner instance                                                                            | string       |                         | Yes      |
| spanner_nodes           | Number of nodes for this Spanner instance                                                                         | number       | 1                       | Yes      |
| spanner_admins          | Users that get assigned the role databaseAdmin in Spanner                                                         | list(string) | `[]`                    | Yes      |
| spanner_databases       | Map object with the database name and reference to service account and role                                       | map(object)  |                         | Yes      |
