resource "aws_instance" "app_server" {
  count                 = 2  
  ami                   = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name              = var.key_name

  tags = {
    Name = var.instance_name
  }
}
resource "aws_sns_topic" "alarm_notifications" {
  name = "ec2-cloudwatch-alarms"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = "ranasalem923@gmail.com"  
}

resource "aws_cloudwatch_log_group" "ec2_logs" {
  name              = "/aws/ec2/${var.instance_name}"
  retention_in_days = 7  
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count             = length(aws_instance.app_server)  
  alarm_name        = "HighCPUAlarm-${aws_instance.app_server[count.index].id}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 80
  alarm_description  = "This metric monitors high CPU utilization"
  alarm_actions      = [aws_sns_topic.alarm_notifications.arn]
  dimensions = {
    InstanceId = aws_instance.app_server[count.index].id
  }
}

