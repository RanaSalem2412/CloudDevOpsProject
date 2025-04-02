output "instance_id" {
  value = aws_instance.app_server[*].id  
}

output "instance_public_ip" {
  value = aws_instance.app_server[*].public_ip  
}

output "sns_topic_arn" {
  value = aws_sns_topic.alarm_notifications.arn
}
