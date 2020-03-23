resource "aws_alb" "ecs-load-balancer" {
  name            = "${var.load-balancer-name}"
  internal        = false
  security_groups = ["${var.security-group-id}"]
  subnets         = ["${var.subnet-id-1}", "${var.subnet-id-2}"]
  tags {
    Name          = "${var.load-balancer-name}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_alb_target_group" "alb_tg_80" {
#   name     = "${var.load-balancer-name}-TG-80"
#   port     = "80"
#   protocol = "HTTP"
#   vpc_id   = "${var.vpc-id}"

#   tags {
#     Name   = "${var.load-balancer-name}-TG-80"
#   }
#   depends_on = ["aws_alb.ecs-load-balancer"]
# }

# resource "aws_alb_target_group" "alb_tg_8080" {
#   name     = "${var.load-balancer-name}-TG-8080"
#   port     = "80"
#   protocol = "HTTP"
#   vpc_id   = "${var.vpc-id}"

#   tags {
#     Name   = "${var.load-balancer-name}-TG-8080"
#   }
#   depends_on = ["aws_alb.ecs-load-balancer"]
# }

resource "aws_alb_listener" "alb_listener_80" {
  load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action  {
    target_group_arn = "${var.ecs_blue_target_group_arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "alb_listener_8080" {
  load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
  port              = "8080"
  protocol          = "HTTP"

  default_action  {
    target_group_arn = "${var.ecs_green_target_group_arn}"
    type             = "forward"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.load-balancer-name}-alb-sg"
  description = "Allows ports 80 and 8080 for alb"
  vpc_id      = "${var.vpc-id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "alb_arn" {
  value = "${aws_alb.ecs-load-balancer.arn}"
}

output "alb_sg_id" {
  value = "${aws_security_group.alb_sg.id}"
}

output "alb_dns_name" {
  value = "${aws_alb.ecs-load-balancer.dns_name}"
}

output "alb_blue_listener_arn" {
  value = "${aws_alb_listener.alb_listener_80.arn}"
}

output "alb_green_listener_arn" {
  value = "${aws_alb_listener.alb_listener_8080.arn}"
}

output "alb_name" {
  value = "${aws_alb.ecs-load-balancer.name}"
}