module "s3" {
  source = "./s3"
}

module "dynamodb" {
  source = "./dynamodb"
}

module "iam" {
  source = "./iam"
}