# resource "aws_key_pair" "demo_terraform_kp" {
#   key_name = "demo_terraform_kp"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrxvie2sRz48+j1ikd4xWxOK2k50RhfTa8VoRjoZDQcjCLYWE3kc7jzNPRqxtUOfEe/wV+t6ZBTZe+QJeOsZoWocFcyPufCStwjBw5+3JibeZxRO1BeEZYBdEJDOUZjj7+ntboWor7PVF3uOYFB1HeBsE82GcibwSCe0kGBnk9DsQPt8t8b3ljG1/fjGXReKmbvq77Ggz+ud3g/I7Uf+mDfqXum+597SCn1S1Rof9MmOP/7emEyZbc6V7moK5+jBvoflKCDa+9p9xl+al/GGse9LkYE9SeQXZMPadu2Z7jdOWD773vEnx5XAxrIx5Ov3p9RxDUFq4iiw9GvnZ1d2wdBSHUrqAlW3ZHRoNXwGgPzt5VYCRCWJqX1FIabWRM/Naxk1oQjL5qMFIO2AZlySR0w8ZG/u41h/77K1KUjDrKIzCWJXs78+uvhndB7Ysq9qzIPFHFhmr3xyR/E2hyvu4n9aHNaIxuwIBzbve+zf84YyOQ/JEsdY4nfqf3YppSSRc= nqhung6@cmcglobal.vn"
# }

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"       # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }

  tags = {
    "Owner" = var.owner
  }
}