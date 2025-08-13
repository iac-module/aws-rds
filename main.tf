module "rds" {
  source                               = "git::https://github.com/terraform-aws-modules/terraform-aws-rds.git?ref=9122d19b2ff1e9114ae328fec988715cdd56bf5f" #v6.12.0
  identifier                           = var.identifier
  instance_use_identifier_prefix       = var.instance_use_identifier_prefix
  custom_iam_instance_profile          = var.custom_iam_instance_profile
  allocated_storage                    = var.allocated_storage
  storage_type                         = var.storage_type
  storage_throughput                   = var.storage_throughput
  storage_encrypted                    = var.storage_encrypted
  kms_key_id                           = var.kms_key_id
  replicate_source_db                  = var.replicate_source_db
  license_model                        = var.license_model
  replica_mode                         = var.replica_mode
  iam_database_authentication_enabled  = var.iam_database_authentication_enabled
  domain                               = var.domain
  domain_auth_secret_arn               = var.domain_auth_secret_arn
  domain_dns_ips                       = var.domain_dns_ips
  domain_fqdn                          = var.domain_fqdn
  domain_iam_role_name                 = var.domain_iam_role_name
  domain_ou                            = var.domain_ou
  engine                               = var.engine
  engine_version                       = var.engine_version
  engine_lifecycle_support             = var.engine_lifecycle_support
  skip_final_snapshot                  = var.skip_final_snapshot
  snapshot_identifier                  = var.snapshot_identifier
  copy_tags_to_snapshot                = var.copy_tags_to_snapshot
  final_snapshot_identifier_prefix     = var.final_snapshot_identifier_prefix
  instance_class                       = var.instance_class
  db_name                              = var.db_name
  username                             = var.username
  password                             = var.generate_password ? random_password.master_password.result : var.password
  manage_master_user_password          = var.manage_master_user_password
  master_user_secret_kms_key_id        = var.master_user_secret_kms_key_id
  port                                 = var.port
  vpc_security_group_ids               = var.security_group_create ? concat([module.sg[0].id], var.vpc_security_group_ids) : var.vpc_security_group_ids
  availability_zone                    = var.availability_zone
  multi_az                             = var.multi_az
  iops                                 = var.iops
  publicly_accessible                  = var.publicly_accessible
  monitoring_interval                  = var.monitoring_interval
  monitoring_role_arn                  = var.monitoring_role_arn
  monitoring_role_name                 = var.monitoring_role_name
  monitoring_role_use_name_prefix      = var.monitoring_role_use_name_prefix
  monitoring_role_description          = var.monitoring_role_description
  create_monitoring_role               = var.create_monitoring_role
  monitoring_role_permissions_boundary = var.monitoring_role_permissions_boundary
  database_insights_mode               = var.database_insights_mode
  allow_major_version_upgrade          = var.allow_major_version_upgrade
  auto_minor_version_upgrade           = var.auto_minor_version_upgrade
  apply_immediately                    = var.apply_immediately
  maintenance_window                   = var.maintenance_window
  blue_green_update                    = var.blue_green_update
  backup_retention_period              = var.backup_retention_period
  backup_window                        = var.backup_window
  restore_to_point_in_time             = var.restore_to_point_in_time
  s3_import                            = var.s3_import
  dedicated_log_volume                 = var.dedicated_log_volume
  tags                                 = var.tags
  db_instance_tags                     = var.db_instance_tags
  db_option_group_tags                 = var.db_option_group_tags
  db_parameter_group_tags              = var.db_parameter_group_tags
  db_subnet_group_tags                 = var.db_subnet_group_tags
  create_db_subnet_group               = var.create_db_subnet_group
  db_subnet_group_name                 = var.db_subnet_group_name
  db_subnet_group_use_name_prefix      = var.db_subnet_group_use_name_prefix
  db_subnet_group_description          = var.db_subnet_group_description
  subnet_ids                           = var.subnet_ids
  create_db_parameter_group            = var.create_db_parameter_group
  parameter_group_name                 = var.parameter_group_name
  parameter_group_use_name_prefix      = var.parameter_group_use_name_prefix
  parameter_group_description          = var.parameter_group_description
  family                               = var.family
  parameters                           = var.parameters
  parameter_group_skip_destroy         = var.parameter_group_skip_destroy
  create_db_option_group               = var.create_db_option_group
  option_group_name                    = var.option_group_name
  option_group_use_name_prefix         = var.option_group_use_name_prefix
  option_group_description             = var.option_group_description
  major_engine_version                 = var.major_engine_version
  options = var.s3_audit_log.create ? concat([
    {
      option_name = "SQLSERVER_AUDIT"

      option_settings = [
        {
          name  = "S3_BUCKET_ARN"
          value = module.rds_s3[0].s3_bucket_arn
        },
        {
          name  = "IAM_ROLE_ARN"
          value = module.rds_s3_iam_role[0].iam_role_arn
        }
      ]
    }], var.options

  ) : var.options
  option_group_skip_destroy                              = var.option_group_skip_destroy
  create_db_instance                                     = var.create_db_instance
  timezone                                               = var.timezone
  character_set_name                                     = var.character_set_name
  nchar_character_set_name                               = var.nchar_character_set_name
  enabled_cloudwatch_logs_exports                        = var.enabled_cloudwatch_logs_exports
  timeouts                                               = var.timeouts
  option_group_timeouts                                  = var.option_group_timeouts
  deletion_protection                                    = var.deletion_protection
  performance_insights_enabled                           = var.performance_insights_enabled
  performance_insights_retention_period                  = var.performance_insights_retention_period
  performance_insights_kms_key_id                        = var.performance_insights_kms_key_id
  max_allocated_storage                                  = var.max_allocated_storage
  ca_cert_identifier                                     = var.ca_cert_identifier
  delete_automated_backups                               = var.delete_automated_backups
  network_type                                           = var.network_type
  upgrade_storage_config                                 = var.upgrade_storage_config
  create_cloudwatch_log_group                            = var.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days                 = var.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_kms_key_id                        = var.cloudwatch_log_group_kms_key_id
  cloudwatch_log_group_skip_destroy                      = var.cloudwatch_log_group_skip_destroy
  cloudwatch_log_group_class                             = var.cloudwatch_log_group_class
  cloudwatch_log_group_tags                              = var.cloudwatch_log_group_tags
  putin_khuylo                                           = var.putin_khuylo
  db_instance_role_associations                          = var.db_instance_role_associations
  manage_master_user_password_rotation                   = var.manage_master_user_password_rotation
  master_user_password_rotate_immediately                = var.master_user_password_rotate_immediately
  master_user_password_rotation_automatically_after_days = var.master_user_password_rotation_automatically_after_days
  master_user_password_rotation_duration                 = var.master_user_password_rotation_duration
  master_user_password_rotation_schedule_expression      = var.master_user_password_rotation_schedule_expression
}

