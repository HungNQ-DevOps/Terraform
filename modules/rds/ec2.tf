# init instance
resource "aws_instance" "bastion_host" {
    ami = var.instance.ami
    instance_type = var.instance.type
    vpc_security_group_ids = [
      aws_security_group.allow_ssh_bastion_host.id,
    ]
    ### Optional configuration
    subnet_id = aws_default_subnet.default_1a.id
    key_name = aws_key_pair.kp.key_name
    tags = {
        "Owner" = var.owner
    }
}