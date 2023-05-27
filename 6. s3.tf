resource "aws_s3_bucket" "dev-s3-dummy-files1" {
  bucket = "dev-s3-dummy-files1"  # Replace with your desired bucket name
}

resource "aws_s3_bucket_object" "FleetCart" {
  bucket = aws_s3_bucket.dev-s3-dummy-files1.id
  key    = "FleetCart.zip"  # Replace with the desired key/name for the first zip file
  source = "/Users/dillipkumars/FleetCart.zip"  # Replace with the local path to the first zip file
}

resource "aws_s3_bucket_object" "dummy" {
  bucket = aws_s3_bucket.dev-s3-dummy-files1.id
  key    = "dummy.zip"  # Replace with the desired key/name for the second zip file
  source = "/Users/dillipkumars/dummy.zip"  # Replace with the local path to the second zip file
}


