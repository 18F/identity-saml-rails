Identity-SP
===========
[![Build Status](https://travis-ci.org/18F/identity-sp.svg?branch=master)](https://travis-ci.org/18F/identity-sp)
[![Code Climate](https://codeclimate.com/github/18F/identity-sp/badges/gpa.svg)](https://codeclimate.com/github/18F/identity-sp)
[![Test Coverage](https://codeclimate.com/github/18F/identity-sp/badges/coverage.svg)](https://codeclimate.com/github/18F/identity-sp/coverage)
[![security](https://hakiri.io/github/18F/identity-sp/master.svg)](https://hakiri.io/github/18F/identity-sp/master)

Mock service provider (SP) app for validating IdP and IdV APIs.

May also function as reference Service Provider implementation.

### Setup

    $ bundle install

### Testing

    $ bundle exec rspec

### Running

    $ bundle exec rails s

### Generating a new key + self-signed cert

    openssl req -newkey rsa:2048 -nodes -keyout config/server.key \
      -x509 -out config/server.crt -config config/openssl.conf
