module "route53_record" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-route53.git//modules/records?ref=e3e35482b7d8d430b505c8dba858b95b9a379601" #v3.1.0

  count        = var.route_53_record.enabled && var.create ? 1 : 0
  zone_name    = var.route_53_record.zone_name
  private_zone = var.route_53_record.private_zone
  records = [
    {
      name    = var.route_53_record.name
      type    = var.route_53_record.type
      ttl     = var.route_53_record.ttl
      records = [module.rds.db_instance_address]
    }
  ]
}
