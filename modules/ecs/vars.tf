variable "region" {
  type = string
}

#############################
#          CLUSTER
#############################
variable "project_name" {
  type = string
  default = "nodejs-autodeploy"
}

#############################
#      TASK DEFINITION
#############################

variable "ecs_task_definition" {
  type = map(string)
  default = {
    "execution_role_arn" = "arn:aws:iam::508855084738:role/ecsTaskExecutionRole"
    "task_role_arn" = "arn:aws:iam::508855084738:role/ecsTaskExecutionRole"
    "memory" = "512"
    "cpu" = "256"
    "image" = "node:16-alpine"
    "container_port" = "5000"
  }
}

#############################
#          SERVICE
#############################

variable "ecs_service" {
  type = map(string)
  default = {
    "desired_tasks" = 1
  }
}