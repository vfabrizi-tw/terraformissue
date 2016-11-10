resource "aws_cloudwatch_metric_alarm" "cpu-load-up" {
  alarm_name          = "cwm-${var.service_name}-up-${var.project_name}-${var.environment}-${var.uuid}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg-stack.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.scale-up.arn}"]
  count         = "${ replace(replace(var.scaling_up_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}

resource "aws_cloudwatch_metric_alarm" "cpu-load-down" {
  alarm_name          = "cwm-${var.service_name}-down-${var.project_name}-${var.environment}-${var.uuid}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "40"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.asg-stack.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.scale-down.arn}"]
  count         = "${ replace(replace(var.scaling_down_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}

resource "aws_autoscaling_policy" "scale-up" {
  name                   = "asgpol-${var.service_name}-scale-up-${var.project_name}-${var.environment}-${var.uuid}"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.asg-stack.name}"
  count                  = "${ replace(replace(var.scaling_up_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}

resource "aws_autoscaling_policy" "scale-down" {
  name                   = "asgpol-${var.service_name}-scale-down-${var.project_name}-${var.environment}-${var.uuid}"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.asg-stack.name}"
  count                  = "${ replace(replace(var.scaling_down_enable, "/[Ff]alse/", "0"), "/[Tt]rue/", "1") }"
}
