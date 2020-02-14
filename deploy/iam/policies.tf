resource "aws_iam_policy" "lambda_logging" {
  name = "lambda_logging"
  path = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "dynamodb" {
  name        = "hallebarde-${var.env}-dynamodb"
  description = "Allows hallebarde to access dynamodb"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"
            ],
            "Resource": "${data.aws_dynamodb_table.table.arn}"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "s3_presigned_urls_policy" {
  name        = "hallebarde-${var.env}-s3-presigned-url"
  description = "Allows hallebarde to create s3 presigned urls in hallebarde bucket"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
{
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "${data.aws_s3_bucket.bucket.arn}/*"
        }
    ]
}
EOF
}