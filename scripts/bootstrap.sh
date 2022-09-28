#!/usr/bin/env bash

docker compose exec api rake db:create

docker compose exec api bin/rails db:migrate

docker compose exec api bin/rails db:populate
