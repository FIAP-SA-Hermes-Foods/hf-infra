
### Passo 1: Criar Repositórios no Amazon ECR

1. **Criar Repositórios ECR:**
    - No console AWS, navegue até o ECR.
    - Crie um repositório para cada um dos seus serviços. Por exemplo, `service-hf-order-p5` e `pub-hf-product-p5`.

### Passo 2: Configurar AWS CLI

Certifique-se de que o AWS CLI esteja configurado no seu ambiente local ou no CI/CD.

```sh
aws configure
```

### Passo 3: Autenticar no ECR

Antes de enviar suas imagens, você precisa autenticar no ECR:
```sh
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

### Passo 4: Construir e Enviar Imagens Docker para o ECR

Para cada serviço, construa e envie as imagens Docker para o ECR.

1. **Navegue até o diretório do serviço e construa a imagem:**
```sh
cd /path/to/service-hf-order-p5
docker build -t service-hf-order-p5 .
```

2. Marcar a imagem para o ECR:
```sh
docker tag service-hf-order-p5:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/service-hf-order-p5:latest
```
==Repita esses passos para cada um dos serviços.==

3. Enviar a imagem para o ECR:
```sh
docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/service-hf-order-p5:latest
```

### Passo 5: Configurar Kubernetes Manifests

Atualize seus arquivos de manifesto Kubernetes para usar as imagens do ECR.

1. **Deployment para `service-hf-order-p5`:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service-hf-order-p5-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: service-hf-order-p5
  template:
    metadata:
      labels:
        app: service-hf-order-p5
    spec:
      containers:
      - name: service-hf-order-p5
        image: <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/service-hf-order-p5:latest
        ports:
        - containerPort: 3000
```

2. Service para `service-hf-order-p5`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: service-hf-order-p5
spec:
  selector:
    app: service-hf-order-p5
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
  type: ClusterIP
```
==Repita esses passos para cada um dos serviços==
### Passo 6: Aplicar Manifests no Cluster Kubernetes

Use `kubectl` para aplicar os manifests no seu cluster EKS.

1. **Configurar kubectl para acessar o cluster EKS:**
```sh
aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
```

2. Aplicar os manifests:
```sh
kubectl apply -f /path/to/service-hf-order-p5/deployment.yaml
kubectl apply -f /path/to/service-hf-order-p5/service.yaml
```

### Passo 7: Verificar a Configuração

1. **Verificar os Pods:**
```sh
kubectl get pods
```

2. **Verificar os Services:**
```sh
kubectl get services
```

3. Obter logs dos Pods (se necessário):
```sh
kubectl logs <pod_name>
```

---

### Comunicação Entre Micro serviços

Certifique-se de que os serviços do Kubernetes estão configurados corretamente para permitir a comunicação entre seus micro serviços. Você pode usar os nomes dos serviços como URLs de serviço dentro do cluster.

Por exemplo, se você tem um serviço `service-hf-order-p5`, outros contêineres no mesmo cluster podem se comunicar com ele através de `http://service-hf-order-p5`.

### Exemplo de Comunicação entre Micro serviços

Suponha que você tenha dois micro serviços: `service-hf-order-p5` e `pub-hf-product-p5`.

1. **Deployment de `pub-hf-product-p5`:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pub-hf-product-p5-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: pub-hf-product-p5
  template:
    metadata:
      labels:
        app: pub-hf-product-p5
    spec:
      containers:
      - name: pub-hf-product-p5
        image: <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/pub-hf-product-p5:latest
        ports:
        - containerPort: 3000
```

2. Service de `pub-hf-product-p5`:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: pub-hf-product-p5
spec:
  selector:
    app: pub-hf-product-p5
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
  type: ClusterIP
```

3. Deployment de `service-hf-order-p5` (com comunicação para `pub-hf-product-p5`):
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: service-hf-order-p5-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: service-hf-order-p5
  template:
    metadata:
      labels:
        app: service-hf-order-p5
    spec:
      containers:
      - name: service-hf-order-p5
        image: <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/service-hf-order-p5:latest
        env:
        - name: PUB_HF_PRODUCT_P5_URL
          value: "http://pub-hf-product-p5"
        ports:
        - containerPort: 3000
```

Agora, `service-hf-order-p5` pode se comunicar com `pub-hf-product-p5` usando o URL `http://pub-hf-product-p5`.