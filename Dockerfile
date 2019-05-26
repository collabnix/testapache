FROM centos:latest
LABEL Vendor="CentOS"

RUN yum -y update && yum clean all
RUN yum -y install httpd && yum clean all

EXPOSE 80 81

#Simple startup script to aviod some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
RUN mkdir /etc/httpd/sites-available
RUN mkdir /etc/httpd/sites-enabled


#Copy config file across
COPY ./sites-available /etc/httpd/sites-available
COPY ./sites-enabled /etc/httpd/sites-enabled
COPY ./breakout.com.conf /etc/httpd/sites-available
COPY ./index.html /var/www/html

CMD ["/run-httpd.sh"]
