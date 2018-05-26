#!/bin/sh

docker-compose stop railsbb_app railsbb_postgres railsbb_nginx

docker-compose build

rm -rf postgres

docker-compose up -d railsbb_postgres

docker-compose run --rm railsbb_app ./bin/setup

docker-compose stop railsbb_postgres

echo "Setup completed"
