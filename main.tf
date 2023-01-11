provider "aws" {
  # project = "Practice terraform!"
  profile = "nqhung"
  region = var.region
}

# module "instances" {
#   source = "./modules/instances"
#   region = var.region
# }

# module "ecs" {
#   source = "./modules/ecs"
#   region = var.region
# }

module "rds" {
  source = "./modules/rds"
  owner = var.owner
  username = var.username
  password = var.password
  # terraform plan -var-file=credentails.tfvars
}

# module "aws_s3" {
#   source = "./modules/s3"
# }