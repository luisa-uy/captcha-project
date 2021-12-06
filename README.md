# LUISA Captcha Project™ GLUE 💁

## About
This project exists to coordinate all the pieces of the LUISA Captcha Project.

## ENV Settings
For this to work, you must create a `.env` file with the following iniformation:
```
POSTGRES_USER=$user
POSTGRES_PASSWORD=$password
POSTGRES_DB=$database_name
API_PATH=$api_path
```

A Postgres 🐘 database will be created with those credentials, and the [captcha-api](https://github.com/luisa-uy/captcha-api) project will be initialized from the provided `$API_PATH`, connected to that database.

## Usage

With the `.env` file in place, `cd` to the root folder of this project and run
```
docker-compose up --force-recreate --build -d
```

Check the running containers with `docker ps`, or get inside a container with
```
docker exec -it $container $command

docker exec -it luisa-captcha-api bash # API
docker exec -it luisa-captcha-postgres psql -U$POSTGRES_USER -d$POSTGRES_DATABASE # pg database
```

You can also check the logs for the containers with
```
docker logs --tail 50 $container_id`
```

Finally, to stop all the containers run
```
docker-compose down
```


