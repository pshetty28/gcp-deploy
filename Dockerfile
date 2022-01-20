FROM maven:3.8.4-jdk-11-slim AS build  
COPY . /usr/src/app/  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean install

FROM gcr.io/distroless/java  
COPY --from=build /usr/src/app/target/spring-boot-web.jar /usr/app/spring-boot-web.jar  
EXPOSE 8080  
ENTRYPOINT ["java","-jar","/usr/app/spring-boot-web.jar"]  