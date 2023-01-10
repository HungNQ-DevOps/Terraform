# ------- CloudWatch Logs groups -------

resource "aws_cloudwatch_log_group" "TaskDefinition_Log_Group" {
  name              = "/ecs/${var.project_name}-log-group"
  retention_in_days = 30
}

# ------- Task definition -------

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.project_name}-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = null
  }
  memory                   = var.ecs_task_definition.memory
  cpu                      = var.ecs_task_definition.cpu
  execution_role_arn       = var.ecs_task_definition.execution_role_arn
  task_role_arn            = var.ecs_task_definition.task_role_arn
  
  container_definitions = <<DEFINITION
  [
    {
      "logConfiguration": {
          "logDriver": "awslogs",
          "secretOptions": null,
          "options": {
            "awslogs-group": "/ecs/${var.project_name}-log-group",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
        },
      "cpu": 0,
      "name": "${var.project_name}-container",
      "image": "${var.ecs_task_definition.image}",
      "networkMode": "awsvpc",
      "portMappings": [
        {
          "containerPort": ${var.ecs_task_definition.container_port},
          "hostPort": ${var.ecs_task_definition.container_port},
          "protocol": "tcp"
        }
      ]
    }
  ]
  DEFINITION
}