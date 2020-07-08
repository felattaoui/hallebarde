resource "aws_lambda_function" "revoke_exchange" {
  function_name = "${var.application_name}-${var.env}-revoke-exchange"
  role = data.aws_iam_role.role_s3.arn
  handler = "hallebarde/revoke_exchange.handle"

  s3_bucket = aws_s3_bucket.code_bucket.id
  s3_key = aws_s3_bucket_object.code_package.id

  runtime = var.python_runtime

  environment {
    variables = {
      ENVIRONMENT = var.env
      APPLICATION_NAME = var.application_name
    }
  }
}
