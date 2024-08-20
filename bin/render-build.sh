#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# If you're using a Free instance type, you need to
# perform database migrations in the build command.
# Uncomment the following line:

bundle exec rails db:migrate

# Check if seeding is enabled via environment variable
if [ "$SEED_DATABASE" = "true" ]; then
  echo "Seeding the database..."
  bundle exec rails db:seed
else
  echo "Skipping database seeding."
fi