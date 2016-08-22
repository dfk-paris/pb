#!/bin/bash -e

BUNDLE_PATH=${BUNDLE_PATH:-$SHARED_PATH/bundle}

function deploy {
  setup
  deploy_code
  cleanup

  npm run build

  upload public/app.css $CURRENT_PATH/public/app.css
  upload public/app.js $CURRENT_PATH/public/app.js
  upload public/tags.js $CURRENT_PATH/public/tags.js
  upload public/fonts/ $CURRENT_PATH/public/fonts/
  upload public/index.html $CURRENT_PATH/public/index.html

  remote "ln -sfn $SHARED_PATH/data $CURRENT_PATH/data"
  remote "ln -sfn $SHARED_PATH/database.yml $CURRENT_PATH/config/database.yml"
  remote "ln -sfn $SHARED_PATH/secrets.yml $CURRENT_PATH/config/secrets.yml"
  
  within_do $CURRENT_PATH "bundle install --without development test --path $BUNDLE_PATH"
  remote "touch $CURRENT_PATH/tmp/restart.txt"

  finalize
}

function configure {
  source deploy/config.sh
  $1
  source deploy/lib.sh
}

configure
deploy