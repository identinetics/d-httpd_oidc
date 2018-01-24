FROM centos:centos7
LABEL maintainer="Rainer Hörbe <r2h2@hoerbe.at>" \
      version="0.1.0" \
      capabilities='--cap-drop=all'

# allow build behind firewall
ARG HTTPS_PROXY=''
ARG HTTPD_USER='apache'

RUN yum update -y \
 && yum -y install curl httpd ip lsof mod_php mod_ssl openssl net-tools \
 && yum -y install http://mirror.centos.org/centos/7/os/x86_64/Packages/mod_auth_openidc-1.8.8-3.el7.x86_64.rpm \
 && yum -y clean all \
 && chown $HTTPD_USER:$HTTPD_USER /run/httpd

COPY install/opt/bin/* /opt/bin/
RUN chmod +x /opt/bin/*
CMD /opt/bin/start.sh

VOLUME /etc/httpd/conf \
       /etc/httpd/conf.d \
       /run/httpd \
       /var/www

EXPOSE 8080

USER $HTTPD_USER
COPY REPO_STATUS  /opt/REPO_STATUS
