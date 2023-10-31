terraform {
  required_providers {
  
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }

  }

}
#module "terrahouse_aws" {
#source="./modules/terrahouse_aws"
# user_uuid=var.user_uuid
# bucket_name=var.bucket_name
#}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  #Bucket Naming Rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnaming
 bucket = var.bucket_name

tags = {
    UserUuid= var.user_uuid
}

}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_conifugration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

 
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket 
   key    = "index.html"
  source =var.index_html_filepath
  etag = filemd5 (var.index_html_filepath)
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket 
   key    = "error.html"
  source = var.error_html_filepath
 
  etag = filemd5(var.error_html_filepath)
}
