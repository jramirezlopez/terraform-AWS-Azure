
# Módulo Auto Scaling Group con EC2 cifrado en reposo

resource "aws_launch_template" "techdiversa_lt" {
  name_prefix   = "techdiversa-lt-"
  image_id      = var.ami
  instance_type = var.instance_type

  # Volumen EBS encriptado
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 8
      volume_type = "gp2"
      encrypted   = true  # Habilita cifrado en reposo
    }
  }

  # Grupo de seguridad
  vpc_security_group_ids = [aws_security_group.launch_sg.id]

  # Script de inicialización
  user_data = base64encode(var.user_data)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "techdiversa_asg" {
  name                      = "techdiversa-asg"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = [aws_lb_target_group.techdiversa_tg.arn]
  launch_template {
    id      = aws_launch_template.techdiversa_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "TechDiversaASGInstance"
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 60
}

resource "aws_security_group" "launch_sg" {
  name        = "techdiversa-launch-sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Target group para el ALB
resource "aws_lb_target_group" "techdiversa_tg" {
  name     = "techdiversa-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}
