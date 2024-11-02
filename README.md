# redis-cluster-lua-client
This is a simple lua script client created for the redis-cluster
The redis cluster that is used is bitnami redis-cluster https://github.com/bitnami/charts/tree/main/bitnami/redis-cluster

## Steps 
### Step1 Docker Build
```
docker build --progress=plain -t openresty-redis-cluster .
```

### Step2 Save the docker image
```
docker save openresty-redis-cluster -o openresty-redis-cluster.tar
```
### Step3 Load image
```
docker load -i openresty-redis-cluster.tar
```
### Step4 apply the deployment
```
kubectl apply -f nginx-deployment.yaml
```

### Step 5 Apply the service
```
kubectl apply -f nginx-service.yaml
```

### DO the curl 
```
curl http://localhost:32301/
```

Output should be something like this

```
foo: bar

10.42.0.1 - - [02/Nov/2024:13:13:08 +0000] "GET / HTTP/1.1" 200 1990 "-" "curl/8.7.1"
```