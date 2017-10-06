#!/bin/bash
# This script will build the project.

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo -e "Build Pull Request #$TRAVIS_PULL_REQUEST => Branch [$TRAVIS_BRANCH]"
  ./gradlew -PreleaseMode=pr build
elif [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_TAG" == "" ]; then
  echo -e 'Build Branch with Snapshot => Branch ['$TRAVIS_BRANCH']'
  ./gradlew -PreleaseMode=branch -PbintrayUser="${bintrayUser}" -PbintrayKey="${bintrayKey}" -PsonatypeUsername="${sonatypeUsername}" -PsonatypePassword="${sonatypePassword}" build --stacktrace
elif [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_TAG" != "" ]; then
  echo -e 'Build Branch for Release => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']'
  ./gradlew -PreleaseMode=full -PbintrayUser="${bintrayUser}" -PbintrayKey="${bintrayKey}" -PsonatypeUsername="${sonatypeUsername}" -PsonatypePassword="${sonatypePassword}" build --stacktrace
else
  echo -e 'WARN: Should not be here => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']  Pull Request ['$TRAVIS_PULL_REQUEST']'
fi