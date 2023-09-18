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

resource "aws_iam_role" "be-codepipeline-role" {
  name = "be-codepipeline-role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_codepipeline_role.json
}
data "aws_iam_policy_document" "be-cicd-pipeline-policies" {

    statement{
        sid = ""
        actions = ["cloudwatch:*", "s3:*","codecommit:*", "codebuild:*"]
        resources = ["*"]
        effect = "Allow"
    }
}
resource "aws_iam_policy" "be-cicd-pipeline-policy" {
    name = "be-cicd-pipeline-policy"
    path = "/"
    description = "Pipeline policy"
    policy = data.aws_iam_policy_document.be-cicd-pipeline-policies.json
}

resource "aws_iam_role_policy_attachment" "be-cicd-pipeline-attachment" {
    policy_arn = aws_iam_policy.be-cicd-pipeline-policy.arn
    role = aws_iam_role.be-codepipeline-role.id
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
#     efbect = "Allow"
#     resources = ["*"]
#     principals {
#       type        = "Service"
#       identifiers = ["codebuild.amazonaws.com"]
#     }
#     actions = []
#   }
# }
resource "aws_iam_role" "be-codebuild-role" {
  name = "be-codebuild-role"
  assume_role_policy =  data.aws_iam_policy_document.assume_codebuild_role.json
}
data "aws_iam_policy_document" "be-cicd-build-policies" {
    statement{
        sid = ""
        actions = ["logs:*", "s3:*", "codebuild:*","iam:*","codecommit:GitPull"]
        resources = ["*"]
        effect = "Allow"
    }
}
resource "aws_iam_policy" "be-cicd-build-policy" {
    name = "be-cicd-build-policy"
    path = "/"
    description = "Codebuild policy"
    policy = data.aws_iam_policy_document.be-cicd-build-policies.json
}
resource "aws_iam_role_policy_attachment" "be-cicd-codebuild-attachment1" {
    policy_arn  = aws_iam_policy.be-cicd-build-policy.arn
    role        = aws_iam_role.be-codebuild-role.id
}
resource "aws_iam_role_policy_attachment" "be-cicd-codebuild-attachment2" {
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
    role        = aws_iam_role.be-codebuild-role.id
}
resource "aws_iam_role_policy_attachment" "be-cicd-codebuild-attachment3" {
    policy_arn  = "arn:aws:iam::492804330065:policy/service-role/CodeBuildBasePolicy-building-images-to-ecr-us-west-2"
    role        = aws_iam_role.be-codebuild-role.id
}
resource "aws_iam_role_policy_attachment" "be-cicd-codebuild-attachment4" {
    policy_arn  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
    role        = aws_iam_role.be-codebuild-role.id
}