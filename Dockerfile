# https://github.com/xmlio/exist
FROM java:latest 
MAINTAINER Anthony Frey <anthony@requestresponse.com>

RUN apt-get update
RUN apt-get install -y curl expect

WORKDIR /tmp
RUN curl -L -o eXist-db-setup-latest.jar http://sourceforge.net/projects/exist/files/latest/download?source=files

ADD exist-setup.cmd /tmp/exist-setup.cmd
RUN expect -f exist-setup.cmd
RUN rm eXist-db-setup-latest.jar exist-setup.cmd
RUN sed -e "s/\"\${JAVA_RUN/exec \"\${JAVA_RUN/" -i /opt/exist/bin/startup.sh

VOLUME /opt/exist-data

EXPOSE 8080 8443
ENV EXIST_HOME /opt/exist
WORKDIR /opt/exist
CMD ["/opt/exist/bin/startup.sh"]