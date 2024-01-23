
provider "aws" {
  region = "ap-southeast-1"
}

variable "admin_email" {
  type = string
}

resource "aws_ses_email_identity" "admin" {
  email = var.admin_email
}

resource "aws_iam_user" "user" {
  name = "email-user"
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.user.name
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions   = ["ses:SendEmail", "ses:SendRawEmail"]
    resources = ["*"]
  }
}

variable "iam_policy" {
  type = string
}

resource "aws_iam_policy" "policy" {
  name   = var.iam_policy
  policy = data.aws_iam_policy_document.policy_document.json
}

resource "aws_iam_user_policy_attachment" "user_policy" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}

output "smtp_username" {
  value = aws_iam_access_key.access_key.id
}

output "smtp_password" {
  value     = aws_iam_access_key.access_key.ses_smtp_password_v4
  sensitive = true
}
