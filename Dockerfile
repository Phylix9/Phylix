FROM tomcat:9-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY Phylix/Phylix/dist/Phylix.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
