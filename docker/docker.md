`Images`: os file (somewhat like ISO file in VM)

`Container`: Run time instance of image

## Basic Commands

### List of running container

```
docker ps
docker container ls
```

### List of running and stopped containers

```
docker ps -a
docker container ls -a
```

### List of images

```
docker images
```

### Adhoc Running

```
docker run -it <image name>
docker run -it ubuntu
```

- run creates new container everytime
- `-it` opens command line in iteractive tty (connects your terminal with container terminal)
- Docker containers typically run as the root user by default
- Ubuntu image doesn't have sudo installed to minimise image size
- Container has internet access. found by doing `apt update`

### Start and Stop Docker conatainer

```
docker start <container name/container ID>
docker stop <container name/container ID>
```

### Run command on running container

```
docker exec <container name/container ID> <command>
docker exec modest_davinci ls
```

`-it` opens command line in iteractive tty (connects your terminal with container terminal)

```
docker exec -it <container name/container ID> bash
docker exec -it wizardly_chatterjee bash
```

## Port Mapping

### Run nginx

```
docker run -p 8080:80 nginx
docker run -it -p 8080:80 nginx
```

`-p <host machine port>:<container port>`

## Environment Variables

```
docker run -it <image id> -e key=value

docker run -it -e key=value key1=value1 ubuntu
docker run -it -e key=value -e key1=value1 ubuntu
```

`-e` flag for environment variables

## Dockerfile

For creating docker images

### Tagging

```
docker build -t <tag you want to add> <path of Dockerfile>
docker build -t docker-node-asd .
```

### Running my built image

```
docker run -it -e PORT=4000 -p 4000:4000 docker-node-asd
```

## Docker Compose

For Running multiple containers

### Run compose to create and start containers

```
docker compose up
docker compose up -d
```

`-d` for running in detach mode (run in background)

### Remove containers

```
docker compose down
```
