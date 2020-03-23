#### Shared Variables ###
variable "vpc-id" {}
variable "subnet-id-1" {}
variable "subnet-id-2" {}
variable "alb_name" {}
variable "alb_sg_id" {}
variable "alb_green_listener_arn" {}
variable "alb_blue_listener_arn" {}
#variable "ecs-cluster-name" {}
variable "alb_dns_name" {}
data "aws_caller_identity" "current" {}

variable "ecs-cluster-name" {
    default = "test-ecs-cluster"
}
variable "service_name" {
  default = "BlueGreenDemo"
}
variable "desired_task_number" {
  default = 1
}
variable "docker_container_port" {
  default = 8080
}
variable "domain_prefix" {
  default = "bgapp"
}
variable "domain_name" {
  default = "grasserver.club"
}
variable "wait_time" {
  default = 5
}
