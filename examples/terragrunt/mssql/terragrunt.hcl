include {
  path = find_in_parent_folders()
}
iam_role = local.account_vars.iam_role

terraform {
  source = "git::https://github.com/iac-module/aws-rds.git//?ref=v1.1.0"
}

dependency "vpc" {
  config_path = find_in_parent_folders("core/vpc/main")
}
dependency "eks" {
  config_path = find_in_parent_folders("eks/cluster-0001")
}

locals {
  common_tags  = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region       = local.region_vars.locals.aws_region
  name         = "${basename(dirname(get_terragrunt_dir()))}-${basename(get_terragrunt_dir())}"
}

inputs = {
  identifier                  = "${local.account_vars.locals.env}-${local.name}"
  engine                      = "sqlserver-se"
  engine_version              = "16.00.4125.3.v1"
  family                      = "sqlserver-se-16.0" # DB parameter group
  major_engine_version        = "16.00"             # DB option group
  instance_class              = "db.m6i.large"
  allocated_storage           = 20
  storage_type                = "gp3"
  max_allocated_storage       = 30
  manage_master_user_password = false
  generate_password           = true
  ssm_paramstore_path         = "/${local.account_vars.locals.business_unit}/${local.account_vars.locals.env_name}/rds/${local.name}/password"
  publicly_accessible         = true
  maintenance_window          = "Sun:00:00-Sun:03:00"
  backup_window               = "03:00-06:00"
  username                    = "${local.account_vars.locals.owner}_${local.account_vars.locals.env}_agent"
  port                        = 1433

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = dependency.vpc.outputs.database_subnets

  backup_retention_period = 21
  skip_final_snapshot     = false
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "rds-${local.name}-monitoring"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "Description for monitoring role"
  monitoring_role_permissions_boundary  = local.account_vars.locals.permissions_boundary

  license_model = "license-included"

  #use kms
  kms_key_id                      = "arn:aws:kms:us-east-2:XXXX:key/000000-000000"
  performance_insights_kms_key_id = "arn:aws:kms:us-east-2:XXX:key/000000-000000"
  master_user_secret_kms_key_id   = "arn:aws:kms:us-east-2:XXX:key/200000-000000"

  #enable logs
  enabled_cloudwatch_logs_exports = ["agent", "error"]
  create_cloudwatch_log_group     = true
  publicly_accessible             = false
  parameters = [
    {
      name         = "rds.sqlserver_audit"
      value        = "fedramp_hipaa"
      apply_method = "pending-reboot"
    },
    {
      name         = "rds.force_ssl "
      value        = "1"
      apply_method = "pending-reboot"
    }
  ]
  multi_az             = true
  db_subnet_group_name = dependency.vpc.outputs.database_subnet_group_name

  #Security Group
  vpc_id              = dependency.vpc.outputs.vpc_id
  security_group_name = ["rds-${local.name}"]
  rule_matrix = [
    {
      key                       = dependency.eks.outputs.cluster_name
      source_security_group_ids = [dependency.eks.outputs.node_security_group_id]
      rules = [
        {
          key         = dependency.eks.outputs.cluster_name
          type        = "ingress"
          from_port   = 1433
          to_port     = 1433
          protocol    = "tcp"
          description = "For connection from EKS cluster ${dependency.eks.outputs.cluster_name} node_groups"
        }
      ]
    }
  ]
  timeouts = {
    create = "60m"
    delete = "2h"
  }
  s3_audit_log = {
    create                                 = true
    iam_role_role_permissions_boundary_arn = local.account_vars.locals.permissions_boundary
    tags                                   = local.common_tags.locals.common_tags
  }
  route_53_record = {
    enabled      = true
    zone_name    = "${local.account_vars.locals.env_name}.local"
    private_zone = true
    name         = local.name
  }
  tags = local.common_tags.locals.common_tags
}
