ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'database_cleaner'
require 'webmock/rspec'
require 'ffaker'
require 'byebug'

require 'simplecov'
SimpleCov.start 'rails'
SimpleCov.coverage_dir(File.join("..", "..", "..", ENV['CIRCLE_ARTIFACTS'], "coverage")) if ENV['CIRCLE_ARTIFACTS']

ActiveRecord::Migration.maintain_test_schema!

Capybara.app_host = "http://localhost:3030"
Capybara.server_port = 3030
# Note that this port is on the Sauce Connect list of ports to proxy by default
# https://docs.saucelabs.com/reference/sauce-connect/#can-i-access-applications-on-localhost-

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation, { except: %w[spatial_ref_sys] }
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before(:each) do
    # TODO: sign out current user
    DatabaseCleaner.clean
  end

  config.before(:each, type: :feature) do
    Capybara.reset!
  end
end
