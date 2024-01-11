# Kubernetes (K8s)

Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.

`Kubernetes is like docker compose for multiple machines.`
just like we use docker compose for consolidating docker commands so we can easily create lots of containers in single machine quickly. we use kubernetes to create muliple containers on multiple machines.
with docker compose we can create all containers in single machine only.

- Open Source
- helps from vendor lock-in
- kubenetes is simple not software it's a collection of concepts and tools

## Concepts

### Pods

- A Pod contains one or more Container (typically one) and any configuration as well as volumes required by the Containers.
- With Kubernetes, you don't manage Containers but rather Pods which then manage the Containers

### Worker node

- Actual machines
- they can contain one or more pods

## Commands for minikube

https://minikube.sigs.k8s.io/docs/start/

### Start minikube

```
minikube start
```

### Get dashboard

```
minikube dashboard
```

### Get status

```
minikube status
```

### Destroy minikube

```
minikube delete --all
```

## Commands for kubectl

### Run first deployment

```
kubectl create deployment kube-first-dep --image=anujdube/kube-first:1
```

### Get all deployments

```
kubectl get deployments
```

### Get all pods

```
kubectl get pods
```

### Use service to expose port

```
kubectl expose deployment/kube-first-dep --type="NodePort" --port 8080
```

### Get all services

```
kubectl get services
```

### Get more info of service

```
kubectl describe services/kube-first-dep
```

you can use ip to access service

if you are using docker for virtualization you need below command

```
minikube service kube-first-dep --url
```

### Delete all resources

```
kubectl delete deployment kube-first-dep
```

```
kubectl delete service kube-first-dep
```

## Commands with kubernetes config files

#### Examples Deployment file

deployment.yml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: first-app-deployment
  labels:
    group: example
spec:
  replicas: 3
  selector:
    matchLabels:
      app: first-app
      tier: backend
    # matchExpressions:
    #   - {key: app, operator: NotIn, values: [second-app, first-app]}
  template:
    metadata:
      labels:
        app: first-app
        tier: backend
    spec:
      containers:
        - name: first-node
          image: anujdube/kube-first:1
          imagePullPolicy: Always
          livenessProbe:
            httpGet:
              path: /
              port: 8080
            periodSeconds: 10
            initialDelaySeconds: 5

```

Run it using

```
kubectl apply -f=deployment.yaml
kubectl apply -f deployment.yaml
```

### Example service file

service.yml

```
apiVersion: v1
kind: Service
metadata:
  name: backend
  labels:
    group: example
spec:
  selector:
    app: first-app
  ports:
    - protocol: 'TCP'
      port: 80
      targetPort: 8080
    # - protocol: 'TCP'
    #   port: 443
    #   targetPort: 443
  type: LoadBalancer
```

Run it using

```
kubectl apply -f=service.yaml
kubectl apply -f service.yaml
```

### See your app using

```
minikube service backend --url
```

### Delete all resources

```
kubectl delete -f deployment.yaml
kubectl delete -f service.yaml
```

```
kubectl delete -f deployment.yaml -f service.yaml
```

```
kubectl delete -f deployment.yaml,service.yaml
```

## Docker image updation on kubernetes clusters process

1. Push new created image to docker hub
2. update deployment.yml file with version
3. run this new deployment.yml file
4. docker will run new deployment in rolling way to see status us below command

```
kubectl rollout status deployment first-app-deployment
```

you can verify image version from dashboard also.

## Kubernetes Volumes

### Example of `emptyDir` volume

deployment.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: story-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: story
  template:
    metadata:
      labels:
        app: story
    spec:
      containers:
        - name: story
          image: anujdube/kube-node
          volumeMounts:
            - mountPath: /app/story
              name: story-volume
      volumes:
        - name: story-volume
          emptyDir: {}
```

service.yml
```
apiVersion: v1
kind: Service
metadata:
  name: story-service
spec:
  selector: 
    app: story
  type: LoadBalancer
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 3000
```

### Commands used

```
kubectl apply -f deployment.yaml -f service.yaml

kubectl get deployments

kubectl get pods

kubectl get services

minikube service story-service --url

kubectl delete -f deployment.yaml -f service.yaml
```


### Example of `PersistentVolume` volume

deployment.yml
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: story-deployment
spec: 
  replicas: 2
  selector:
    matchLabels:
      app: story
  template:
    metadata:
      labels:
        app: story
    spec:
      containers:
        - name: story
          image: anujdube/kube-node
          env:
            - name: STORY_FOLDER
              # value: 'story'
              valueFrom: 
                configMapKeyRef:
                  name: data-store-env
                  key: folder
          volumeMounts:
            - mountPath: /app/story
              name: story-volume
      volumes:
        - name: story-volume
          # emptyDir: {}
          persistentVolumeClaim:
            claimName: host-pvc
```

service.yml
```
apiVersion: v1
kind: Service
metadata:
  name: story-service
spec:
  selector: 
    app: story
  type: LoadBalancer
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 3000
```

host-pv.yml
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: host-pv
spec:
  capacity: 
    storage: 1Gi
  volumeMode: Filesystem
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /data
    type: DirectoryOrCreate
```

host-pvc.yml
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: host-pvc
spec:
  volumeName: host-pv
  accessModes:
    - ReadWriteOnce
  storageClassName: standard
  resources:
    requests: 
      storage: 1Gi
```

### Commands used
```
kubectl apply -f deployment.yaml -f service.yaml -f host-pv.yaml -f host-pvc.yaml -f environment.yaml

kubectl get deployments

kubectl get pods

kubectl get services

minikube service story-service --url

kubectl delete -f deployment.yaml -f service.yaml -f host-pv.yaml -f host-pvc.yaml -f environment.yaml 
```
