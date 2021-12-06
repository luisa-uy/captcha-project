#!/bin/bash

message () {
  # First param sets the color and must be an integer
  printf '[%s] \e[3%sm%s\e[0m\n' "$0" "$@"
  [ "$1" == "1" ] && exit 1 || return 0
}

api_path="backend"
dummy_env=(
  "FLASK_APP=app.py"
  "FLASK_ENV=development"
  "POSTGRES_USER=admin"
  "POSTGRES_PASSWORD=admin"
  "POSTGRES_DB=luisa"
  "API_PATH=$api_path"
)

# Get the backend project
[ -d "$api_path" ] && message 6 "🤔 $api_path directory not empty, skipping..." \
  || ( git clone git@github.com:luisa-uy/captcha-api.git $api_path \
  && message 2 "Backend repository cloned!" \
  || message 1 "Could not clone backend repository 👀" )

# Set up the environment
[ ! -f ".env" ] && message 3 ".env file not found, creating it!" \
  && printf "%s\n" ${dummy_env[@]} >> .env \
  || message 6 "🤔 .env file found, skipping..."

# Make the first build
docker-compose build \
  && message 2 "docker-compose successfully ran 🐋" \
  || message 1 "docker-compose failed 🔥"
