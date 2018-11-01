#! /bin/bash

OPTIND=1

function build {
  "Building the Docker images and applying test data."
  cd $SCRIPT_DIR
  /usr/local/bin/docker-compose build
  /usr/local/bin/docker-compose run image python manage.py migrate
  /usr/local/bin/docker-compose run image python manage.py loaddata data/db.json
}

function clean {
  echo "Cleaning the build directory."
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

function clean_download {
  check_directory
  clean
  mkdir -p $SCRIPT_DIR/../build $SCRIPT_DIR
  download
}

function download {
  echo "Downloading repositories."
  python3 $SCRIPT_DIR/download_repos.py $BUILD_DIR
}

function show_help {
  echo "This is not useful now. Ask Will for help or read the script."
}

# This is the directory that the script is located in.
SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# If the build directory does not exist create it and set the BUILD_DIR variable.
[ -d ${SCRIPT_DIR}/../build ] || mkdir ${SCRIPT_DIR}/../build
BUILD_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")"/../build ; pwd -P )

while getopts ":hmdbruU" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;
    m)
      # Checkout and build master if no work in stage
      clean_download
      build
      exit 0
      ;;
    d)
      #Download the images
      download
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
