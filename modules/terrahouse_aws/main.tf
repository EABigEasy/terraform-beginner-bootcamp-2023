terraform {
  required_providers {
  
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }

  }

}
module "terrahouse_aws" {
  source="./modules/terrahouse_aws"
  user_uuid=var.user_uuid
  bucket_name=var.bucket_name
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  #Bucket Naming Rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnaming
 bucket = var.bucket_name

tags = {
    UserUuid= var.user_uuid
}

}
