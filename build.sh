#!/bin/bash -e

function all {
  static
}

function watch {
  watch_tags
}

function static {
  cat \
    widgets/vendor/skeleton/normalize.css \
    widgets/vendor/skeleton/skeleton.css \
    widgets/vendor/font-awesome/font-awesome.min.css \
    widgets/vendor/auto-complete/auto-complete.css \
    widgets/vendor/dropzone/dropzone.css \
    > public/app.css

  rsync -a widgets/vendor/font-awesome/fonts/ public/fonts/

  uglifyjs \
    node_modules/zepto/dist/zepto.min.js \
    node_modules/riot/riot.min.js \
    widgets/vendor/auto-complete/auto-complete.min.js \
    widgets/vendor/dropzone/dropzone.js \
    widgets/vendor/jquery.easyModal.js \
    -o public/app.js
}

# function tags {
#   node_modules/.bin/riot --colors widgets/tags public/tags.js
# }

function watch_tags {
  node_modules/.bin/riot --colors --watch widgets/tags public/tags.js
}

$1