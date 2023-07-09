resource "aws_dynamodb_table" "terraform-state-table" {
  name         = "application-infra-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags   = {
    application: "terraform"
  }
}