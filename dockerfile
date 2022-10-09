ARG BUILD_DIR="/home/app"

#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build

ARG BUILD_DIR

WORKDIR ${BUILD_DIR}
COPY src src
COPY pom.xml pom.xml
COPY package.json package.json

COPY .circleci/entrypoint.sh entrypoint.sh


RUN mvn -f pom.xml clean package

#
# Package stage
#
FROM amazoncorretto:17

ARG BUILD_DIR
ARG COMMIT_HASH

ENV COMMIT_HASH=${COMMIT_HASH} \
  APP_NAME="enrichment-service" \
  ENV="production"

LABEL commit=${COMMIT_HASH}

WORKDIR "/usr/local/lib"

COPY --from=build $BUILD_DIR/target/docker-build3-1.0-SNAPSHOT.jar app.jar
COPY --from=build $BUILD_DIR/entrypoint.sh entrypoint.sh
COPY --from=build $BUILD_DIR/package.json package.json

ENTRYPOINT "./entrypoint.sh"







