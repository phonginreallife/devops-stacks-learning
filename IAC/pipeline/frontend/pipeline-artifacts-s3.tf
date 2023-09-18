resource "aws_s3_bucket" "fe_codepipeline_artifacts" {
  bucket = "fe-pipeline-artifacts-wind"
} 

resource "aws_s3_bucket_ownership_controls" "fe_codepipeline_artifacts" {
  bucket = aws_s3_bucket.fe_codepipeline_artifacts.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "fe_codepipeline_artifacts" {
  depends_on = [aws_s3_bucket_ownership_controls.fe_codepipeline_artifacts]

  bucket = aws_s3_bucket.fe_codepipeline_artifacts.id
  acl    = "private"
}