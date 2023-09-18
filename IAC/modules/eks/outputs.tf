output "nodes" {
  value = aws_eks_node_group.nodes.arn
}
output "sg" {
  value = {
    lb     = aws_security_group.lb-sg.id
    db     = aws_security_group.db-sg.id
    websvr = aws_security_group.websvr_sg.id
  }
}