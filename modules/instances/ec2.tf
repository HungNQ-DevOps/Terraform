# init instance
resource "aws_instance" "demo-Terraform-01" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    vpc_security_group_ids = [
      aws_security_group.allow_ssh.id,
      aws_security_group.public_web.id
    ]
    ### Optional configuration
    subnet_id = aws_subnet.public_subnet.id
    key_name = aws_key_pair.kp.key_name
    user_data = file("modules/instances/scripts/scripts-ec2.sh")
    # root_block_device {
    #   volume_type = "standard"
    #   volume_size = "10"
    # }
    tags = {
        Name = "demo-terraform-01"
        Type = "demo"
    }
}