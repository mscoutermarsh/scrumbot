source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

gem 'better_errors'
gem 'devise'
gem 'omniauth'
gem 'slim-rails'
gem 'fog', '~> 1.3.1'
gem 'sidekiq'
gem 'sinatra'
gem 'omniauth-google-oauth2'
gem 'github_api'
gem 'multimap'
gem 'rest-client'
gem 'zip'
gem 'wicked'

gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails'



# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'sass-rails', '~> 4.0.0'  


# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

group :assets do
  gem "compass-rails"
end

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'spork-rails', :github => 'sporkrb/spork-rails'
  gem 'rspec-rails', '~> 2.0'
  gem 'shoulda-matchers'
  gem 'guard'
  gem 'guard-puma'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-sidekiq'
  gem 'listen'
  gem 'growl'
  gem 'fuubar'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', '1.3.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
end

gem 'puma'

# Use debugger
gem 'debugger', group: [:development, :test]
