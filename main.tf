# terraform state file setup

provider "aws" {
  region = "us-east-2"
}

# create an S3 bucket to store the state file in

resource "aws_s3_bucket" "terraform-state-storage" {
    bucket = "terraform-remote-state-bucket"
    versioning {
      enabled = true
    }
    lifecycle {
      prevent_destroy = true
    }
    tags {
      Name = "S3 Remote Terraform State Store"
    }
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
