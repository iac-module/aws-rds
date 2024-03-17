output "enhanced_monitoring_iam_role_name" {
  description = "The name of the monitoring role"
  value       = try(module.rds.enhanced_monitoring_iam_role_name, "")
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the monitoring role"
  value       = try(module.rds.enhanced_monitoring_iam_role_arn, "")
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = try(module.rds.db_instance_address, "")
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = try(module.rds.db_instance_arn, "")
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = try(module.rds.db_instance_availability_zone, "")
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = try(module.rds.db_instance_endpoint, "")
}

output "db_listener_endpoint" {
  description = "Specifies the listener connection endpoint for SQL Server Always On"
  value       = try(module.rds.db_listener_endpoint, "")
}

output "db_instance_engine" {
  description = "The database engine"
  value       = try(module.rds.db_instance_engine, "")
}

output "db_instance_engine_version_actual" {
  description = "The running version of the database"
  value       = try(module.rds.db_instance_engine_version_actual, "")
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = try(module.rds.db_instance_hosted_zone_id, "")
}

output "db_instance_identifier" {
  description = "The RDS instance identifier"
  value       = try(module.rds.db_instance_identifier, "")
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = try(module.rds.db_instance_resource_id, "")
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = try(module.rds.db_instance_status, "")
}

output "db_instance_name" {
  description = "The database name"
  value       = try(module.rds.db_instance_name, "")
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = try(module.rds.db_instance_username, "")
  sensitive   = true
}

output "db_instance_domain" {
  description = "The ID of the Directory Service Active Directory domain the instance is joined to"
  value       = try(module.rds.db_instance_domain, "")
}

output "db_instance_domain_auth_secret_arn" {
  description = "The ARN for the Secrets Manager secret with the self managed Active Directory credentials for the user joining the domain"
  value       = try(module.rds.db_instance_domain_auth_secret_arn, "")
}

output "db_instance_domain_dns_ips" {
  description = "The IPv4 DNS IP addresses of your primary and secondary self managed Active Directory domain controllers"
  value       = try(module.rds.db_instance_domain_dns_ips, "")
}

output "db_instance_domain_fqdn" {
  description = "The fully qualified domain name (FQDN) of an self managed Active Directory domain"
  value       = try(module.rds.db_instance_domain_fqdn, "")
}

output "db_instance_domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service"
  value       = try(module.rds.db_instance_domain_iam_role_name, "")
}

output "db_instance_domain_ou" {
  description = "The self managed Active Directory organizational unit for your DB instance to join"
  value       = try(module.rds.db_instance_domain_ou, "")
}

output "db_instance_port" {
  description = "The database port"
  value       = try(module.rds.db_instance_port, "")
}

output "db_instance_ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  value       = try(module.rds.db_instance_ca_cert_identifier, "")
}

output "db_instance_master_user_secret_arn" {
  description = "The ARN of the master user secret (Only available when manage_master_user_password is set to true)"
  value       = try(module.rds.db_instance_master_user_secret_arn, "")
}

output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = try(module.rds.db_subnet_group_id, "")
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = try(module.rds.db_subnet_group_arn, "")
}

output "db_parameter_group_id" {
  description = "The db parameter group id"
  value       = try(module.rds.db_parameter_group_id, "")
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = try(module.rds.db_parameter_group_arn, "")
}

# DB option group
output "db_option_group_id" {
  description = "The db option group id"
  value       = try(module.rds.db_option_group_id, "")
}

output "db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = try(module.rds.db_option_group_arn, "")
}

################################################################################
# CloudWatch Log Group
################################################################################

output "db_instance_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = try(module.rds.db_instance_cloudwatch_log_groups, "")
}

################################################################################
# DB Instance Role Association
################################################################################

output "db_instance_role_associations" {
  description = "A map of DB Instance Identifiers and IAM Role ARNs separated by a comma"
  value       = try(module.rds.db_instance_role_associations, "")
}

################################################################################
# Managed Secret Rotation
################################################################################

output "db_instance_secretsmanager_secret_rotation_enabled" {
  description = "Specifies whether automatic rotation is enabled for the secret"
  value       = try(module.rds.db_instance_secretsmanager_secret_rotation_enabled, "")
}

################################################################################
# Security Group
################################################################################

output "sg_id" {
  description = "The created or target Security Group ID"
  value       = try(module.sg[0].id, "")
}

output "sg_arn" {
  description = "The created Security Group ARN (null if using existing security group)"
  value       = try(module.sg[0].arn, "")
}

output "sg_name" {
  description = "The created Security Group Name (null if using existing security group)"
  value       = try(module.sg[0].name, "")
}

output "sg_rules_terraform_ids" {
  description = "List of Terraform IDs of created `security_group_rule` resources, primarily provided to enable `depends_on`"
  value       = try(module.sg[0].rules_terraform_ids, "")
}

output "sg_ids_list" {
  description = "The ID's of all the security groups"
  value       = var.security_group_create ? compact(concat([module.sg[0].id], var.vpc_security_group_ids)) : var.vpc_security_group_ids
}
################################################################################
# Route53 Group
################################################################################

output "route53_record_name" {
  description = "The name of the record"
  value       = try(module.route53_record[0].route53_record_name, "")
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = try(module.route53_record[0].route53_record_fqdn, "")
}
