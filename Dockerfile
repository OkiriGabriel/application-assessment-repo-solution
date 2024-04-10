FROM eclipse-temurin:21-jdk-jammy as base
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:resolve
COPY src ./src

FROM base as development
CMD ["./mvnw", "spring-boot:run", "-Dspring-boot.run.profiles=mysql", "-Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000'"]

FROM base as build
RUN ./mvnw package


FROM eclipse-temurin:21-jre-jammy as production
EXPOSE 8080
COPY --from=build /app/target/spring-petclinic-*.war /spring-petclinic.war
CMD ["java", "-jar", "/spring-petclinic.war"]


