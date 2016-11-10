#credentials
variable "credentials_file" {}

variable "credentials_profile" {}

variable "aws_region" {}

#Tags
variable "project_name" {
  type    = "string"
  default = "prj"
}

variable "service_name" {
  type    = "string"
  default = "sn"
}

variable "environment" {
  type    = "string"
  default = "env"
}

#EC2
variable "key_name" {
  type    = "string"
  default = "Keypair_name"
}

variable "instance_type" {
  type    = "string"
  default = "t2.small"
}

variable "detailed_monitoring" {
  type    = "string"
  default = "true"
}

#security groups
variable "i_sg_ports" {
  type    = "list"
  default = ["22", "80", "8081"]
}

variable "elb_sg_ports" {
  type    = "list"
  default = ["80", "443"]
}

variable "elb_sg_open_cidr" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

#Networking
#those variable should be fed at aggregation level
variable "vpcID" {
  type    = "string"
  default = ""
}

variable "vpcCIDR" {
  type    = "string"
  default = ""
}

#use: aws ec2 describe-availability-zones --region eu-west-1
variable "AZList" {
  type    = "list"
  default = []
}

variable "sbnPrivate" {
  type    = "list"
  default = []
}

variable "sbnPublic" {
  type    = "list"
  default = []
}

#ELB
variable "http_listener_elb_port" {}

variable "http_listener_elb_proto" {}

variable "http_listener_i_port" {}

variable "http_listener_i_proto" {}

variable "https_listener_elb_port" {}

variable "https_listener_elb_proto" {}

variable "https_listener_i_port" {}

variable "https_listener_i_proto" {}

variable "https_cert_arn" {}

variable "elb_healthcheck_target" {}

variable elb_health_check_grace_period {}

variable elb_health_check_type {}

variable "elb_internal" {}

#ASG
variable "asg_min" {}

variable "asg_max" {}

variable "asg_desired" {}

variable "aws_ami" {
  type    = "map"
  default = {}
}

#files
variable "user_data" {
  type    = "string"
  default = ""
}

variable "iam_role" {
  type    = "string"
  default = ""
}

variable "iam_role_policy" {
  type    = "string"
  default = " "
}

#Stickiness
variable "sticky_http_enable" {
  type    = "string"
  default = "false"
}

variable "sticky_https_enable" {
  type    = "string"
  default = "false"
}

#sns alarms
variable "alarms_enable" {
  type    = "string"
  default = "false"
}

#Scaling policies
variable "scaling_metric_name" {
  type    = "string"
  default = "CPUUtilization"
}

variable "scaling_metric_namespace" {
  type    = "string"
  default = "AWS/EC2"
}

variable "scaling_statistic" {
  type    = "string"
  default = "average"
}

variable "scaling_up_enable" {
  type    = "string"
  default = "false"
}

variable "scaling_up_period" {
  type    = "string"
  default = "120"
}

variable "scaling_up_threshold" {
  type    = "string"
  default = "80"
}

variable "scaling_down_enable" {
  type    = "string"
  default = "false"
}

variable "scaling_down_period" {
  type    = "string"
  default = "120"
}

variable "scaling_down_threshold" {
  type    = "string"
  default = "40"
}
