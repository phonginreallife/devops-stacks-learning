resource "aws_s3_bucket" "be_codepipeline_artifacts" {
  bucket = "be-pipeline-artifacts-wind"
} 

resource "aws_s3_bucket_ownership_controls" "be_codepipeline_artifacts" {
  bucket = aws_s3_bucket.be_codepipeline_artifacts.id
  rule {
    object_ownership = "BucketOwnerPreferred"  # Corrected typo here
  }
}

resource "aws_s3_bucket_acl" "be_codepipeline_artifacts" {
  depends_on = [aws_s3_bucket_ownership_controls.be_codepipeline_artifacts]

  bucket = aws_s3_bucket.be_codepipeline_artifacts.id
  acl    = "private"
}
