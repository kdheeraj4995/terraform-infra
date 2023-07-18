resource "aws_iam_group" "kops-iam-group" {
  name = "kops"
}

resource "aws_iam_group_policy_attachment" "kops-group-policy-attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
  ])
  group      = aws_iam_group.kops-iam-group.name
  policy_arn = each.value
}


resource "aws_iam_group" "Administrator" {
  name = "Administrator"
}

resource "aws_iam_group_policy_attachment" "admin-policy-attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/job-function/Billing"
  ])
  group      = aws_iam_group.Administrator.name
  policy_arn = each.value
}