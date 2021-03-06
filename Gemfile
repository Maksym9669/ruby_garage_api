# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rswag', '~> 2.3', '>= 2.3.1'
gem 'json-schema', '~> 2.8', '>= 2.8.1'
gem 'faker', '~> 2.12'
gem 'carrierwave', '~> 2.0'
gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
gem "pundit"
gem 'devise', '~> 4.2'
gem 'devise-jwt', '~> 0.7.0'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'simplecov', '~> 0.18.5'
gem 'brakeman', '~> 4.8', '>= 4.8.2'
gem 'rubocop', '~> 0.85.1', require: false
gem 'rails-i18n', '~> 6.0'
gem 'file_validators'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
gem 'rspec-rails', '~> 4.0', '>= 4.0.1'
gem 'database_cleaner-active_record'
gem 'shoulda-matchers', '~> 4.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
end

group :development do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
