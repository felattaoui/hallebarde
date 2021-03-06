resource "aws_api_gateway_method" "revoke_exchange_delete" {
  rest_api_id          = aws_api_gateway_rest_api.api.id
  resource_id          = aws_api_gateway_resource.exchanges.id
  http_method          = "DELETE"
  authorization        = "COGNITO_USER_POOLS"
  authorizer_id        = aws_api_gateway_authorizer.cognito_authorizer.id
  authorization_scopes = ["hallebarde-${var.env}/api"]
}

resource "aws_api_gateway_integration" "revoke_exchange_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.exchanges.id
  http_method             = aws_api_gateway_method.revoke_exchange_delete.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = data.aws_lambda_function.revoke_exchange.invoke_arn
}

resource "aws_lambda_permission" "revoke_exchange_lambda_permission" {
  statement_id  = "${var.application_name}-${var.env}-allow-revoke-exchange"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.revoke_exchange.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.deployment.execution_arn}/*/exchanges"
}

