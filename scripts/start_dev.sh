#! /bin/bash

OPTIND=1

function build {
  cd $SCRIPT_DIR
  docker-compose build
  docker-compose run image python manage.py migrate
  docker-compose run image python manage.py loaddata data/db.json
}

function clean {
  rm -rf "$BUILD_DIR"
}

function confirm {
  read -r -p "Proceed with caution. (y/n): " continue
  if [[ "$continue" =~ ^[yY][eE][sS]|[yY]+$ ]]
  then
    return 0
  else
    echo "Aborting!"
    exit 0
  fi
}

function check_directory {
  if [ -d "$BUILD_DIR" ]
  then
    echo "This will delete the entire build directory."
    confirm
    clean
  fi
}

function download {
  check_directory
  mkdir -p $SCRIPT_DIR/../build $SCRIPT_DIR
  python3 $SCRIPT_DIR/download_repos.py $BUILD_DIR
}

function show_help {
  echo "This is not useful now. Ask Will for help or read the script."
}

SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
BUILD_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")"/../build ; pwd -P )

while getopts ":hmbruU" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;
    m)
      # Checkout and build master if no work in stage
      download
      build
      exit 0
      ;;
    b)
      #Build images from build dir
      build
      ;;
    u)
      echo "Running containers in the foreground"
      docker-compose up
      exit 0
      ;;
    U)
      echo "Running containers in the background"
      ;;
  esac
done

echo "Starting containers."
docker-compose up -d
