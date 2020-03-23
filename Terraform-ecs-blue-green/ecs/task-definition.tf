data "aws_region" "current" {}
#data "aws_caller_identity" "current"{}

resource "aws_ecs_task_definition" "task-sample-definition" {
    family                = "${var.service_name}"
    network_mode          = "bridge"
    container_definitions = "${file("./ecs/task-definition.json")}"
}

resource "aws_s3_bucket_object" "codedeploy_appspec" {
  bucket = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  key    = "appspec.json"
  content = <<EOF
  {
  "version": 1,
  "Resources": [
    {
      "TargetService": {
        "Type": "AWS::ECS::Service",
        "Properties": {
          "TaskDefinition": "${aws_ecs_task_definition.task-sample-definition.arn}",
          "LoadBalancerInfo": {
            "ContainerName": "${var.service_name}",
            "ContainerPort": ${var.docker_container_port}
          }
        }
      }
    }
  ]
}
EOF
}