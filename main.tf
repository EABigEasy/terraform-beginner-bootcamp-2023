
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  #Bucket Naming Rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnaming
 bucket = var.bucket_name

tags = {
    UserUuid= var.user_uuid
}

}

import {
  to = aws_s3_bucket.example
  id = "new-bucket-sample"
}
import {
  to = aws_s3_bucket.website_bucket
  id ="new-bucket-sample"
}
