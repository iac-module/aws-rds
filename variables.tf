# Custom variables
variable "create" {
  description = "Whether to create an rds"
  type        = bool
  default     = true
}
#https://github.com/terraform-aws-modules/terraform-aws-rds/blob/v6.5.2/variables.tf

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "instance_use_identifier_prefix" {
  description = "Determines whether to use `identifier` as is or create a unique identifier beginning with `identifier` as the specified prefix"
  type        = bool
  default     = false
}

variable "custom_iam_instance_profile" {
  description = "RDS custom iam instance profile"
  type        = string
  default     = null
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = null
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), 'gp3' (new generation of general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'gp2' if not. If you specify 'io1' or 'gp3' , you must also include a value for the 'iops' parameter"
  type        = string
  default     = null
}

variable "storage_throughput" {
  description = "Storage throughput value for the DB instance. See `notes` for limitations regarding this variable for `gp3`"
  type        = number
  default     = null
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used. Be sure to use the full ARN, not a key alias."
  type        = string
  default     = null
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate"
  type        = string
  default     = null
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  type        = string
  default     = null
}

variable "replica_mode" {
  description = "Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specified"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = bool
  default     = false
}

variable "domain" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
  type        = string
  default     = null
}

variable "domain_auth_secret_arn" {
  description = "(Optional, but required if domain_fqdn is provided) The ARN for the Secrets Manager secret with the self managed Active Directory credentials for the user joining the domain. Conflicts with domain and domain_iam_role_name."
  type        = string
  default     = null
}

variable "domain_dns_ips" {
  description = "(Optional, but required if domain_fqdn is provided) The IPv4 DNS IP addresses of your primary and secondary self managed Active Directory domain controllers. Two IP addresses must be provided. If there isn't a secondary domain controller, use the IP address of the primary domain controller for both entries in the list. Conflicts with domain and domain_iam_role_name."
  type        = list(string)
  default     = null
}

variable "domain_fqdn" {
  description = "The fully qualified domain name (FQDN) of the self managed Active Directory domain. Conflicts with domain and domain_iam_role_name."
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "(Required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
  default     = null
}

variable "domain_ou" {
  description = "(Optional, but required if domain_fqdn is provided) The self managed Active Directory organizational unit for your DB instance to join. Conflicts with domain and domain_iam_role_name."
  type        = string
  default     = null
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier_prefix" {
  description = "The name which is prefixed to the final snapshot on cluster destroy"
  type        = string
  default     = "final"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "password" {
  description = <<EOF
  Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.
  The password provided will not be used if `manage_master_user_password` is set to true.
  EOF
  type        = string
  default     = null
  sensitive   = true
}

variable "manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager"
  type        = bool
  default     = true
}

variable "master_user_secret_kms_key_id" {
  description = <<EOF
  The key ARN, key ID, alias ARN or alias name for the KMS key to encrypt the master user password secret in Secrets Manager.
  If not specified, the default KMS key for your Amazon Web Services account is used.
  EOF
  type        = string
  default     = null
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' or `gp3`. See `notes` for limitations regarding this variable for `gp3`"
  type        = number
  default     = null
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero"
  type        = string
  default     = null
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled"
  type        = string
  default     = "rds-monitoring-role"
}

variable "monitoring_role_use_name_prefix" {
  description = "Determines whether to use `monitoring_role_name` as is or create a unique identifier beginning with `monitoring_role_name` as the specified prefix"
  type        = bool
  default     = false
}

variable "monitoring_role_description" {
  description = "Description of the monitoring IAM role"
  type        = string
  default     = null
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = bool
  default     = false
}

variable "monitoring_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the monitoring IAM role"
  type        = string
  default     = null
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = null
}

variable "blue_green_update" {
  description = "Enables low-downtime updates using RDS Blue/Green deployments."
  type        = map(string)
  default     = {}
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = null
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = null
}

variable "restore_to_point_in_time" {
  description = "Restore to a point in time (MySQL is NOT supported)"
  type        = map(string)
  default     = null
}

variable "s3_import" {
  description = "Restore from a Percona Xtrabackup in S3 (only MySQL is supported)"
  type        = map(string)
  default     = null
}

