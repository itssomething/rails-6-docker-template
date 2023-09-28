#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

if [[ "$BOOTSTRAP" = "true" ]]; then
  # bundle check || bundle install
  bundle exec rake db:drop
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:seed
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
