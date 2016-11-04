resource "aws_elb" "elb-stack" {
    name = "elb-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    internal = "${var.elb_internal}"
    subnets = ["${var.sbnPublic}"]

    listener {
        instance_port = "${var.https_listener_i_port}"
        instance_protocol = "${var.https_listener_i_proto }"
        lb_port = "${var.https_listener_elb_port}"
        lb_protocol = "${var.https_listener_elb_proto}"
        ssl_certificate_id = "${var.https_cert_arn}"
    } 

    listener {
        instance_port = "${var.http_listener_i_port}"
        instance_protocol = "${var.http_listener_i_proto}"
        lb_port = "${var.http_listener_elb_port }"
        lb_protocol = "${var.http_listener_elb_proto}"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 3
        timeout = 3
        target = "${var.elb_healthcheck_target}"
        interval = 10
    }

    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400
    security_groups = ["${aws_security_group.sg_elb-stack.id}"]

    tags {
        "Id" = "elb-${var.project_name}-${var.project_name}-${var.environment}-${var.uuid}"
        "Service" = "${var.service_name}"
        "Project" = "${var.project_name}"
        "Environment" = "${var.environment}"
        "Uuid" = "${var.uuid}"
    }
}