variable "dedicated_log_volume" {
  description = "Use a dedicated log volume (DLV) for the DB instance. Requires Provisioned IOPS."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "db_instance_tags" {
  description = "Additional tags for the DB instance"
  type        = map(string)
  default     = {}
}

variable "db_option_group_tags" {
  description = "Additional tags for the DB option group"
  type        = map(string)
  default     = {}
}

variable "db_parameter_group_tags" {
  description = "Additional tags for the  DB parameter group"
  type        = map(string)
  default     = {}
}

variable "db_subnet_group_tags" {
  description = "Additional tags for the DB subnet group"
  type        = map(string)
  default     = {}
}

# DB subnet group
variable "create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = null
}

variable "db_subnet_group_use_name_prefix" {
  description = "Determines whether to use `subnet_group_name` as is or create a unique name beginning with the `subnet_group_name` as the prefix"
  type        = bool
  default     = true
}

variable "db_subnet_group_description" {
  description = "Description of the DB subnet group to create"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

# DB parameter group
variable "create_db_parameter_group" {
  description = "Whether to create a database parameter group"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = null
}

variable "parameter_group_use_name_prefix" {
  description = "Determines whether to use `parameter_group_name` as is or create a unique name beginning with the `parameter_group_name` as the prefix"
  type        = bool
  default     = true
}

variable "parameter_group_description" {
  description = "Description of the DB parameter group to create"
  type        = string
  default     = null
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = null
}

variable "parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default     = []
}

# DB option group
variable "create_db_option_group" {
  description = "Create a database option group"
  type        = bool
  default     = true
}

variable "option_group_name" {
  description = "Name of the option group"
  type        = string
  default     = null
}

variable "option_group_use_name_prefix" {
  description = "Determines whether to use `option_group_name` as is or create a unique name beginning with the `option_group_name` as the prefix"
  type        = bool
  default     = true
}

variable "option_group_description" {
  description = "The description of the option group"
  type        = string
  default     = null
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = null
}

variable "options" {
  description = "A list of Options to apply"
  type        = any
  default     = []
}

variable "create_db_instance" {
  description = "Whether to create a database instance"
  type        = bool
  default     = true
}

variable "timezone" {
  description = "Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information"
  type        = string
  default     = null
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS and Collations and Character Sets for Microsoft SQL Server for more information. This can only be set on creation"
  type        = string
  default     = null
}

variable "nchar_character_set_name" {
  description = "The national character set is used in the NCHAR, NVARCHAR2, and NCLOB data types for Oracle instances. This can't be changed."
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)"
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = map(string)
  default     = {}
}

variable "option_group_timeouts" {
  description = "Define maximum timeout for deletion of `aws_db_option_group` resource"
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Valid values are `7`, `731` (2 years) or a multiple of `31`"
  type        = number
  default     = 7
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
  default     = true
}

