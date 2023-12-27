`Images`: os file (somewhat like ISO file in VM)

`Container`: Run time instance of image

## Basic Commands

### List of running container

```
docker ps
docker container ls
```

`ps` stands for processes

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
docker run -it --name asd_1 ubuntu
```

- run creates new container everytime
- `-it` opens command line in iteractive(`-i`) pseudo-TTY(`-t`) (connects your terminal with container terminal)
- Docker containers typically run as the root user by default
- Container is started in `attached` mode by default
  you will see not output. `-d` for running in detached mode.

### Start and Stop Docker conatainer

```
docker start <container name/container ID>
docker stop <container name/container ID>
```

- Run commands created new container if you just want to start old container you can use `start` command.

- Container is started in `detached` mode by default
  you will see not output. `-a` for running in detached mode.

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

### Removing container and images

can remove stopped containers only

```
docker rm <containe name/ID>
docker rmi <image name/ID>
```

### Remove all containers and images

```
docker container prune
docker image prune -a
```

you can remove images only if they are not being used by any active container.

`docker image prune` removed all dangling images (untagged showind `<none>` as name)

`docker image prune -a` removes unused images also which are not used in any running container.

### Get info about container and image

```
docker container inspect <container id/name>
docker image inspect <image id/name>
```

### Copy file into and outside container

```
docker cp test/. contianer_name:/text
docker cp contianer_name:/text/text.txt text/.
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

`-t` you can give name:tag combination also

### Running my built image

```
docker run -it -e PORT=4000 -p 4000:4000 docker-node-asd
```

### Making efficient images

- make as less layers as possible (less number of lines)

- make them logically sound.

  because if you change any line on layer 3 all layer below will be formed again and you will loose caching benefit.

### RUN vs CMD vs ENTRYPOINT

`RUN` : Image building step. you can have as many RUN as needed.

`CMD` : Container executes it by deafult when you launch the built image. Dockerfile will only use the final CMD defined.

`ENTRYPOINT` : Same work as `CMD`. learn more [here](https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact)

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

## Docker Networking

`bridge`: connect to host machine for internet only. differnet network stack than host.

`host`: connected to host machine same port as host machine. same network stack as host.

means if you run some service on container at 8080 port.
if networking is `bridge` you can't access that service on 8080 port of your host machine.
but if networking is `host` you can acccess that service on 8080 port your host machine, as they have same network stack.

### See list of networks

```
docker network ls
```

### See which container are using that network

```
docker network inspect <network ID/name>
```

### Run container whith network specified

```
docker run -it --network host busybox
docker run -it --network=host busybox
docker run -it --network none busybox
docker run -it -d --network host busybox
```

### Creating network

```
docker network create -d bridge anujsd
```

## Docker Volume Mounting

```
docker run -it -v C:\Users\admin\Desktop\notes\devops\devops\docker\docker-node:/home/anuj ubuntu
```

## Docker Multi Stage Builds

Need to write here

---

## Concepts
