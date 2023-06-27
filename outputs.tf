output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_dynamodb_table_id" {
  value = aws_dynamodb_table.this.id
}

output "aws_s3_bucket_id" {
  value = aws_s3_bucket.this.id
}
