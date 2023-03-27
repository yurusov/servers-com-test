# frozen_string_literal: true

require 'pathname'
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV['HANAMI_ENV'] ||= 'test'
require 'hanami/prepare'
require 'awesome_print'
require 'rom-factory'
require 'simplecov'
require 'simplecov-lcov'

require_relative 'support/rspec'
require_relative 'support/requests'
require_relative 'support/database_cleaner'

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start

Factory = ROM::Factory.configure do |config|
  config.rom = Hanami.app['persistence.rom']
end

Dir["#{File.dirname(__FILE__)}/support/factories/*.rb"].each { |file| require file }
