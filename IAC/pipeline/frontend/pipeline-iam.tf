data "aws_iam_policy_document" "assume_codepipeline_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "fe-codepipeline-role" {
  name = "fe-codepipeline-role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_codepipeline_role.json
}
data "aws_iam_policy_document" "fe-cicd-pipeline-policies" {

    statement{
        sid = ""
        actions = ["cloudwatch:*", "s3:*","codecommit:*", "codebuild:*"]
        resources = ["*"]
        effect = "Allow"
    }
}
resource "aws_iam_policy" "fe-cicd-pipeline-policy" {
    name = "fe-cicd-pipeline-policy"
    path = "/"
    description = "Pipeline policy"
    policy = data.aws_iam_policy_document.fe-cicd-pipeline-policies.json
}

resource "aws_iam_role_policy_attachment" "fe-cicd-pipeline-attachment" {
    policy_arn = aws_iam_policy.fe-cicd-pipeline-policy.arn
    role = aws_iam_role.fe-codepipeline-role.id
}
data "aws_iam_policy_document" "assume_codebuild_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole",]
  }
}
# data "aws_iam_policy_document" "assume_codebuild_role_codecommit" {
#   statement {
#     sid = "AllowPullSourceCodeFromCodeCommit"
#     effect = "Allow"
#     resources = ["*"]
#     principals {
#       type        = "Service"
#       identifiers = ["codebuild.amazonaws.com"]
#     }
#     actions = []
#   }
# }
resource "aws_iam_role" "fe-codebuild-role" {
  name = "fe-codebuild-role"
  assume_role_policy =  data.aws_iam_policy_document.assume_codebuild_role.json
}
data "aws_iam_policy_document" "fe-cicd-build-policies" {
    statement{
        sid = ""
        actions = ["logs:*", "s3:*", "codebuild:*","iam:*","codecommit:GitPull"]
        resources = ["*"]
        effect = "Allow"
    }
}
resource "aws_iam_policy" "fe-cicd-build-policy" {
    name = "fe-cicd-build-policy"
    path = "/"
    description = "Codebuild policy"
    policy = data.aws_iam_policy_document.fe-cicd-build-policies.json
}
resource "aws_iam_role_policy_attachment" "fe-cicd-codebuild-attachment1" {
    policy_arn  = aws_iam_policy.fe-cicd-build-policy.arn
    role        = aws_iam_role.fe-codebuild-role.id
}
