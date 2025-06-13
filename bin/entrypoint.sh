#!/bin/bash -e

set -e

rm -f tmp/pids/server.pid

bundle check || bundle install

RAILS_ENV=${RAILS_ENV} bundle exec rake db:prepare

RAILS_ENV=${RAILS_ENV} bundle exec rails s -b 0.0.0.0