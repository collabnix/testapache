FROM centos:latest
Maintainer vect0r
LABEL Vendor="CentOS"

RUN yum -y update && yum clean all
RUN yum -y install httpd && yum clean all

EXPOSE 80 81

#Simple startup script to aviod some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

#Copy config file across
COPY ./sites-available /etc/httpd/sites-available
COPY ./sites-enabled /etc/httpd/sites-enabled
COPY ./breakout.com.conf /etc/httpd/sites-available

CMD ["/run-httpd.sh"]