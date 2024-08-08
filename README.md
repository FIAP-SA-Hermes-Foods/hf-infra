# Infraestrutura na AWS usando Terraform

Este repositório contém código Terraform para provisionar uma infraestrutura na AWS baseada no [vídeo tutorial](https://youtu.be/mfT4Eu3fic0?si=_D5Ku1lJ2V-V1tuU) disponibilizado pelo professor Douglas.  
### Estrutura de Arquivos

O projeto está organizado com os seguintes arquivos:
```txt
    eks-access-policy.tf: Políticas de acesso necessárias para o Amazon EKS.
    eks-access.tf: Configuração de acesso ao cluster Amazon EKS.
    eks-cluster.tf: Definição do cluster Amazon EKS.
    eks-node-group.tf: Configuração do grupo de nós para o cluster Amazon EKS.
    provider.tf: Configuração do provedor AWS.
    vars.tf: Declaração de variáveis usadas nos arquivos Terraform.
    sqs.tf: Configuração do Amazon SQS.
```
# Descrição

Este projeto utiliza Terraform para automatizar a criação dos recursos na AWS necessários para a nossa infraestrutura. Inclui definições para um cluster Amazon EKS, políticas de acesso, configurações de nós, além de configurações básicas como a criação de filas SQS.
Pré-requisitos

Para executar este projeto, é necessário ter instalado:

- Terraform (versão 1.9.1)  
- AWS CLI configurado com credenciais de acesso


# Como Usar
#### Configuração inicial:  

Entre no [AWS Academy](https://awsacademy.instructure.com/courses) e vá até o modulo ` Laboratório de aprendizagem da AWS Academy`, pois lá será possível de pegar as credenciais necessárias e tambem iniciar o nosso lab.  

- Aperte em `Start Lab` e espere ate que o simbolo da AWS fique **verde**
- Em `AWS Details` será possível encontrar as credenciais para o `AWS CLI` e no caminho `~/.aws/credentials`. Basta copiar e colar os valores que o academy enviou no arquivo do caminho acima.

Depois de realizar os passos para obter as credenciais, utilize os seguintes comandos para criar os recursos. 

#### Iniciar o terraform:
```bash
terraform init
```

#### Visualizar mudanças planejadas:
```bash
terraform plan
```

#### Aplicar as mudanças:
```bash
terraform apply --auto-approve
```
#### Limpar recursos (para manter os creditos):
```bash
terraform destroy --auto-approve
```
