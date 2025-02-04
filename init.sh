#!/bin/bash

message () {
	# First param sets the color and must be an integer
	printf '[%s] \e[3%sm%s\e[0m\n' "$(basename $0)" "$@"
	[ $1 -eq 1 ] && exit 1 || return 0
}

dummy_env=(
	"FLASK_APP=app.py"
	"FLASK_ENV=development"
	"POSTGRES_USER=admin"
	"POSTGRES_PASSWORD=admin"
	"POSTGRES_DB=luisa"
	"API_PATH=./backend"
	"FRONT_PATH=./frontend"
)

# Create dummy .env
[ ! -f ".env" ] && message 3 ".env file not found, creating it!" \
	&& printf "%s\n" ${dummy_env[@]} >> .env \
	|| message 6 "🤔 .env file found, skipping..."

# Load the environment file
source .env

# Get submodules 
git submodule update --init --recursive \
	&& message 2 "Modules initialized! 🐙" \
	|| message 1 "Could not initialize modules 👀"

# Make the first build and run `docker-compose up`
docker-compose up --force-recreate --build -d \
	&& message 2 "docker-compose successfully ran 🐋" \
	|| message 1 "docker-compose failed 🔥"

