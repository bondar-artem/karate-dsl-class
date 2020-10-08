FROM maven:3.6.3-jdk-11

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app
COPY ./src/test/java /usr/src/app/src/test/java