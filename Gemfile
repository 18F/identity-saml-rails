source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '4.2.6'
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'omniauth-saml'

# unreleased feature via: https://github.com/onelogin/ruby-saml/pull/345
gem 'ruby-saml', git: 'https://github.com/onelogin/ruby-saml.git', branch: 'master'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.4'
  gem 'saml_idp'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
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
