resource "aws_codebuild_project" "be-plan" {
  name          = "be-cicd-plan"
  description   = "build image and push to ecr"
  service_role  = aws_iam_role.be-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }
    # cache {
    # type     = "S3"
    # location = aws_s3_bucket.be-cache.bucket
    # }


  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = "true"
    # registry_credential{
    #     credential = var.dockerhub_credentials
    #     credential_provider = "SECRETS_MANAGER"
    # }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "us-west-2"
      type = "PLAINTEXT"
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "492804330065"
      type = "PLAINTEXT"
    }
    environment_variable {
      name  = "IMAGE_NAME"
      value = "todoreactapp"
      type = "PLAINTEXT"
    }
 }
   logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    # s3_logs {
    #   status   = "ENABLED"
    #   location = "${aws_s3_bucket.be-cache.id}/build-log"
    # }
  }

 source {
     type   = "CODEPIPELINE"
     buildspec = "./buildspec.yaml"
 }
}



resource "aws_codepipeline" "be_cicd_pipeline" {

    name = "be-cicd"
    role_arn = aws_iam_role.be-codepipeline-role.arn
    artifact_store {
        type="S3"
        location = aws_s3_bucket.be_codepipeline_artifacts.id
    }
    stage {
        name = "Source"
        action{
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeCommit"
            version = "1"
            output_artifacts = ["be-code"]
            configuration = {
                RepositoryName = "app-pipeline"
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
            input_artifacts = ["be-code"]
            configuration = {
                ProjectName = "be-cicd-plan"
            }
        }
    }

}
# resource "aws_s3_bucket" "be-cache" {
#   bucket = "be-cache"
# }

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
#         Resource  = "aws_s3_bucket.be-cache.arn/*",
#       },
#     ],
#   })
# }