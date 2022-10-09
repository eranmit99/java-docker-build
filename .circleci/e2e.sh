#!/bin/sh

TEST_DIR="src/test/java/e2e/docker-compose.yml"

cd ..

docker-compose -f "$TEST_DIR" up
mvn test
docker-compose -f "$TEST_DIR" down

