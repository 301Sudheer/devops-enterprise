resource "aws_s3_bucket" "v_app_prod_bucket" {
  bucket = "v-app-prod-bucket"
    
tags = {
    Name        = "v-app-prod-bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_policy" "v_app_prod_bucket_policy" {
  bucket = aws_s3_bucket.v_app_prod_bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "${aws_s3_bucket.v_app_prod_bucket.arn}/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
EOF
}
