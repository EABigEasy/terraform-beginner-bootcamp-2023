
module "terrahouse_aws" {
  source= "./modules/terrahouse_aws"
  user_uuid=var.user_uuid
  bucket_name=var.bucket_name
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
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

#import {
#to = aws_s3_bucket.example
# id = "new-bucket-sample"
#}
#import {
#to = aws_s3_bucket.website_bucket
#id ="new-bucket-sample"
#}
