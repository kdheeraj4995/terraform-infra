resource "aws_s3_bucket" "kops-clusterstate-bucket" {
  bucket = "kops-k8-cluster-state"
  tags   = {
    application: "kops"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "kops-clusterstates-public-access-block" {
  bucket                  = aws_s3_bucket.kops-clusterstate-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "kops-clusterstates-ownership-controls" {
  bucket = aws_s3_bucket.kops-clusterstate-bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


data "aws_iam_policy_document" "kops-clusters3-bucket-policy-document" {
  statement {
    actions   = ["*"]
    resources = ["${aws_s3_bucket.kops-clusterstate-bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::413649149254:user/admin"]
    }
  }
}

resource "aws_s3_bucket_policy" "kops-clusters3-bucket-policy" {
  bucket = aws_s3_bucket.kops-clusterstate-bucket.id
  policy = data.aws_iam_policy_document.kops-clusters3-bucket-policy-document.json
}
