
resource "aws_backup_vault" "main" {
  name = "techdiversa-backup-vault"
}

resource "aws_backup_plan" "main" {
  name = "techdiversa-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.main.name
    schedule          = "cron(0 5 * * ? *)"
    start_window      = 60
    completion_window = 180
    lifecycle {
      delete_after = 30
    }
  }
}

resource "aws_backup_selection" "rds" {
  iam_role_arn = var.iam_role_arn
  name         = "rds-selection"
  plan_id      = aws_backup_plan.main.id

  resources = [var.rds_arn]
}
