resource "aws_dynamodb_table" "this" {
  name = lower("${var.environment}-${var.name}-${var.region}-tflock")

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}
