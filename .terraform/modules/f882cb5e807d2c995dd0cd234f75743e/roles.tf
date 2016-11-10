resource "aws_iam_instance_profile" "stack-profile" {
  depends_on = ["aws_iam_role.role"]
  roles      = ["${aws_iam_role.role.name}"]

  #That's because Terraform can't wait for the profile to be created.
  provisioner "local-exec" {
    command = "sleep 20"
  }
}

resource "aws_iam_role_policy" "policy" {
  name   = "pol-${var.project_name}-${var.environment}"
  role   = "${aws_iam_role.role.id}"
  policy = "${var.iam_role_policy}"
}

resource "aws_iam_role" "role" {
  assume_role_policy = "${var.iam_role}"
}
