/*
 * Copyright ActiveOps 2021
 * For license information consult LICENSE
 * All rights reserved
 * Contact: mark@activeops.io / eric@activeops.io
*/

/*------------------------------------------------------------------
   Spanner Instance Config
------------------------------------------------------------------*/
resource "google_spanner_instance" "spanner" {
  config       = var.spanner_instance_config
  name         = var.spanner_instance_name
  display_name = var.spanner_instance_display_name
  num_nodes    = var.spanner_nodes
}

resource "google_spanner_instance_iam_binding" "spanner-admin-binding" {
  instance = google_spanner_instance.spanner.name
  role     = "roles/spanner.databaseAdmin"
  members  = var.spanner_admins
}

/*------------------------------------------------------------------
   Spanner Database Config
------------------------------------------------------------------*/
resource "google_spanner_database" "spanner-database" {
  for_each = var.spanner_databases
  instance = google_spanner_instance.spanner.name
  name     = [each.key]
}

resource "google_spanner_database_iam_binding" "spanner-database-binding" {
  for_each = var.spanner_databases
  instance = google_spanner_instance.spanner.name
  database = [each.key]
  role     = each.value["role"]

  members  = [
    format("serviceAccount:%s@%s.iam.gserviceaccount.com", each.value["sa_name"], var.project_name),
  ]
}
