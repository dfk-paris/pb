#!/bin/bash -e

function deploy {
  setup
  deploy_code
  cleanup

  upload public/app.css $CURRENT_PATH/public/app.css
  upload public/app.js $CURRENT_PATH/public/app.js
  upload public/tags.js $CURRENT_PATH/public/tags.js
  upload public/fonts/ $CURRENT_PATH/public/fronts/

  remote "ln -sfn $SHARED_PATH/data $CURRENT_PATH/data"
  remote "ln -sfn $SHARED_PATH/database.yml $CURRENT_PATH/config/database.yml"
  remote "ln -sfn $SHARED_PATH/secrets.yml $CURRENT_PATH/config/secrets.yml"
  # Your deployment specifics go here

  finalize
}

function configure {
  source deploy/config.sh
  $1
  source deploy/lib.sh
}

configure
deploy