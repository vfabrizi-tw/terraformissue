resource "random_id" "stack" {
  keepers = {
    project_name = "${var.project_name}"
    service_name = "${var.service_name}"
    environment  = "${var.environment}"
  }

  byte_length = 2
}
