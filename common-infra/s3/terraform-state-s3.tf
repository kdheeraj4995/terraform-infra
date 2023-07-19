resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = var.s3-info.application-infra-terraform-state.name
  tags   = merge(var.tags, var.s3-info.application-infra-terraform-state.bucket-tags)
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "dheeraj-terraform-states-public-access-block" {
  bucket                  = aws_s3_bucket.terraform-state-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "dheeraj-terraform-states-ownership-controls" {
  bucket = aws_s3_bucket.terraform-state-bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


data "aws_iam_policy_document" "s3-bucket-policy-document" {
  statement {
    actions   = ["*"]
    resources = ["${aws_s3_bucket.terraform-state-bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::413649149254:user/admin"]
    }
  }
}

resource "aws_s3_bucket_policy" "s3-bucket-policy" {
  bucket = aws_s3_bucket.terraform-state-bucket.id
  policy = data.aws_iam_policy_document.s3-bucket-policy-document.json
}
