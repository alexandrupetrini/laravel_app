FROM jenkins/jenkins:lts
COPY Docker/jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
# COPY ./Docker/certs/client/client.cert /var/lib/jenkins/cert
# COPY ./Docker/certs/client/client.key /var/lib/jenkins/pk
# ENV JENKINS_OPTS --httpPort=-1 --httpsPort=8083 --httpsCertificate=/var/lib/jenkins/cert --httpsPrivateKey=/var/lib/jenkins/pk
# EXPOSE 8083
