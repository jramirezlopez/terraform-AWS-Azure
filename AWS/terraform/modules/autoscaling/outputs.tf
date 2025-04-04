
output "launch_sg_id" {
  value = aws_security_group.launch_sg.id
}

output "target_group_arn" {
  value = aws_lb_target_group.techdiversa_tg.arn
}
