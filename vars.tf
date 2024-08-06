variable "labRole" {
  default = "${var.LAB_ROLE}"
}

variable "principalArn" {
  default = "${var.PRINCIPAL_ARN}"
}

variable "subnetA" {
  default = "${var.SUBNET_A}"
}

variable "subnetB" {
  default = "${var.SUBNET_B}"
}

variable "subnetC" {
  default = "${var.SUBNET_C}"
}

variable "sgId" {
  default = "${var.SG_ID}"
}

variable "accessConfig" {
  default = "API_AND_CONFIG_MAP"
}

variable "policyArn" {
  default = "${var.POLICY_ARN}"
}

variable "nodeName" {
  default = "node-hf" #MUDAR SE QUISER
}

variable "queue_name" {
  default = "my-queue" #MUDAR SE QUISER
}

variable "AWS_REGION" {
  default = "${var.AWS_REGION}"
}