resource "aws_eip" "eip" {
  # domain = "vpc"
  tags   = {
    Name = "eip-${local.name}"
  }
  depends_on = [ aws_vpc.vpc ]
}