Identity-SP
===========
[![Build Status](https://travis-ci.org/18F/identity-sp-rails.svg?branch=master)](https://travis-ci.org/18F/identity-sp-rails)
[![Code Climate](https://codeclimate.com/github/18F/identity-sp-rails/badges/gpa.svg)](https://codeclimate.com/github/18F/identity-sp-rails)
[![Test Coverage](https://codeclimate.com/github/18F/identity-sp-rails/badges/coverage.svg)](https://codeclimate.com/github/18F/identity-sp-rails/coverage)
[![security](https://hakiri.io/github/18F/identity-sp-rails/master.svg)](https://hakiri.io/github/18F/identity-sp-rails/master)

Mock service provider (SP) app for validating IdP and IdV APIs.

May also function as reference Service Provider implementation.

### Setup

    $ bundle install

### Setup (on cloud.gov)
    $ cf target -o consumer-identity -s [dev or demo]
    $ cf create-service rds shared-psql id-sp-rails_production-[dev or demo]
    $ cf bind-service identity-sp-rails-[dev or demo] mid-sp-rails_production-[dev or demo]
    $ cf restage identity-sp-rails-[dev or demo]

    then
    $ cf push -f task_manifest.yml (file needs to be edited for -dev)
    $ cf delete task-runner

    (see, for reference https://docs.cloud.gov/apps/databases/ and https://docs.cloud.gov/getting-started/one-off-tasks/)

### Deploy to login.gov lower envs
    $ cap [demo, dev, or tf] deploy
    $ cap -T # for a list of available capistrano tasks

### Testing

    $ make test

### Running

    $ SAML_ENV=local make run

### Running (on cloud.gov)

    $ bin/cloud_deploy [dev or demo]
    (Note: You'll need to be logged into cloud.gov first)

### Generating a new key + self-signed cert

    openssl req -newkey rsa:2048 -nodes -keyout config/server.key \
      -x509 -out config/server.crt -config config/openssl.conf
