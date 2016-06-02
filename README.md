Identity-SP
===========

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
