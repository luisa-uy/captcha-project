#!/bin/bash

message () {
	# First param sets the color and must be an integer
	printf '[%s] \e[3%sm%s\e[0m\n' "$(basename $0)" "$@"
	[ $1 -eq 1 ] && exit 1 || return 0
}

api_path="backend"
front_path="frontend"
dummy_env=(
	"FLASK_APP=app.py"
	"FLASK_ENV=development"
	"POSTGRES_USER=admin"
	"POSTGRES_PASSWORD=admin"
	"POSTGRES_DB=luisa"
	"API_PATH=$api_path"
	"FRONT_PATH=$front_path"
)

# Get the frontend project
[ -d "$front_path" ] && message 6 "🤔 $front_path directory not empty, skipping..." \
	|| ( git clone git@github.com:luisa-uy/captcha-frontend.git $front_path \
	&& message 2 "Frontend repository cloned!" \
	|| message 1 "Could not clone frontend repository 👀" )

# Get the backend project
[ -d "$api_path" ] && message 6 "🤔 $api_path directory not empty, skipping..." \
	|| ( git clone git@github.com:luisa-uy/captcha-api.git $api_path \
	&& message 2 "Backend repository cloned!" \
	|| message 1 "Could not clone backend repository 👀" )

# Set up the environment
[ ! -f ".env" ] && message 3 ".env file not found, creating it!" \
	&& printf "%s\n" ${dummy_env[@]} >> .env \
	|| message 6 "🤔 .env file found, skipping..."

# Make the first build and run `docker-compose up`
docker-compose build && \
docker-compose up -d \
	&& message 2 "docker-compose successfully ran 🐋" \
	|| message 1 "docker-compose failed 🔥"


