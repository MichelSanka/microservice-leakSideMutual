FROM openjdk:17-slim-buster as build

COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

#RUN ./mvnw -B dependency:go-offline
RUN ./mvn -B dependency:go-offline

COPY src src

#RUN ./mvnw -B package
RUN ./mvn -B package

FROM openjdk:17-slim-buster

COPY --from=build target/customer-core-0.0.1-SNAPSHOT.jar .

EXPOSE 8110

ENTRYPOINT ["java", "-jar", "customer-core-0.0.1-SNAPSHOT.jar"]
