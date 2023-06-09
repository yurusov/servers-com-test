# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-router', '~> 2.0'
gem 'hanami-validations', '~> 2.0'

gem 'dry-types', '~> 1.0', '>= 1.6.1'
gem 'puma'
gem 'rake'

gem 'pg'
gem 'rom', '~> 5.3'
gem 'rom-factory'
gem 'rom-sql', '~> 3.6'
gem 'sequel_pg'

gem 'net-ping'
gem 'parallel'

group :test do
  gem 'coverage-badge'
  gem 'database_cleaner-sequel'
  gem 'simplecov'
end

group :development, :test do
  gem 'dotenv'
  gem 'rubocop'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

group :cli, :development do
  gem 'hanami-reloader'
end

group :cli, :development, :test do
  gem 'awesome_print'
  gem 'hanami-rspec'
end

group :development do
  gem 'guard-puma', '~> 0.8'
end

group :test do
  gem 'rack-test'
end
