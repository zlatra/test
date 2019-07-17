FROM maven:3.6-slim AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
ENV MAVEN_CLI_OPTIONS "-B -e -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn"
RUN mvn $MAVEN_CLI_OPTIONS versions:set -DnewVersion=1.0.0 && mvn $MAVEN_CLI_OPTIONS package

FROM openjdk:13-alpine
COPY --from=builder /app/target/nnip-cicd-test-1.0.0.jar /nnip-cicd-test.jar
EXPOSE 8080
CMD ["java", "-jar", "/nnip-cicd-test.jar"]
