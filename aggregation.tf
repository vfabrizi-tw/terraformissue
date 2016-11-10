data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    key    = "common/network/terraform.tfstate"
    bucket = "vfabrizi-trs"
    region = "eu-west-1"
  }
}

module "stack_ext_ssl" {
  source = "../../modules/stack_ext_ssl"

  credentials_file    = "${var.credentials_file}"
  credentials_profile = "${var.credentials_profile}"
  aws_region          = "${var.aws_region}"

  project_name = "${var.project_name}"
  service_name = "${var.service_name}"
  environment  = "${var.environment}"
  uuid         = "${random_id.stack.dec}"

  aws_ami             = "${var.aws_ami}"
  instance_type       = "${var.instance_type}"
  key_name            = "${var.key_name}"
  detailed_monitoring = "${var.detailed_monitoring}"

  i_sg_ports       = "${var.i_sg_ports}"
  elb_sg_ports     = "${var.elb_sg_ports}"
  elb_sg_open_cidr = "${var.elb_sg_open_cidr}"

  asg_min     = "${var.asg_min}"
  asg_max     = "${var.asg_max}"
  asg_desired = "${var.asg_desired}"

  http_listener_elb_port  = "${var.http_listener_elb_port}"
  http_listener_elb_proto = "${var.http_listener_elb_proto}"
  http_listener_i_port    = "${var.http_listener_i_port}"
  http_listener_i_proto   = "${var.http_listener_i_proto}"

  https_listener_elb_port  = "${var.https_listener_elb_port}"
  https_listener_elb_proto = "${var.https_listener_elb_proto}"
  https_listener_i_port    = "${var.https_listener_i_port}"
  https_listener_i_proto   = "${var.https_listener_i_proto}"
  https_cert_arn           = "${var.https_cert_arn}"

  elb_healthcheck_target        = "${var.elb_healthcheck_target}"
  elb_health_check_grace_period = "${var.elb_health_check_grace_period}"
  elb_health_check_type         = "${var.elb_health_check_type}"
  elb_internal                  = "${var.elb_internal}"

  vpcCIDR         = "${data.terraform_remote_state.network.vpcCIDR}"
  vpcID           = "${data.terraform_remote_state.network.vpcID}"
  AZList          = ["${data.terraform_remote_state.network.AZList}"]
  sbnPublic       = ["${data.terraform_remote_state.network.sbnPublic}"]
  sbnPrivate      = ["${data.terraform_remote_state.network.sbnPrivate}"]
  user_data       = "${element(concat(data.template_file.user_data_var.*.rendered, data.template_file.user_data_file.*.rendered), 0)}"
  iam_role        = "${element(concat(data.template_file.iam_role_var.*.rendered, data.template_file.iam_role_file.*.rendered), 0)}"
  iam_role_policy = "${element(concat(data.template_file.iam_role_policy_var.*.rendered, data.template_file.iam_role_policy_file.*.rendered), 0)}"

  scaling_up_enable   = "${var.scaling_up_enable}"
  scaling_down_enable = "${var.scaling_down_enable}"

  sticky_http_enable  = "${var.sticky_http_enable}"
  sticky_https_enable = "${var.sticky_https_enable}"

  alarms_enable = "${var.alarms_enable}"
}
