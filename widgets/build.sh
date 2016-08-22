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
  cat \
    widgets/vendor/skeleton/normalize.css \
    widgets/vendor/skeleton/skeleton.css \
    widgets/vendor/font-awesome/font-awesome.min.css \
    widgets/vendor/auto-complete/auto-complete.css \
    widgets/vendor/dropzone/dropzone.css \
    > public/app.css

  log "copying vendor assets"
  rsync -a widgets/vendor/font-awesome/fonts/ public/fonts/

  log "combining vendor javascript"
  uglifyjs \
    node_modules/zepto/dist/zepto.min.js \
    node_modules/riot/riot.min.js \
    widgets/vendor/auto-complete/auto-complete.min.js \
    widgets/vendor/dropzone/dropzone.js \
    widgets/vendor/jquery.easyModal.js \
    -o public/app.js
}

function tags {
  log "compiling tags"
  node_modules/.bin/riot -s widgets/tags public/tags.js
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