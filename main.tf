// main.tf: Manages the AWS infrastructure for a static S3 website.

// AWS Provider Configuration
// Specifies the AWS region where resources will be created.
provider "aws" {
  region = "us-east-1"
}

// S3 Bucket for Website Hosting
// Defines the S3 bucket that will store the static website files.
// A random suffix is used to ensure the bucket name is globally unique.
resource "aws_s3_bucket" "website_bucket" {
  bucket = "my-portfolio-website-${random_pet.suffix.id}"
}

// S3 Bucket Public Access Configuration
// Allows public access to the bucket, which is required for website hosting.
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// S3 Bucket Website Hosting Configuration
// Enables static website hosting features on the S3 bucket.
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.id

  // Sets the default page for the website.
  index_document {
    suffix = "index.html"
  }
}

// S3 Bucket Policy for Public Read Access
// Defines a JSON policy that grants public read-only access to the bucket's objects.
// This allows anyone on the internet to view the website files.
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
      },
    ]
  })

  // Ensures public access is enabled before the policy is applied.
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

// Upload Website Content
// Uploads the local index.html file to the root of the S3 bucket.
resource "aws_s3_object" "index_file" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"

  // The etag function creates a hash of the file. If the file changes,
  // Terraform will re-upload it on the next apply.
  etag = filemd5("index.html")
}

// Random Name Generator
// Creates a random two-word name to append to the S3 bucket for uniqueness.
resource "random_pet" "suffix" {
  length = 2
}

// Outputs
// Outputs the public URL of the website after deployment.
output "website_url" {
  value       = aws_s3_bucket_website_configuration.website_config.website_endpoint
  description = "The public URL of the static website."
}