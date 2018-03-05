#!/bin/bash -e

BUNDLE_PATH=${BUNDLE_PATH:-$SHARED_PATH/bundle}

function deploy {
  setup
  deploy_code
  cleanup

  if which npm; then
    local "npm run build > /dev/null"
  fi

  upload public/vendor.css $CURRENT_PATH/public/vendor.css
  upload public/vendor.js $CURRENT_PATH/public/vendor.js
  upload public/app.js $CURRENT_PATH/public/app.js
  upload public/app-noboot.js $CURRENT_PATH/public/app-noboot.js
  upload public/app.css $CURRENT_PATH/public/app.css
  upload public/fonts/ $CURRENT_PATH/public/fonts/
  upload public/index.html $CURRENT_PATH/public/index.html
  upload public/listing.html $CURRENT_PATH/public/listing.html

  remote "ln -sfn $SHARED_PATH/data $CURRENT_PATH/data"
  remote "ln -sfn $SHARED_PATH/database.yml $CURRENT_PATH/config/database.yml"
  remote "ln -sfn $SHARED_PATH/secrets.yml $CURRENT_PATH/config/secrets.yml"
  
  task "bundle install --without development test --path $BUNDLE_PATH --clean --quiet"
  task "RAILS_ENV=production bundle exec rake db:migrate"
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