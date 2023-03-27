# frozen_string_literal: true

require 'pathname'
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV['HANAMI_ENV'] ||= 'test'
require 'hanami/prepare'
require 'awesome_print'
require 'rom-factory'
require 'simplecov'
require 'coverage/badge'

require_relative 'support/rspec'
require_relative 'support/requests'
require_relative 'support/database_cleaner'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::SimpleFormatter,
                                                                 SimpleCov::Formatter::HTMLFormatter,
                                                                 Coverage::Badge::Formatter
                                                               ])

SimpleCov.start

Factory = ROM::Factory.configure do |config|
  config.rom = Hanami.app['persistence.rom']
end

Dir["#{File.dirname(__FILE__)}/support/factories/*.rb"].each { |file| require file }
