

include {
  path = find_in_parent_folders()
}
iam_role = local.account_vars.iam_role

terraform {
  source = "git::https://github.com/iac-module/aws-rds.git//?ref=v1.0.1"
}

dependency "vpc" {
  config_path = find_in_parent_folders("core/vpc/${local.account_vars.locals.env_name}")
}

dependency "ecs_service_backend" {
  config_path = find_in_parent_folders("ecs/services/backend-0001")
}

locals {
  common_tags  = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region       = local.region_vars.locals.aws_region
  name         = basename(get_terragrunt_dir())
}

inputs = {
  identifier                  = local.name
  engine                      = "postgres"
  engine_version              = "16.1"
  family                      = "postgres16"
  major_engine_version        = "16"
  instance_class              = "db.t3.micro"
  allocated_storage           = 20
  storage_type                = "gp3"
  max_allocated_storage       = 30
  manage_master_user_password = false
  generate_password           = true
  ssm_paramstore_path         = "/${local.account_vars.locals.owner}/${local.account_vars.locals.env_name}/rds/${local.name}/password"
  publicly_accessible         = true
  maintenance_window          = "Sun:00:00-Sun:03:00"
  backup_window               = "03:00-06:00"
  db_name                     = "${local.account_vars.locals.owner}_${local.account_vars.locals.env}_db"
  username                    = "${local.account_vars.locals.owner}_${local.account_vars.locals.env}_agent"
  port                        = 5432

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = dependency.vpc.outputs.database_subnets

  backup_retention_period = 7
  skip_final_snapshot     = false
  deletion_protection     = false


  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "rds-${local.name}-monitoring"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "Description for monitoring role"

  multi_az             = false
  db_subnet_group_name = dependency.vpc.outputs.database_subnet_group_name

  #Security Group
  vpc_id              = dependency.vpc.outputs.vpc_id
  security_group_name = ["rds-${local.name}"]
  rule_matrix = [
    {
      key                       = dependency.ecs_service_backend.outputs.name
      source_security_group_ids = [dependency.ecs_service_backend.outputs.security_group_id]
      rules = [
        {
          key         = dependency.ecs_service_backend.outputs.name
          type        = "ingress"
          from_port   = 5432
          to_port     = 5432
          protocol    = "tcp"
          description = "For connection from ecs service ${dependency.ecs_service_backend.outputs.name}"
        }
      ]
    }
  ]
  route_53_record = {
    enabled      = true
    zone_name    = "${local.account_vars.locals.env_name}.local"
    private_zone = true
    name         = local.name
  }
  tags = local.common_tags.locals.common_tags
}
