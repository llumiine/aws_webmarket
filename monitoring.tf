# c'est une alerte CloudWatch sur le CPU des instances de prod(>70%)
resource "aws_cloudwatch_metric_alarm" "prod_cpu_haut" {
  alarm_name          = "Alerte-CPU-Production-${var.project_name}"
  alarm_description   = "Alerte CPU élevée pour les instances de prod (ASG)"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.prod_cpu_alarm_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.prod_cpu_alarm_period
  statistic           = "Average"
  threshold           = var.prod_cpu_alarm_threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.prod_web.name
  }

  tags = {
    Nom           = "Alerte CPU Prod"
    Environnement = "Production"
    Projet        = var.project_name
  }
}