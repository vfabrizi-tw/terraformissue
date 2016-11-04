resource "aws_sns_topic" "alerts" {
    name = "sns-topic-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    display_name = "sns-topic-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    count = "${ replace(replace(var.alarms_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}

resource "aws_cloudwatch_metric_alarm" "elb_minimum_hosts" {
    alarm_name = "cwm-minimum-hosts-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    comparison_operator = "LessThanThreshold"
    evaluation_periods = "1"
    metric_name = "HealthyHostCount"
    namespace = "AWS/ELB"
    period = "60"
    statistic = "Minimum"
    threshold = "1"
    dimensions {
        LoadBalancerName ="${aws_elb.elb-stack.name}"
    }
    alarm_description = "Alert if no servers in ELB group are healthy"
    alarm_actions = ["${aws_sns_topic.alerts.arn}"]
    count = "${ replace(replace(var.alarms_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}

resource "aws_cloudwatch_metric_alarm" "elb_desired_hosts" {
    alarm_name = "cwm-desired-hosts-${var.service_name}-${var.project_name}-${var.environment}-${var.uuid}"
    comparison_operator = "LessThanThreshold"
    evaluation_periods = "1"
    metric_name = "HealthyHostCount"
    namespace = "AWS/ELB"
    period = "60"
    statistic = "Minimum"
    threshold = "${var.asg_desired}"
    dimensions {
        LoadBalancerName ="${aws_elb.elb-stack.name}"
    }
    alarm_description = "Alert if less than the desired number of servers in ELB group are healthy"
    alarm_actions = ["${aws_sns_topic.alerts.arn}"]
    count = "${ replace(replace(var.alarms_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}
