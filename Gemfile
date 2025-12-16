source 'https://rubygems.org'

ruby '3.3.8'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.6'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '>= 1.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'activerecord-import', '~> 2.2'
gem 'mysql2', '~> 0.5.7'

gem 'react-rails', '= 3.2'
gem 'shakapacker', '= 9.4'

# Currently there is a bug on connection_pool 3.x with Rails 7.1 ref https://github.com/mperham/connection_pool/issues/210
gem 'connection_pool', '<3.0'

gem 'kaminari', '~> 1.2', '>= 1.2.2'
gem 'redis', '~> 5.4', '>= 5.4.1'
gem 'rubocop', '~> 1.81', '>= 1.81.7'
gem 'rubocop-rails', '~> 2.34', '>= 2.34.2'
gem 'sassc-rails'
gem 'sidekiq'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails', '~> 6.5', '>= 6.5.1'
  gem 'pry-rails', '~> 0.3.11'
  gem 'rspec-rails', '~> 7.0'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
end

group :test do
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'shoulda-matchers', '~> 7.0', '>= 7.0.1'
end

gem 'rspec-sidekiq', '~> 5.2'
