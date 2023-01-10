resource "aws_s3_bucket" "demo-terraform" {
    bucket = "demo-terraform-12312"
    tags = {
        Type = "demo"
    }
}