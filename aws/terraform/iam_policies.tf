resource "aws_iam_policy" "readonly_s3_policy" {
  name        = "ReadOnlyS3Policy"
  description = "Read-only access to S3 for support techs"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "engineer_ec2_policy" {
  name        = "EngineerEC2Policy"
  description = "EC2 access for engineers"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*", "ec2:StartInstances", "ec2:StopInstances"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
