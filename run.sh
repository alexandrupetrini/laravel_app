#! /bin/bash
remove_all() {
    docker rm -f jenkins-docker
    docker rm -f jenkins-blueocean
    docker rm -f jenkins
    docker network rm jenkins
    docker volume rm -f jenkins-docker-certs
    docker volume rm -f jenkins-data
}

remove() {
    docker rm -f jenkins
    # docker rm -f jenkins-blueocean
    # docker rm -f jenkins-docker
}

# create_neworks() {
#     docker network create jenkins
# }

create_volumes() {
    docker volume create jenkins-docker-certs
    docker volume create jenkins-data
}

# run_docker_in_docker_with_network() {
#     docker container run \
#         --name jenkins-docker \
#         --detach \
#         --privileged \
#         --network jenkins \
#         --network-alias docker \
#         --env DOCKER_TLS_CERTDIR=$(pwd)Docker/certs \
#         --volume jenkins-docker-certs:$(pwd)/Docker/certs/client \
#         --volume jenkins-data:/var/jenkins_home \
#         --publish 2376:2376 \
#         docker:stable-dind
# }

run_jenkins() {
    # docker container run \
    #     --name jenkins \
    #     --detach \
    #     --network jenkins \
    #     --env DOCKER_HOST=tcp://docker:2376 \
    #     --env DOCKER_CERT_PATH=$(pwd)/certs/client \
    #     --env DOCKER_TLS_VERIFY=1 \
    #     --publish 8080:8080 \
    #     --publish 8083:8083 \
    #     --publish 50000:50000 \
    #     --volume jenkins-data:/var/jenkins_home \
    #     --volume jenkins-docker-certs:$(pwd)/certs/client:ro \
    #     jenkins/jenkins:lts

    docker container run \
        --name jenkins \
        --detach \
        --publish 8080:8080 \
        --publish 50000:50000 \
        --volume jenkins-data:/var/jenkins_home \
        --volume jenkins-docker-certs:$(pwd)/certs/client:ro \
        alexandrupetrini/jenkins:lts
}

remove
run_jenkins
