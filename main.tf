/*
 * Copyright ActiveOps 2021
 * For license information consult LICENSE
 * All rights reserved
 * Contact: mark@activeops.io / eric@activeops.io
*/

/*------------------------------------------------------------------
   Spanner - Instance Config
------------------------------------------------------------------*/
resource "google_spanner_instance" "span01" {
  config       = var.spanner_instance_config
  name         = format("%s-span01", var.project_name)
  display_name = format("%s spanner 01", var.project_name)
  num_nodes    = var.spanner_nodes
}

resource "google_spanner_instance_iam_binding" "span01-binding" {
  instance = google_spanner_instance.span01.name
  role     = "roles/spanner.databaseAdmin"

  members = var.spanner_admins
}

/*------------------------------------------------------------------
   Spanner - DB Config - span-db01
------------------------------------------------------------------*/
resource "google_spanner_database" "span01-databases" {
  for_each = var.spanner_databases
  instance = google_spanner_instance.span01.name
  name     = format("%s-%s", var.project_name, each.key)
}

resource "google_spanner_database_iam_binding" "span01-db01-binding" {
  for_each = var.spanner_databases
  instance = google_spanner_instance.span01.name
  database = google_spanner_database.span01-databases[each.key].name
  role     = each.value["role"]

  members = [
    format("serviceAccount:%s@%s.iam.gserviceaccount.com", each.value["account_name"], var.project_name),
  ]
}
