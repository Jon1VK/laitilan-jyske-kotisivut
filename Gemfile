source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# Use devise for authentication
gem "devise", "~> 4.8"
# Annotate db schema in model files
gem "annotate", "~> 3.1"
# Human friendly urls
gem "friendly_id", "~> 5.4"
# Adds active class to active links
gem "active_link_to", "~> 1.0"
# Add translations for strings
gem "rails-i18n", "~> 6.0"
gem "devise-i18n", "~> 1.10"
# Add admin dashboard
gem "administrate", "~> 0.16.0"
# Use Amazon S3
gem "aws-sdk-s3", "~> 1.103"
# Send and receive async updates through html 
gem "hotwire-rails", "~> 0.1.3"
# Scrape web content
gem "kimurai", "~> 1.4"
# Authorization gem
gem "pundit", "~> 2.1"
# Pagination
gem "kaminari", "~> 1.2"
# Simple HTTP requests
gem "http", "~> 5.0"
# Meta tag helpers
gem "meta-tags", "~> 2.16"


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end


group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'

  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Better error pages for development
  gem "better_errors", "~> 2.9"
  gem "binding_of_caller", "~> 1.0"
  # Better console for development
  gem "pry-rails", "~> 0.3.9"
  # Open emails in browser
  gem "letter_opener_web", "~> 1.4"
  gem "rexml", "~> 3.2"
end


group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
