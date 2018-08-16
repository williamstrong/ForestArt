#! /bin/sh

production() {
  # Prod
  # Create docker-compose.yml from docker-compose/docker-compose_prod.yml

  cp docker-compose/docker-compose_prod.yml docker-compose.yml
  cp -p nginx/config/root_prod.conf nginx/nginx.conf

  docker-compose up -d

}

case $1 in
  -d | --dev)  # Development mode
    development
    ;;
  -p | --prod) # Production mode.
    production
    ;;
  *)
    production
    ;;
esac
