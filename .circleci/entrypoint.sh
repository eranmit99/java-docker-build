#!/bin/sh

#fetch the application version from the package.json file
PACKAGE_VERSION=$(cat package.json|grep version|head -1|awk -F: '{ print $2 }'|sed 's/[", ]//g')
java -jar app.jar $PACKAGE_VERSION