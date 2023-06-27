terraform {
  backend "s3" {
    bucket         = aws_s3_bucket_id
    dynamodb_table = aws_dynamodb_table_id
    encrypt        = true
    key            = "myproject.tfstate"
    region         = "eu-west-2"
  }
}
