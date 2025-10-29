## docker run command examples
  # running a container with default settings
  docker run nginx    # Run a container with the nginx image
  docker run --name mynginx nginx # Run a container with a specific name
  docker run --rm nginx # Run a container and remove it after it stops

  # runnning a container in detached mode
  docker run -d nginx:1.14-alpine # Run a container in detached mode with a specific version of the nginx image
  docker run -d --name webapp nginx:1.14-alpine
  docker run -d -p 8080:80 nginx:1.14-alpine # Run a container within a port mapping
  docker run -d --name webapp -p 8080:80 nginx:1.14-alpine # Run a container with a specific name and port mapping
  docker run -d nginx # Run a container in detached mode
  docker run -d --name mynginx nginx # Run a container in detached mode with a specific name
  docker run -d -p 8080:80 --name mynginx nginx # Run a container in detached mode with a specific name and port mapping

  # practce with -it and --rm
  docker run -it --rm busybox sh # Run a container interactively and remove it after it stops
  docker run -it --rm ubuntu bash # Run an interactive Ubuntu container with a terminal and remove it after it stops

  # practise with -d
  docker run -d busybox sh -c "while true; do echo hello world; sleep 1; done" # Run a container in detached mode that prints "hello world" every second
  docker run -d ubuntu sleep 1000 # Run a container in detached mode that sleeps for 1000 seconds
  docker run -d --name myubuntu ubuntu sleep 1000 # Run a container in detached mode with a specific name that sleeps for 1000 seconds  

  # practice without detached mode
  docker run busybox sh -c "while true; do echo hello world; sleep 1; done" # Run a container that prints "hello world" every second
  docker run busybox sh -c "while true; do date; sleep 1; done" # Run a container that prints the date every second
  docker run -d --name mybusybox busybox sh -c "while true; do echo hello world; sleep 1; done" # Run a container in detached mode with a specific name that prints "hello world" every second

  # running a container with a specific image version -- tags
  docker run redis # consider the default tag to be latest if not specified
  docker run redis:latest # Run a container with the latest redis image
  docker run redis:6.0 # Run a container with a specific version of the redis image

  # running a container interactively
  docker run -i redis:6.0 # Run a container interactively with the redis image
  docker run -it redis:6.0 # Run a container interactively with a terminal using the redis image
  docker run -it redis:6.0 # Run a container interactively with a terminal using the redis image
  docker run -it nginx # Run a container interactively with a terminal using the nginx image
  docker run -it --rm nginx # Run a container interactively with a terminal and remove it after it stops using the nginx image

  # port mapping examples
  # every docker container get assigned a private IP address from the docker bridge network
  # an internal ip that is not accessible from the host machine but only from the docker containers 
  # to access the container from the host machine we need to map the container port to a host port
  docker run -p 8080:80 nginx # Map port 8080 on the host to port 80 in the container
  docker run -p 8080:8000 nginx # Map port 8080 on the host to port 8000 in the container
  docker run -p 8080:80 -p 8443:443 nginx # Map multiple ports on the host to ports in the container
  
    # mysql example
    docker run -p 8306:3306 mysql # Run a MySQL container and map port 8306 on the host to port 3306 in the container
    docker run -d -p 3306:3306 --name mysqlserver -e MYSQL_ROOT_PASSWORD=my-secret-pw mysql:latest

    # postgres example
    docker run -p 5432:5432 postgres # Run a Postgres container and map port 5432 on the host to port 5432 in the container
    docker run -d -p 5432:5432 --name postgresserver -e POSTGRES_PASSWORD=my

  # volume mapping examples
  # docker is an isolated system and changes are made within the container
  # docker is ephemeral and when the container is removed all changes are lost (docker stop mysql and docker rm mysql)
  # to persist data we need to use volumes or bind mounts
  # volumes are managed by docker and are stored in a specific location on the host
  # bind mounts are directories on the host that are mounted into the container
  # data files are stored in the container's location /var/lib/docker/volumes/
  # to persist data we need to map the container's data directory to a host directory
  
  docker run -v /host/path:/container/path nginx # Mount a volume from the host to the container
  docker run -v /host/nginx/html:/usr/share/nginx/html nginx # Mount a volume from the host to the container
  docker run -v /host/mysql/data:/var/lib/mysql mysql # Mount a volume from the host to the container
  docker run -v /host/postgres/data:/var/lib/postgresql/data postgres # Mount


## docker pull command
# to pull the image and not run the container
docker pull nginx # Pull the latest nginx image from Docker Hub
docker pull ubuntu # pull and keep the image but wont run as a container 

