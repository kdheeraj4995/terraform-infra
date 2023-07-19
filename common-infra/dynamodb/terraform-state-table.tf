module "variables" {
  source = "../variables"
}

resource "aws_dynamodb_table" "terraform-state-table" {
  name         = "application-infra-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags   = merge(var.tags, var.local_tags)
}