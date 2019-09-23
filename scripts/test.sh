#!/bin/bash

ACTUAL_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH} # Obtain actual branch if we are building under Travis
ACTUAL_BRANCH=${ACTUAL_BRANCH:-$CIRCLE_BRANCH}              # Obtain actual branch if we are building under CircleCI
DATABASE_HOST=`echo "advocatecq-$ACTUAL_BRANCH-postgres" | tr '[:upper:]' '[:lower:]'`

cat docker-compose.yml | envsubst > temp.yml
mv temp.yml docker-compose.yml
docker-compose run web bash -c 'sleep 20 && bundle exec rake db:create && bundle exec rake db:schema:load'

