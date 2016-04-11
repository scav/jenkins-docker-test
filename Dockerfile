############################################################
# Simple image to test Jenkins ability to build in docker. #
############################################################

FROM alpine
MAINTAINER Dag Heradstveit <dagherad@gmail.com>

# Install dependencies
RUN apk upgrade --update --no-cache && apk add libstdc++ bash git openssh openjdk8

# Disable root, add jenkins user and create host keys
RUN passwd -d root && \
    adduser -D -s /bin/ash jenkins && \
    #passwd -u jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    chown -R jenkins:jenkins /home/jenkins && \
    mkdir /var/jenkins_home && \
    chown -R jenkins /var/jenkins_home && \
    ssh-keygen -A

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]

