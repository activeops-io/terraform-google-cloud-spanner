Terraform Module: Google Cloud Spanner
======================================

A Terraform module for [Google Cloud](https://cloud.google.com) that simplifies the creation of a Spanner instance and databases.

## Basic usage

```hcl-terraform
module spanner_instance {
  source = "github.com/activeops-io/terraform-google-cloud-spanner"
  project_name = "my-project"
  region = "asia-southeast1"
  spanner_instance_config = "regional-asia-southeast1"
  spanner_nodes = 1
  spanner_admins = ["mark@activesops.io"]
  spanner_databses = {}
  service_accounts = {} #must exist
}
```

## Inputs

| Name                    | Description                                                                                                       | Type         | Default                 | Required |
|-------------------------|-------------------------------------------------------------------------------------------------------------------|--------------|-------------------------|----------|
| project_name            | Name of the project                                                                                               | string       |                         | Yes      |
| region                  | Region where the spanner instance needs to be hosted                                                              | string       |                         | Yes      |
| spanner_instance_config | Configuration for the Spanner instance                                                                            | string       |                         | Yes      |
| spanner_nodes           | Number of nodes for this Spanner instance                                                                         | number       | 1                       | Yes      |
| spanner_databases       | Map object with the database name and reference to user,role and service account                                  | map(object)  |                         | Yes      |
| spanner_admins          | Users that get assigned the role databaseAdmin in Spanner                                                         | list(string) | `[]`                    | Yes      |
| service_accounts        | List of service accounts userd by the Spanner DBs                                                                 | map(object)  | `null`                  | Yes      |
