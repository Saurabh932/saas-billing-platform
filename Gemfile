source "https://rubygems.org"

gem "rails", "~> 8.1.3"
gem "propshaft"
gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "thruster", require: false
gem "image_processing", "~> 1.2"

# Auth
gem "devise"

# Background jobs
gem "sidekiq"

# Payments
gem "pay"
gem "stripe"

# API
gem "rack-cors"

# React frontend
gem "jbuilder"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Multi-tenancy
gem "acts_as_tenant"

# Caching
gem "solid_cache"
gem "solid_cable"

# Code quality
gem "rubocop-rails-omakase", require: false

gem "importmap-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "dotenv-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
end


gem "ostruct"
