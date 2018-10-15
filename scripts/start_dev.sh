#! /bin/bash

SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

mkdir -p $SCRIPT_DIR/../tmp $SCRIPT_DIR

TMP_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")"/../tmp ; pwd -P )

python3 $SCRIPT_DIR/download_repos.py $TMP_DIR

cd $SCRIPT_DIR
docker-compose build
docker-compose run image python manage.py migrate
docker-compose run image python manage.py loaddata data/db.json

docker-compose up -d
