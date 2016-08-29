# Palais Beauharnais Catalogue

A simple database to store metadata on the interior equipment within the Palais
Beauharnais in Paris, France. This repository contains the source code for the
web application.

## License

The source code is licensed under AGPL-3.0, see [COPYING](COPYING) and
[LICENSE](LICENSE). If you are interested in receiving a snapshot of the data as
well, please contact the
[Deutsches Forum für Kunstgeschichte Paris](https://dfk-paris.org).

## Setup

To build and deploy the application nodejs and npm are required on a
workstation. On the server, an environment to run [rack](http://rack.github.io/)
applications is required. We will assume that both is already set up. Make sure
the `bundler` gem is installed on the server as well.

Clone this repository, then change into its directory. Run the following to
install dependencies via npm

    npm install

Then build the js, styles and images

    npm run build

For deployment, you will need to add a file `deploy/config.sh` and configure
some environment variables specific to your deployment:

    export REPO="."
    export HOST="myuser@myhost.example.com"
    export PORT="22"
    export DEPLOY_TO="/path/to/app"
    export BUNDLE_PATH="/path/to/bundle"
    export COMMIT="master"
    export KEEP=5

`BUNDLE_PATH` lets you configure a directory where dependencies should be
installed to. If you remove it, the default will be used
`(/path/to/app/shared/bundle).

On the server, create a directory `/path/to/app/shared` and configure the database adapter
within `shared/database.yml` and the secrets file at `config/secrets.yml`. Then,
run the deployment script on the workstation:

    ./deploy/app.sh

Then, on the serverinitialize the database within `/path/to/app/current`:

    RAILS_ENV=production bundle exec rake db:setup

The app is ready to login with username `admin` and password `admin`.

## TODO:

* widgets
* link to DFK instance and website
