data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "${var.project_name}-vpc"
  cidr = "172.16.0.0/16"

  azs                     = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets          = ["172.16.0.0/24", "172.16.10.0/24"]
  enable_dns_support      = true
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true
  enable_nat_gateway      = false
  enable_vpn_gateway      = false
  single_nat_gateway      = false


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rtb"
  }
}

resource "aws_route_table_association" "public_associations" {
  count          = length(module.vpc.public_subnets)
  subnet_id      = module.vpc.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}
