resource "aws_app_cookie_stickiness_policy" "stickyhtttp" {
    name = "sticky-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    load_balancer = "${aws_elb.elb-stack.name}"
    lb_port = "${var.http_listener_elb_port}"
    cookie_name = "${var.service_name}${var.project_name}${var.environment}${var.uuid}"
    count = "${ replace(replace(var.sticky_http_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}

resource "aws_app_cookie_stickiness_policy" "stickyhttps" {
    name = "sticky-https-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    load_balancer = "${aws_elb.elb-stack.name}"
    lb_port = "${var.https_listener_elb_port}"
    cookie_name = "${var.service_name}https${var.project_name}${var.environment}${var.uuid}"
    count = "${ replace(replace(var.sticky_https_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}
