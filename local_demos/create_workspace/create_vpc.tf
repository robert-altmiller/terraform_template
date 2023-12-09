data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name = local.vars.aws.vpc.name
  cidr = local.vars.aws.vpc.cidr_block
  azs  = data.aws_availability_zones.available.names
  tags = local.vars.aws.vpc.tags

  enable_dns_hostnames = local.vars.aws.vpc.enable_dns_hostnames
  enable_nat_gateway   = local.vars.aws.vpc.enable_nat_gateway
  single_nat_gateway   = local.vars.aws.vpc.single_nat_gateway
  create_igw           = local.vars.aws.vpc.create_igw

  public_subnets = [cidrsubnet(local.vars.aws.vpc.cidr_block, 3, 0)]
  private_subnets = [cidrsubnet(local.vars.aws.vpc.cidr_block, 3, 1),
  cidrsubnet(local.vars.aws.vpc.cidr_block, 3, 2)]

  manage_default_security_group = local.vars.aws.vpc.manage_default_security_group
  default_security_group_name   = local.vars.aws.vpc.default_security_group_name

  default_security_group_egress = [{
    cidr_blocks = "0.0.0.0/0"
  }]

  default_security_group_ingress = [{
    description = "Allow all internal TCP and UDP"
    self        = true
  }]
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.2.0"
  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.vpc.default_security_group_id]

  endpoints = {
    s3 = {
      service      = "s3"
      service_type = "Gateway"
      route_table_ids = flatten([
        module.vpc.private_route_table_ids,
      module.vpc.public_route_table_ids])
      tags = local.vars.aws.vpc_endpoints.s3_endpoints_tags
    }
  }
  tags = local.vars.aws.vpc_endpoints.tags
}

resource "databricks_mws_networks" "this" {
  provider           = databricks.mws
  account_id         = local.vars.dbricks.conn.account_id
  network_name       = local.vars.dbricks.ws.mws_network_name
  security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
}