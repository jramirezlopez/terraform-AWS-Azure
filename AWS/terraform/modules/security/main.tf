
resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = "techdiversa-cloudtrail-logs"
  force_destroy = true
  tags = {
    Name = "CloudTrail Logs Bucket"
  }
}
resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AWSCloudTrailAclCheck20150319",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:GetBucketAcl",
        Resource = "arn:aws:s3:::techdiversa-cloudtrail-logs"
      },
      {
        Sid    = "AWSCloudTrailWrite20150319",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::techdiversa-cloudtrail-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid    = "AWSConfigWritePut",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "${aws_s3_bucket.cloudtrail_logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid    = "AWSConfigReadACL",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action   = "s3:GetBucketAcl",
        Resource = "${aws_s3_bucket.cloudtrail_logs.arn}"
      }
    ]
  })
}

data "aws_caller_identity" "current" {}


resource "aws_cloudtrail" "main" {
  name                          = "techdiversa-trail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
}

resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_config_configuration_recorder" "recorder" {
  name     = "techdiversa"
  role_arn = var.config_role_arn
}

resource "aws_config_delivery_channel" "channel" {
  name           = "techdiversa"
  s3_bucket_name = var.bucket
  depends_on     = [aws_config_configuration_recorder.recorder]
}

resource "aws_config_configuration_recorder_status" "status" {
  is_enabled = true
  name       = aws_config_configuration_recorder.recorder.name
  depends_on = [aws_config_delivery_channel.channel]
}

resource "aws_securityhub_account" "main" {
  depends_on = [aws_config_configuration_recorder_status.status]
}