## docker exec command
docker exec <container_id> ls / # Execute a command in a running container by ID
docker exec mynginx ls / # Execute a command in a running container by name
docker exec -it <container_id> /bin/bash # Execute a command in a running container
docker exec -it mynginx /bin/bash # Execute a command in a running container by name
docker exec <container name> cat etc/os-release # Execute a command in a running container by name

## list containers commands
docker ps # List all running containers
docker ps -a # List all containers, including stopped ones
docker ps -q # List only container IDs
docker ps -l # Show the last created container

## docker stop and start commands
docker stop <container_id> # Stop a running container by ID
docker start <container_id> # Start a stopped container by ID
docker stop mynginx # Stop a running container by name
docker start mynginx # Start a stopped container by name

## docker rm commands
docker rm <container_id> # Remove a stopped container by ID
## docker rm mynginx # Remove a stopped container by name 
docker rm -f <container_id> # Force remove a running container by ID
## docker rm -f mynginx # Force remove a running container by name
docker rmi -f <image_id> # Force remove an image by ID
## docker rmi -f nginx # Force remove an image by name 

## docker logs command
# view logs of a container
# when you run container in detarched mode you can view the logs using docker logs command
docker logs <container_id> # View logs of a container by ID
docker logs mynginx # View logs of a container by name


## make sure to remove all dependencies before removing an image
docker images # List all Docker images on the host
docker rmi <image_id> # Remove a Docker image by ID 
docker rmi nginx # Remove the nginx image by name


## commands to clean up unused images, containers, volumes, and networks
docker system prune -f # Remove all unused data (containers, images, volumes, networks)
docker system prune -a -f # Remove all unused data, including unused images
docker volume prune -f # Remove all unused volumes
docker network prune -f # Remove all unused networks


## command vs entrypoint
# both are used to specify the command to run when a container starts
# entrypoint is preferred when you want to ensure that a specific executable is always run
# command is preferred when you want to provide default arguments that can be overridden
# if both are specified, entrypoint is run with command as its arguments
# if only command is specified, it overrides the default command in the Dockerfile
# if only entrypoint is specified, it runs the specified executable
# if neither is specified, the default command in the Dockerfile is run
docker run -it --rm ubuntu [command] # Default command is /bin/sh
docker run -it --rm ubuntu bash # Default command is bash
docker run ubuntu sleep 5 # Default command is sleep
docker run -it --rm ubuntu /bin/sh # Override command to sh


  # command is used to override the default command specified in the Dockerfile     CMD sleep 5, for example docker run ubuntu sleep 10 (overrides sleep 5 with sleep 10)
  from ubuntu
  cmd ["sleep", "5"]
  docker run -it --rm ubuntu # runs sleep 5
  docker run -it --rm ubuntu sleep 10 # runs sleep 10

  # entrypoint is used to specify the executable to run when the container starts  ENTRYPOINT ["sleep"], for example docker run ubuntu 5 (runs sleep 5, 5 is appended to entrypoint)
  from ubuntu
  entrypoint ["sleep"]
  docker run -it --rm ubuntu #error as no argument is passed to sleep
  docker run -it --rm ubuntu 5 # runs sleep 5 


  # if both are specified in the Dockerfile, entrypoint is run with command as its arguments 
  from ubuntu
  entrypoint ["sleep"]
  cmd ["5"]
  docker run -it --rm ubuntu # runs sleep 5

  # examples of overriding entrypoint and command in docker run
  docker run -it --rm --entrypoint /bin/sh ubuntu # Override the default entrypoint to sh
  docker run -it --rm --entrypoint /bin/sh ubuntu -c "echo hello world" # Override entrypoint to sh and pass command to sh


## creating docker images using dockerfile
  #docker build command
  docker build -t mynginx:latest . # Build a Docker image from a Dockerfile
  docker build -t mynginx:v1 . # Build a Docker image with a specific tag v1
  docker build -t mynginx:v2 . # Build a Docker image with a specific tag v2
  docker build -t mynginx:v3 . # Build a Docker image with a specific tag v3

  #docker history command
  # this shows the history of an image and the layers that make up the image
  # the command shows the image ID, creation date, size, and command used to create each layer
  docker history <image_id> # Show the history of an image by ID
  docker history nginx # Show the history of an image by name


  ## pushing images to docker hub
  docker login # Log in to Docker Hub
  docker tag mynginx:latest yourdockerhubusername/mynginx:latest # Tag the image with your Docker Hub username
  docker push yourdockerhubusername/mynginx:latest # Push the image to Docker Hub
  docker logout # Log out from Docker Hub

