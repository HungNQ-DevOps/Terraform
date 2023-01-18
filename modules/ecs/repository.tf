resource "aws_ecr_repository" "ecr" {
    name = "${var.project_name}-repository"
    image_tag_mutability = "${var.ecr_repository.image_tag_mutability}"
    encryption_configuration {
        encryption_type = "${var.ecr_repository.encryption_type}"
    }
    image_scanning_configuration {
        scan_on_push = "${var.ecr_repository.image_scanning_configuration}"
    }
    tags = {
        "Owner" = "nqhung"
    }
}