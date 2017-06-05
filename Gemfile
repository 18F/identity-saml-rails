source 'https://rubygems.org'

ruby '2.3.3'

gem 'rails', '4.2.7.1'
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'omniauth-saml'
gem 'ruby-saml'

group :deploy do
  gem 'capistrano' # , '~> 3.4'
  gem 'capistrano-passenger'
  gem 'capistrano-rails' # , '~> 1.1', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.4'
  gem 'saml_idp', git: 'https://github.com/18F/saml_idp.git', branch: 'master'
end

group :development do
  gem 'rubocop'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'sinatra'
  gem 'webmock'
end

group :production do
  gem 'rails_12factor'
end
