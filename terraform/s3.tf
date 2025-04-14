resource "aws_s3_bucket" "extraction_bucket"{
bucket = "dietary-and-healthparam-plus-cvd-mortality-rates"
tags = {
    Name = "BucketForDataIngestion"
}
}

resource "aws_s3_bucket" "transformation_bucket"{
bucket = "who-data-transformed"
tags = {
    Name = "BucketforDataTransformation"
}
}
