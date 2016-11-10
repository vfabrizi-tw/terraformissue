data "template_file" "user_data_file" {
  template = "${file("${path.module}/userdata.sh")}"
  count    = "${ replace(replace(var.user_data, "/.+/", "0"), "/^$/", "1") }"
}

data "template_file" "user_data_var" {
  template = "${var.user_data}"
  count    = "${ replace(replace(var.user_data, "/.+/", "1"), "/^$/", "0") }"
}

data "template_file" "iam_role_file" {
  template = "${file("${path.module}/iam_role.json")}"
  count    = "${ replace(replace(var.iam_role, "/.+/", "0"), "/^$/", "1") }"
}

data "template_file" "iam_role_var" {
  template = "${var.iam_role}"
  count    = "${ replace(replace(var.iam_role, "/.+/", "1"), "/^$/", "0") }"
}

data "template_file" "iam_role_policy_file" {
  template = "${file("${path.module}/iam_role_policy.json")}"
  count    = "${ replace(replace(var.iam_role_policy, "/.+/", "0"), "/^$/", "1") }"
}

data "template_file" "iam_role_policy_var" {
  template = "${var.iam_role_policy}"
  count    = "${ replace(replace(var.iam_role_policy, "/.+/", "1"), "/^$/", "0") }"
}
