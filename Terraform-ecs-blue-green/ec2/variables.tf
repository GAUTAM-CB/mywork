//----------------------------------------------------------------------
// Shared Variables
//----------------------------------------------------------------------

variable "vpc-id" {}
variable "subnet-id-1" {}
variable "subnet-id-2" {}
variable "security-group-id" {}
variable "ecs-cluster-name" {}
variable "ecs-instance-role-name" {}
variable "ecs-instance-profile-name" {}
variable "ecs-key-pair-name" {}
#variable "alb_name" {}
variable "ecs_blue_target_group_arn" {}
variable "ecs_green_target_group_arn" {}

//----------------------------------------------------------------------
// Application Load Balancer Variables
//----------------------------------------------------------------------

variable "load-balancer-name" {
    description = "The name for the autoscaling group for the cluster."
    default     = "ecs-load-balancer"
}


//----------------------------------------------------------------------
// Launch Configuration Variables
//----------------------------------------------------------------------

variable "launch-configuration-name" {
    description = "The name for the autoscaling group for the cluster."
    default = "test-ecs-launch-configuration"
}

variable "image-id" {
    description = "The name for the autoscaling group for the cluster."
    default = "ami-d61027ad"
}

variable "instance-type" {
    description = "The name for the autoscaling group for the cluster."
    default = "t2.small"
}

//----------------------------------------------------------------------
// Autoscaling Group Variables
//----------------------------------------------------------------------

variable "autoscaling-group-name" {
    description = "The name for the autoscaling group for the cluster."
    default     = "test-ecs-asg"
}

variable "max-instance-size" {
    description = "The name for the autoscaling group for the cluster."
    default     = 3
}

variable "min-instance-size" {
    description = "The name for the autoscaling group for the cluster."
    default     = 1
}

variable "desired-capacity" {
    description = "The name for the autoscaling group for the cluster."
    default     = 1
}

