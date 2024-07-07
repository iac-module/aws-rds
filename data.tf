data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_iam_policy_document" "rds_s3_policy" {
  count = var.s3_audit_log.create ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketACL",
      "s3:GetBucketLocation"
    ]
    resources = ["arn:aws:s3:::${local.bucket_name}"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]
    resources = ["arn:aws:s3:::${local.bucket_name}/*"]
  }
}
