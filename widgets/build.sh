#!/bin/bash -e

COMMAND=${1:-all}

RED="\e[0;31m"
GREEN="\e[0;32m"
BLUE="\e[0;34m"
LIGHTBLUE="\e[1;34m"
NOCOLOR="\e[0m"

function all {
  vendor
  tags
  index
}

function watch {
  all

  parallelshell \
    "widgets/build.sh watch_vendor" \
    "widgets/build.sh watch_tags" \
    "widgets/build.sh watch_index"
}

function server {
  cd public
  static -p 3000 -a 127.0.0.1
}

function vendor {
  log "concatenating vendor css"
  cat widgets/vendor/css/* > public/vendor.css

  log "copying other vendor assets"
  rsync -aL widgets/vendor/other/ public/

  log "combining vendor javascript"
  uglifyjs widgets/vendor/js/* -o public/vendor.js
}

function tags {
  log "compiling tags"
  node_modules/.bin/riot -s widgets/tags public/app.js
}

function index {
  log "compiling html"
  node ./widgets/build.js > public/index.html
}

function watch_vendor {
  onchange widgets/vendor -- widgets/build.sh vendor
}

function watch_tags {
  onchange widgets/tags widgets/styles -- widgets/build.sh tags
}

function watch_index {
  onchange public/ -- widgets/build.sh index
}

function log {
  TS=$(date +"%Y-%m-%d %H:%M:%S")
  MSG="$1"
  echo -e "$GREEN$TS: $MSG$NOCOLOR"
}


$COMMAND