provider "aws" {
  region = "us-east-1"
}

module "iam" {
    source = "./iam"
}

module "vpc" {
    source = "./vpc"
}

module "ec2" {
    source = "./ec2"

    vpc-id                      = "${module.vpc.id}"
    security-group-id           = "${module.vpc.security-group-id}"
    subnet-id-1                 = "${module.vpc.subnet1-id}"
    subnet-id-2                 = "${module.vpc.subnet2-id}"
    ecs-instance-role-name      = "${module.iam.ecs-instance-role-name}"
    ecs-instance-profile-name   = "${module.iam.ecs-instance-profile-name}"
    ecs-cluster-name            = "${var.ecs-cluster-name}"
    ecs-key-pair-name           = "${var.ecs-key-pair-name}"
    #alb_name                    = "${var.alb_name}"
    ### Test code ###
    ecs_blue_target_group_arn   = "${module.ecs.ecs_blue_target_group_arn}"
    ecs_green_target_group_arn  = "${module.ecs.ecs_green_target_group_arn}"
}

module "ecs" {
    source = "./ecs"

    alb_sg_id                   = "${module.ec2.alb_sg_id}"
    vpc-id                      = "${module.vpc.id}"
    subnet-id-1                 = "${module.vpc.subnet1-id}"
    subnet-id-2                 = "${module.vpc.subnet2-id}"
    alb_name                    = "${module.ec2.alb_name}"
    alb_green_listener_arn      = "${module.ec2.alb_green_listener_arn}"
    alb_blue_listener_arn       = "${module.ec2.alb_blue_listener_arn}"
    #ecs-cluster-name           = "${var.ecs-cluster-name}"
    alb_dns_name                = "${module.ec2.alb_dns_name}"
}

module "task_scaling" {
  source = "./task_scaling"
  cluster_name = "${module.ecs.cluster_name}"
  service_name = "${module.ecs.service_name}"
}
