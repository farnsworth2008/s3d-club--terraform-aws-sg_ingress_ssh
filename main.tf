module "name" {
  source = "github.com/s3d-club/terraform-external-name?ref=v0.1.15"

  context = join("-", [var.name_prefix, "ingress-ssh"])
  path    = path.module
  tags    = var.tags
}

resource "aws_security_group" "this" {
  description = "Allow SSH inbound traffic"
  name_prefix = module.name.prefix
  tags        = module.name.tags
  vpc_id      = var.vpc_id

  ingress {
    cidr_blocks      = var.cidrs
    description      = "SSH Access"
    from_port        = 22
    ipv6_cidr_blocks = var.cidr6s
    protocol         = "tcp"
    to_port          = 22
  }
}
