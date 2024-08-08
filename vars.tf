variable "labRole" {
  default = "arn:aws:iam::597646754575:role/LabRole"
}

variable "principalArn" {
  default = "arn:aws:iam::597646754575:role/voclabs"
}

variable "subnetA" {
  default = "subnet-05e3ba1246d9bb705"
}

variable "subnetB" {
  default = "subnet-0298a68e3b6e216df"
}

variable "subnetC" {
  default = "subnet-0490e4be841e7e189"
}

variable "sgId" {
  default = "sg-01540d5d36f08425e"
}

variable "accessConfig" {
  default = "API_AND_CONFIG_MAP"
}

variable "policyArn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "nodeName" {
  default = "node-hf" #MUDAR SE QUISER
}

variable "queue_name" {
  default = "my-queue" #MUDAR SE QUISER
}