# frozen_string_literal: true

source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft", "~> 1.1"
# Use postgres as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 7.1"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails", "~> 1.3"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 2.0"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder", "~> 2.13"

# authentication and authorization
gem "bcrypt", "~> 3.1.20"
gem "devise", "~> 4.9"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cable", "~> 3.0"
gem "solid_cache", "~> 1.0.10"
gem "solid_queue", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.19", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", "~> 2.8", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", "~> 0.1", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.14"

# ui
gem "chartkick", "~> 5.2"
gem "enum_help"
gem "groupdate", "~> 6.7"
gem "pagy", "~> 9.4"
gem "ransack"
gem "tailwindcss-rails", "~> 4.4"
gem "view_component", "~> 4.1.1"

# authorization
gem "pundit"

# money
gem "money-rails"

# sentry
gem "sentry-rails", "~> 6.1"
gem "sentry-ruby", "~> 6.1"
gem "stackprof"

# aws
gem "aws-sdk-rails", "~> 5.1"
gem "aws-sdk-s3", "~> 1.204"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "~> 7.1.0", require: false

  gem "bundler-audit", require: false

  gem "factory_bot_rails"
  gem "faker"

  gem "foreman", "~> 0.90"

  gem "i18n-tasks", "~> 1.1"

  gem "pundit-matchers", "~> 4.0"

  gem "rails-controller-testing"
  gem "rspec-rails"

  gem "rubocop", "~> 1.81.0", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", "~> 2.28.0", require: false
  gem "rubocop-i18n", require: false
  gem "rubocop-md", require: false
  gem "rubocop-performance", "~> 1.26.0", require: false
  gem "rubocop-rails", "~> 2.34.0", require: false
  gem "rubocop-rspec", "~> 3.8.0", require: false
  gem "rubocop-rspec_rails", "~> 2.32.0", require: false
  gem "rubocop-thread_safety", require: false

  gem "shoulda-matchers", "~> 7.0"
  gem "simplecov", require: false
end

group :development do
  gem "ruby-lsp-rspec", require: false
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver", "~> 4.35"
end
