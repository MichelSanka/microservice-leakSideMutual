FROM openjdk:17-slim-buster as build

COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

RUN ./mvn -B dependency:go-offline

COPY src src

RUN ./mvn -B package

FROM openjdk:17-slim-buster

COPY --from=build target/customer-self-service-backend-0.0.1-SNAPSHOT.jar .

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "customer-self-service-backend-0.0.1-SNAPSHOT.jar"]
