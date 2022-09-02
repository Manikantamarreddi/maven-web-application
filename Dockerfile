FROM maven:3.8.6-openjdk-8 as base
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:8.0.20-jre8
COPY --from=base /app/target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-application.war
WORKDIR webapps
RUN rm -rf ROOT && mv maven-web-application.war ROOT.war
