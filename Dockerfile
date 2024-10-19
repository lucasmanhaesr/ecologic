FROM maven:3.9.9-eclipse-temurin-21-alpine AS build
RUN mkdir /opt/app
COPY . /opt/app
WORKDIR /opt/app
RUN mvn clean package -Dmaven.test.skip
FROM eclipse-temurin:21-jre-alpine
RUN mkdir /opt/app
COPY --from=build  /opt/app/target/app.jar /opt/app/app.jar
WORKDIR /opt/app
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
