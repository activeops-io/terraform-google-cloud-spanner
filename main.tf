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
  name         = coalesce(var.spanner_instance_name, "span01")
  display_name = coalesce(var.spanner_instance_display_name, "spanner01")
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
  name     = each.key
}

resource "google_spanner_database_iam_binding" "spanner-database-binding" {
  depends_on = [google_spanner_database.spanner-database]
  for_each   = var.spanner_databases
  instance   = google_spanner_instance.spanner.name
  database   = each.key
  role       = each.value["role"]

  members = each.value["members"]
}
