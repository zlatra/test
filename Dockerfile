FROM nn-docker.artifactory.prd.ss.aws.insim.biz/nn-mvn-3.6-jdk-8-alpine:2122915 AS builder
WORKDIR /app
COPY pom.xml .
COPY settings.xml .
COPY src ./src
ENV MAVEN_CLI_OPTIONS "-B -e -s settings.xml -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn"
RUN mvn $MAVEN_CLI_OPTIONS versions:set -DnewVersion=1.0.0 && mvn $MAVEN_CLI_OPTIONS package

FROM nn-docker.artifactory.prd.ss.aws.insim.biz/openjdk:13-alpine
COPY --from=builder /app/target/nnip-cicd-test-1.0.0.jar /nnip-cicd-test.jar
EXPOSE 8080
CMD ["java", "-jar", "/nnip-cicd-test.jar"]
