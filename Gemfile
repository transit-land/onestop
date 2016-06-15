source 'https://rubygems.org'

gem 'rails', '4.2.6'

# Transitland Datastore components
path 'components' do
  gem 'datastore_admin'
end

# process runner
gem 'foreman', group: :development

# configuration
gem 'figaro'

# data stores
gem 'pg'
gem 'activerecord-postgis-adapter'
gem 'activerecord-import'
gem 'redis-rails'

# background processing
gem 'sidekiq', '< 5'
gem 'sidekiq-unique-jobs'
gem 'sidekiq-limit_fetch'
gem 'whenever', require: false # to manage crontab

# data model
gem 'squeel'
gem 'enumerize'
gem 'gtfs', github: 'transitland/gtfs', tag: '4f99e646ed51763f318310ee4d5fc48d06e3402b'
gem 'rgeo-geojson'
gem 'c_geohash', require: 'geohash'
gem 'json-schema', '2.5.2' # running into problems with 2.6.0
gem 'email_validator'

# text matching
gem 'text'

# authentication and authorization
gem 'rack-cors', require: 'rack/cors'
gem 'devise'

# providing API
gem 'active_model_serializers', '0.9.5'
gem 'oj'
gem 'oj_mimic_json'

# consuming other APIs
gem 'faraday'

# file attachments
gem 'fog-aws', group: [:staging, :production]
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave', ref: '49fdad1'
# using a development version of carrierwave in order to only
# load fog-aws, rather than the entire fog library
# https://github.com/carrierwaveuploader/carrierwave/issues/1698

# development tools
gem 'better_errors', group: :development
gem 'binding_of_caller', group: :development
gem 'byebug', group: [:development, :test]
gem 'pry-byebug', group: [:development, :test]
gem 'pry-rails', group: [:development, :test]
gem 'pry-rescue', group: [:development, :test]
gem 'pry-stack_explorer', group: [:development, :test]
gem 'rubocop', require: false, group: [:development, :test]
gem 'rubocop-rspec', require: false, group: [:development, :test]

# code coverage and documentation
gem 'rails-erd', group: :development
gem 'annotate', group: :development
gem 'simplecov', require: false, group: [:development, :test]

# testing
gem 'database_cleaner', group: :test
gem 'factory_girl_rails', require: false, group: [:development, :test]
gem 'ffaker', group: [:development, :test]
gem 'rspec-rails', group: [:development, :test]
gem 'rspec-sidekiq', group: :test
gem 'vcr', group: :test
gem 'webmock', group: :test
gem 'airborne', group: :test
gem 'mock_redis', group: :test # used by sidekiq-unique-jobs
gem 'timecop', group: :test
gem 'rspec_junit_formatter', '0.2.2', group: :test
# ^ for CircleCI: https://circleci.com/docs/test-metadata#rspec

# deployment
gem 'aws-sdk', group: [:staging, :production]

# exception monitoring
gem 'sentry-raven', group: [:staging, :production]

# logging
gem 'logstasher'
gem 'sidekiq-logging-json'
gem 'ruby-progressbar'

# database query performance monitoring/analysis
gem 'bullet', group: :development
gem 'pghero', group: [:development, :staging, :production] # mounted at /admin/postgres
gem 'marginalia', group: [:development, :staging]

# web server
gem 'unicorn', group: [:staging, :production]
