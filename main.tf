module "name" {
  source = "github.com/s3d-club/terraform-external-name?ref=v0.1.10"

  context = join("-", [var.name_prefix, "ingress-ssh"])
  path    = path.module
  tags    = var.tags
}

resource "aws_security_group" "this" {
  description = "Allow SSH inbound traffic"
  name_prefix = module.name.prefix
  tags        = module.name.tags
  vpc_id      = var.vpc

  ingress {
    cidr_blocks      = var.cidr
    description      = "SSH Access"
    from_port        = 22
    ipv6_cidr_blocks = var.cidr6
    protocol         = "tcp"
    to_port          = 22
  }
}