variable "network_type" {
  description = "The type of network stack to use"
  type        = string
  default     = null
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports`"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain CloudWatch logs for the DB instance"
  type        = number
  default     = 7
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_skip_destroy" {
  description = "Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state"
  type        = bool
  default     = null
}

variable "cloudwatch_log_group_class" {
  description = "Specified the log class of the log group. Possible values are: STANDARD or INFREQUENT_ACCESS"
  type        = string
  default     = null
}

variable "putin_khuylo" {
  description = "Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo!"
  type        = bool
  default     = true
}

################################################################################
# DB Instance Role Association
################################################################################

variable "db_instance_role_associations" {
  description = "A map of DB instance supported feature name to role association ARNs."
  type        = map(any)
  default     = {}
}

################################################################################
# Managed Secret Rotation
################################################################################

variable "manage_master_user_password_rotation" {
  description = "Whether to manage the master user password rotation. By default, false on creation, rotation is managed by RDS. Setting this value to false after previously having been set to true will disable automatic rotation."
  type        = bool
  default     = false
}

variable "master_user_password_rotate_immediately" {
  description = "Specifies whether to rotate the secret immediately or wait until the next scheduled rotation window."
  type        = bool
  default     = null
}

variable "master_user_password_rotation_automatically_after_days" {
  description = "Specifies the number of days between automatic scheduled rotations of the secret. Either automatically_after_days or schedule_expression must be specified."
  type        = number
  default     = null
}

variable "master_user_password_rotation_duration" {
  description = "The length of the rotation window in hours. For example, 3h for a three hour window."
  type        = string
  default     = null
}

variable "master_user_password_rotation_schedule_expression" {
  description = "A cron() or rate() expression that defines the schedule for rotating your secret. Either automatically_after_days or schedule_expression must be specified."
  type        = string
  default     = null
}



################################################################################
# S3 Audit log
################################################################################

variable "s3_audit_log" {
  description = "S3 bucket for RDS audit log"
  type = object({
    create                                 = optional(bool, true)
    tags                                   = optional(map(string), {})
    bucket_pattern_name                    = optional(string, "rds-s3-audit")
    iam_policy_prefix_name                 = optional(string, "rds-s3-audit")
    iam_policy_description                 = optional(string, "Policy for s3 audit log")
    iam_role_prefix_name                   = optional(string, "rds-s3-audit")
    iam_role_description                   = optional(string, "Role for s3 audit log ")
    iam_role_role_permissions_boundary_arn = optional(string, "")
  })
  default = {
    create = false
  }
}
################################################################################
# Random Password
################################################################################
variable "generate_password" {
  description = "Enable random password and store it to SSM ParamStore"
  type        = bool
  default     = "true"
}

variable "override_special" {
  description = "The special for random"
  type        = string
  default     = "()-_"
}

variable "password_length" {
  description = "The length for password"
  type        = number
  default     = 16
  validation {
    condition     = var.password_length > 15
    error_message = "The password must be longer then 16 character"
  }
}

variable "min_numeric" {
  description = "Minimum number of numeric characters in the result"
  type        = number
  default     = 2
  validation {
    condition     = var.min_numeric > 1
    error_message = "Minimum number of numeric must be over 1"
  }
}


variable "ssm_paramstore_path" {
  description = "The path in SSM ParamStore for storing password"
  type        = string
  default     = "/db/rds/master/password"
}

################################################################################
# Security Group
################################################################################
variable "security_group_create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

#variable "target_security_group_id" {
#  type        = list(string)
#  description = <<-EOT
#    The ID of an existing Security Group to which Security Group rules will be assigned.
#    The Security Group's name and description will not be changed.
#    Not compatible with `inline_rules_enabled` or `revoke_rules_on_delete`.
#    If not provided (the default), this module will create a security group.
#    EOT
#  default     = []
#  validation {
#    condition     = length(var.target_security_group_id) < 2
#    error_message = "Only 1 security group can be targeted."
#  }
#}

variable "security_group_name" {
  type        = list(string)
  description = <<-EOT
    The name to assign to the security group. Must be unique within the VPC.
    If not provided, will be derived from the `null-label.context` passed in.
    If `create_before_destroy` is true, will be used as a name prefix.
    EOT
  default     = []
  validation {
    condition     = length(var.security_group_name) < 2
    error_message = "Only 1 security group name can be provided."
  }
}


variable "security_group_description" {
  type        = string
  description = <<-EOT
    The description to assign to the created Security Group.
    Warning: Changing the description causes the security group to be replaced.
    EOT
  default     = "Managed by Terraform"
}

variable "create_before_destroy" {
  type        = bool
  description = <<-EOT
    Set `true` to enable terraform `create_before_destroy` behavior on the created security group.
    We only recommend setting this `false` if you are importing an existing security group
    that you do not want replaced and therefore need full control over its name.
    Note that changing this value will always cause the security group to be replaced.
    EOT
  default     = true
}

variable "preserve_security_group_id" {
  type        = bool
  description = <<-EOT
    When `false` and `create_before_destroy` is `true`, changes to security group rules
    cause a new security group to be created with the new rules, and the existing security group is then
    replaced with the new one, eliminating any service interruption.
    When `true` or when changing the value (from `false` to `true` or from `true` to `false`),
    existing security group rules will be deleted before new ones are created, resulting in a service interruption,
    but preserving the security group itself.
    **NOTE:** Setting this to `true` does not guarantee the security group will never be replaced,
    it only keeps changes to the security group rules from triggering a replacement.
    See the README for further discussion.
    EOT
  default     = false
}

variable "allow_all_egress" {
  type        = bool
  description = <<-EOT
    A convenience that adds to the rules specified elsewhere a rule that allows all egress.
    If this is false and no egress rules are specified via `rules` or `rule-matrix`, then no egress will be allowed.
    EOT
  default     = true
}

variable "rules" {
  type        = list(any)
  description = <<-EOT
    A list of Security Group rule objects. All elements of a list must be exactly the same type;
    use `rules_map` if you want to supply multiple lists of different types.
    The keys and values of the Security Group rule objects are fully compatible with the `aws_security_group_rule` resource,
    except for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique
    and known at "plan" time.
    To get more info see the `security_group_rule` [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule).
    ___Note:___ The length of the list must be known at plan time.
    This means you cannot use functions like `compact` or `sort` when computing the list.
    EOT
  default     = []
}

variable "rules_map" {
  type        = any
  description = <<-EOT
    A map-like object of lists of Security Group rule objects. All elements of a list must be exactly the same type,
    so this input accepts an object with keys (attributes) whose values are lists so you can separate different
    types into different lists and still pass them into one input. Keys must be known at "plan" time.
    The keys and values of the Security Group rule objects are fully compatible with the `aws_security_group_rule` resource,
    except for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique
    and known at "plan" time.
    To get more info see the `security_group_rule` [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule).
    EOT
  default     = {}
}

variable "rule_matrix" {
  # rule_matrix is independent of the `rules` input.
  # Only the rules specified in the `rule_matrix` object are applied to the subjects specified in `rule_matrix`.
  # The `key` attributes are optional, but if supplied, must be known at plan time or else
  # you will get an error from Terraform. If the value is triggering an error, just omit it.
  #  Schema:
  #  {
  #    # these top level lists define all the subjects to which rule_matrix rules will be applied
  #    key = unique key (for stability from plan to plan)
  #    source_security_group_ids = list of source security group IDs to apply all rules to
  #    cidr_blocks = list of ipv4 CIDR blocks to apply all rules to
  #    ipv6_cidr_blocks = list of ipv6 CIDR blocks to apply all rules to
  #    prefix_list_ids = list of prefix list IDs to apply all rules to
  #    self = # set "true" to apply the rules to the created or existing security group
  #
  #    # each rule in the rules list will be applied to every subject defined above
  #    rules = [{
  #      key = "unique key"
  #      type = "ingress"
  #      from_port = 433
  #      to_port = 433
  #      protocol = "tcp"
  #      description = "Allow HTTPS ingress"
  #    }]

  type        = any
  description = <<-EOT
    A convenient way to apply the same set of rules to a set of subjects. See README for details.
    EOT
  default     = []
}

variable "security_group_create_timeout" {
  type        = string
  description = "How long to wait for the security group to be created."
  default     = "10m"
}

variable "security_group_delete_timeout" {
  type        = string
  description = <<-EOT
    How long to retry on `DependencyViolation` errors during security group deletion from
    lingering ENIs left by certain AWS services such as Elastic Load Balancing.
    EOT
  default     = "15m"
}

variable "revoke_rules_on_delete" {
  type        = bool
  description = <<-EOT
    Instruct Terraform to revoke all of the Security Group's attached ingress and egress rules before deleting
    the security group itself. This is normally not needed.
    EOT
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the Security Group will be created."
}

variable "inline_rules_enabled" {
  type        = bool
  description = <<-EOT
    NOT RECOMMENDED. Create rules "inline" instead of as separate `aws_security_group_rule` resources.
    See [#20046](https://github.com/hashicorp/terraform-provider-aws/issues/20046) for one of several issues with inline rules.
    See [this post](https://github.com/hashicorp/terraform-provider-aws/pull/9032#issuecomment-639545250) for details on the difference between inline rules and rule resources.
    EOT
  default     = false
}

##################################
# Route53 record
##################################

variable "route_53_record" {
  description = "Configure route53 record"
  type = object({
    enabled      = optional(bool, false),
    zone_name    = string,
    private_zone = optional(bool, true)
    name         = string,
    type         = optional(string, "CNAME"),
    ttl          = optional(number, 3600),
    tags         = optional(map(string), {})
  })
  default = {
    enable    = false
    zone_name = ""
    name      = ""
  }
}
