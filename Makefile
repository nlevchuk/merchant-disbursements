build:
		docker compose build

up:
		docker compose up

down:
		docker compose down

start:
		docker compose start

stop:
		docker compose stop

bootstrap:
		sh scripts/bootstrap.sh

console:
		docker compose exec api bin/rails console

bash:
		docker compose exec api bash
