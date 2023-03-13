# merchants
Demo

## How to run

docker compose build

docker compose run --rm merchants-api bin/rails db:migrate

docker compose up

If you want to fill database tables with test data, run: 

docker compose run --rm merchants-api bin/rails db:seed

## Swagger Merchants API

http://localhost:4000/api-docs/index.html

## Front-End Application

http://localhost:3000/

## Back-End Application

http://localhost:4000/