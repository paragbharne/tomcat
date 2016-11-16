FROM ubuntu:14.04
MAINTAINER Parag Bharne

RUN apt-get update 
RUN apt-get install -y default-jdk
#RUN apt-get install -y tomcat8
#RUN apt-get install -y tomcat8-docs && tomcat8-examples && tomcat8-admin
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

RUN mkdir /opt/tomcat
ADD /tomcat /opt/tomcat
RUN chgrp -R tomcat /opt/tomcat/conf
RUN chmod g+rwx /opt/tomcat/conf
RUN chmod g+r /opt/tomcat/conf/ *

RUN chown -R tomcat /opt/tomcat/work/ 
RUN chown -R tomcat /opt/tomcat/temp/
RUN chown -R tomcat /opt/tomcatlogs/

ADD tomcat.conf /etc/init/

EXPOSE 8080

ENTRYPOINT initctl start tomcat
