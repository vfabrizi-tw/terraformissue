credentials_file		= "/.awstandf/credentials"
credentials_profile		= "tandf"
aws_region			= "eu-west-1"

#keep those short, some resource have maximum name lenght of 32 char.
project_name			= "pyramid"
service_name			= "cogsrv"
environment			= "dev"


key_name			= "vincenzofabrizi_key_tw"
instance_type			= "t2.small"
detailed_monitoring		= "true"

i_sg_ports			= ["22", "80", "8081"]
elb_sg_ports			= ["80", "443"]
elb_sg_open_cidr		= ["0.0.0.0/0"]


http_listener_elb_port		= "80"
http_listener_elb_proto		= "HTTP"
http_listener_i_port		= "80"
http_listener_i_proto		= "HTTP"

https_listener_elb_port		= "443"
https_listener_elb_proto	= "HTTPS"
https_listener_i_port		= "80"
https_listener_i_proto		= "HTTP"
https_cert_arn 			= "arn:aws:acm:eu-west-1:826238753827:certificate/317732a2-0e1d-49d0-9108-c758cbe6c2b2"

elb_healthcheck_target		= "HTTP:80/"
elb_health_check_grace_period 	= "300"
elb_health_check_type 		= "ELB"
elb_internal			= "false"

#ASG
asg_min				= "1"
asg_max				= "5"
asg_desired			= "1"

AZList				= ["eu-west-1a", "eu-west-1b"]
vpcCIDR				= "10.0.0.0/16"
vpcID				= "vpc-a697fcc2"
sbnPrivate			= ["subnet-0e2c606a", "subnet-46e29830"]
sbnPublic			= ["subnet-0d2c6069", "subnet-47e29831"]


aws_ami = {
	us-east-1 		= "ami-fce3c696"
	us-west-1 		= "ami-06116566"
	us-west-2 		= "ami-9abea4fb"
	eu-west-1 		= "ami-f95ef58a"
	eu-central-1 		= "ami-87564feb"
	ap-northeast-1 		= "ami-a21529cc"
	ap-northeast-2 		= "ami-09dc1267"
	ap-southeast-1 		= "ami-25c00c46"
	ap-southeast-2 		= "ami-6c14310f"
}

#files
user_data = ""
iam_role = ""
iam_role_policy = ""

#Stickiness
sticky_http_enable = "true"
sticky_https_enable = "true"

#Alarms
alarms_enable = "true"

#Scaling policies
scaling_metric_name = ""
scaling_metric_namespace = ""
scaling_statistic = ""
scaling_up_enable = "true"
scaling_up_period = ""
scaling_up_threshold = ""
scaling_down_enable = "true"
scaling_down_period = ""
scaling_down_threshold = ""
