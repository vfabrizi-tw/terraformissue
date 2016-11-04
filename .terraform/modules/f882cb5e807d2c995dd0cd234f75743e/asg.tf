resource "aws_autoscaling_group" "asg-stack" {
    #availability_zones = ["${var.AZList}"]
    name = "asg-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    vpc_zone_identifier =  ["${var.sbnPrivate}"]


    max_size = "${var.asg_max}"
    min_size = "${var.asg_min}"
    desired_capacity = "${var.asg_desired}"
  
    force_delete = true
    launch_configuration = "${aws_launch_configuration.lc-stack.name}"

    load_balancers = ["${aws_elb.elb-stack.name}"]
    enabled_metrics = ["GroupTerminatingInstances", "GroupMaxSize",
                        "GroupDesiredCapacity", "GroupPendingInstances",
                        "GroupInServiceInstances", "GroupMinSize",
                        "GroupTotalInstances", "GroupStandbyInstances"]

    health_check_grace_period = "${var.elb_health_check_grace_period}"
    health_check_type = "${var.elb_health_check_type}"

    tag {
        key = "Name"
        value = "i-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
        propagate_at_launch = "true"
    }

    tag {
        key = "Id"
        value = "i-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
        propagate_at_launch = "true"
    }

    tag {
        key = "Project"
        value = "${var.project_name}"
        propagate_at_launch = "true"
    }

    tag {
       key = "Service"
        value = "${var.service_name}"
        propagate_at_launch = "true"
    }

    tag {
        key = "Environment"
        value = "${var.environment}"
        propagate_at_launch = "true"
    }

    tag {
        key = "UUID"
        value = "${var.uuid}"
        propagate_at_launch = "true"
    }

}

resource "aws_launch_configuration" "lc-stack" {
    #name = "lc-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    image_id = "${var.aws_ami[var.aws_region]}"
    instance_type = "${var.instance_type}"
    security_groups = ["${aws_security_group.sg_i-stack.id}"]
    user_data = "${var.user_data}"
    iam_instance_profile = "${aws_iam_instance_profile.stack-profile.name}"
    key_name = "${var.key_name}"
    enable_monitoring = "${var.detailed_monitoring}"
}

