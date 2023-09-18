# resource "aws_s3_bucket" "be-cache" {
#   bucket = "be-cache"
# }


resource "aws_codebuild_project" "fe-plan" {
  name          = "fe-cicd-plan"
  description   = "build image and push to ecr"
  service_role  = aws_iam_role.fe-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }
    # cache {
    # type     = "S3"
    # location = aws_s3_bucket.fe-cache.bucket
    # }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    # registry_credential{
    #     credential = var.dockerhub_credentials
    #     credential_provider = "SECRETS_MANAGER"
    # }
 }
 source {
     type   = "CODEPIPELINE"
     buildspec = "./buildspec.yaml"
 }
}



resource "aws_codepipeline" "cicd_pipeline" {

    name = "fe-cicd"
    role_arn = aws_iam_role.fe-codepipeline-role.arn
        artifact_store {
        type="S3"
        location = aws_s3_bucket.fe_codepipeline_artifacts.id
    }
    stage {
        name = "Source"
        action{
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeCommit"
            version = "1"
            output_artifacts = ["fe-code"]
            configuration = {
                RepositoryName = "web-pipeline"
                BranchName   = "master"
                OutputArtifactFormat = "CODEBUILD_CLONE_REF"
            }
        }
    }

    stage {
        name ="Plan"
        action{
            name = "Build"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["fe-code"]
            configuration = {
                ProjectName = "fe-cicd-plan"
            }
        }
    }

}
# resource "aws_s3_bucket_policy" "be-cache-policy" {
#   bucket = aws_s3_bucket.be-cache.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject",
#         Effect    = "Allow",
#         Principal = "*",
#         Action    = ["s3:GetObject"],
#         Resource  = "${aws_s3_bucket.be-cache.arn}/*",
#       },
#     ],
#   })
# }
