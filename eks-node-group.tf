resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.fiap.name
  node_group_name = var.nodeName
  node_role_arn   = var.labRole
  subnet_ids      = ["${var.subnetA}", "${var.subnetB}", "${var.subnetC}"]
  disk_size       = 30 # Caso precise de mais pode colocar 50 mas fica + caro
  instance_types  = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 1 # substituir por 3 ou 2, esta assim para nao gastar tanto
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}
