provider "aws" {
  # project = "init-terraform"
  # shared_credentials_files = ["/home/nqhung6/.aws/credentials"]
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
}

# module "aws_s3" {
#   source = "./modules/s3"
# }