# Read-only Group for Support Techs with S3 read-only access
resource "aws_iam_group" "support_techs_group" {
  name = var.readonly_group_name
}

resource "aws_iam_group_policy_attachment" "support_techs_policy_attachment" {
  group      = aws_iam_group.support_techs_group.name
  policy_arn = aws_iam_policy.readonly_s3_policy.arn
}

resource "aws_iam_group" "engineer_group" {
  name = var.engineer_group_name
}

resource "aws_iam_group_policy_attachment" "engineer_policy_attachment" {
  group      = aws_iam_group.engineer_group.name
  policy_arn = aws_iam_policy.engineer_ec2_policy.arn
}