resource "random_password" "master_password" {
  length           = var.password_length
  special          = true
  numeric          = true
  min_numeric      = var.min_numeric
  override_special = var.override_special
}

resource "aws_ssm_parameter" "secret" {
  count       = var.generate_password ? 1 : 0
  name        = var.ssm_paramstore_path
  description = "The master password for RDS ${var.identifier}"
  type        = "SecureString"
  key_id      = var.master_user_secret_kms_key_id
  value       = random_password.master_password.result
  tags        = var.tags
}

locals {
  bucket_name = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-${var.s3_audit_log.bucket_pattern_name}-${var.identifier}"
}

module "rds_s3" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git///?ref=8a0b697adfbc673e6135c70246cff7f8052ad95a" #v4.1.2
  count  = var.s3_audit_log.create ? 1 : 0

  bucket                   = local.bucket_name
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  owner                    = {}
  tags                     = var.s3_audit_log.tags
}

module "rds_s3_iam_policy" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=ada8d1f9b373359931a7e14de5c580dabafc8e42" #v5.40.0
  count  = var.s3_audit_log.create ? 1 : 0

  name        = "${var.s3_audit_log.iam_policy_prefix_name}-${var.identifier}"
  path        = "/"
  description = var.s3_audit_log.iam_policy_description
  policy      = data.aws_iam_policy_document.rds_s3_policy[0].json
  tags        = var.tags
}

module "rds_s3_iam_role" {
  source            = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role?ref=ada8d1f9b373359931a7e14de5c580dabafc8e42" #v5.40.0
  count             = var.s3_audit_log.create ? 1 : 0
  role_requires_mfa = false
  role_name         = "${var.s3_audit_log.iam_role_prefix_name}-${var.identifier}"
  role_description  = var.s3_audit_log.iam_role_description

  create_role                   = true
  role_permissions_boundary_arn = var.s3_audit_log.iam_role_role_permissions_boundary_arn
  custom_role_policy_arns = [
    module.rds_s3_iam_policy[0].arn
  ]
  number_of_custom_role_policy_arns = 1
  trusted_role_services = [
    "rds.amazonaws.com"
  ]
  tags = var.s3_audit_log.tags
}
