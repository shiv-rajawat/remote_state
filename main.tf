# terraform state file setup
variable "access_key" {
  type = "string"
  }

variable "secret_key" {
  type = "string"
  }


provider "aws" {
  region = "ap-southeast-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

# create an S3 bucket to store the state file in

resource "aws_s3_bucket" "terraform-state-storage-temp" {
    bucket = "shiv-terraform-remote-state-bucket"
    versioning {
      enabled = true
    }
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock-temp" {
  name = "shiv-terraform-state-lock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
