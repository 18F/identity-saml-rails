source 'https://rubygems.org'

ruby '~> 2.3.5'

gem 'pg'
gem 'rails', '~> 5.1.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.7'
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
  gem 'bummr', require: false
  gem 'reek'
  gem 'rubocop'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'sinatra', '>= 2.0.2'
  gem 'webmock'
end

group :production do
  gem 'rails_12factor'
end
