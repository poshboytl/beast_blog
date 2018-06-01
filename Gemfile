source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'

gem 'mysql2'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'browser', '~> 2.3.0'

# ENV config
gem 'dotenv-rails'

# Photo
gem 'carrierwave', '>= 1.0.0.rc', '< 2.0'
gem 'mini_magick', '~> 4.5'
gem 'mime-types', '~> 3.1'
gem 'file_validators'

gem 'omniauth', '~> 1.6'
gem 'omniauth-github', '~> 1.2'

# pry and ap
gem 'pry'
gem 'pry-rails'
gem 'awesome_print', '~> 1.8'

# Markdown
gem 'redcarpet', '~> 3.4'
gem 'rouge', '~> 3.1', '>= 3.1.1'

# webpack
gem 'webpacker', '~> 3.3'
gem 'turbolinks', '~> 5.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Deployment
# gem 'unicorn'
gem 'mina', require: false
gem 'mina-puma', require: false
gem 'mina-multistage', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'mocha', '~> 1.2'
end

gem 'listen', '~> 3.0.5'
group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'i18n-debug'
end

# with rails 5.2 update
group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
