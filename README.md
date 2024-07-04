### Estrutura do Projeto Terraform

A estrutura recomendada de diretórios e arquivos pode ser a seguinte:

```txt
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── vpc.tf
├── eks-cluster.tf
├── node-group.tf
├── services/
│   ├── microservice1.tf
│   ├── microservice2.tf
│   ├── ...
│   └── microservice16.tf
└── sqs.tf
```


### Explicação dos Parâmetros no `sqs.tf`

- `visibility_timeout_seconds`: Tempo (em segundos) que uma mensagem ficará invisível para outros consumidores após ser recebida.
- `message_retention_seconds`: Tempo (em segundos) que a mensagem será retida na fila.
- `max_message_size`: Tamanho máximo (em bytes) de uma mensagem permitida na fila.
- `delay_seconds`: Tempo (em segundos) de atraso para todas as mensagens enviadas para a fila.
- `receive_wait_time_seconds`: Tempo máximo (em segundos) que uma solicitação de recebimento deve esperar por uma mensagem a ser disponibilizada.

### Dead-Letter Queue (DLQ)

O uso de uma Dead-Letter Queue é uma prática recomendada para lidar com mensagens que não podem ser processadas. A política de redrive define que, após cinco tentativas de processamento sem sucesso, a mensagem será movida para a fila `my-dead-letter-queue`.

Essa configuração permite um manuseio mais robusto e resiliente das mensagens, especialmente útil em cenários de micro serviços e integração com outros componentes, como mostrado no diagrama que você forneceu.