FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY dist/Phylix.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
