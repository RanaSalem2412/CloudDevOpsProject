terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-rana"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
