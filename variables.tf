/*
 * Copyright ActiveOps 2021
 * For license information consult LICENSE
 * All rights reserved
 * Contact: mark@activeops.io / eric@activeops.io
*/

variable "project_name" {
  type        = string
  description = "Project name in GCP"
  default     = ""
}

variable "region" {
  type        = string
  description = "Region to deploy in"
  default     = ""
}

variable "spanner_instance_name" {
  type        = string
  description = "Spanner Instance Name"
  default     = ""
}

variable "spanner_instance_display_name" {
  type        = string
  description = "Spanner Instance Display Name"
  default     = ""
}

variable "spanner_instance_config" {
  type        = string
  description = "Spanner Instance configuration"
  default     = ""
}

variable "spanner_nodes" {
  type        = number
  description = "Number of Spanner nodes to create"
  default     = 1
}

variable "spanner_admins" {
  type        = list(string)
  description = "List of Spanner DB admins"
  default     = [] # user:hd@stargazer.com.sg
}

variable "spanner_databases" {
  type = map(object({
    role    = string
    members = list(string)
  }))
  description = "List of databases for Spanner, including IAM role binding"
  default     = {}
}
