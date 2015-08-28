source 'https://rubygems.org'

gem 'rails', '4.2.3'

# Transitland Datastore components
path 'components' do
  gem 'datastore_admin'
end

# external Transitland libraries
gem 'transitland_client', github: 'transitland/transitland-ruby-client', tag: 'v0.0.6', require: 'transitland_client'

# process runner
gem 'foreman', group: :development

# configuration
gem 'figaro'

# data stores
gem 'pg'
gem 'activerecord-postgis-adapter', '3.0.0'
gem 'redis-rails'

# background processing
gem 'sidekiq'
gem 'sidekiq-unique-jobs'
gem 'whenever', require: false # to manage crontab

# data model
gem 'squeel'
gem 'enumerize'
gem 'gtfs'
gem 'rgeo-geojson'
gem 'c_geohash', require: 'geohash'
gem 'json-schema'

# authentication and authorization
gem 'rack-cors', require: 'rack/cors'
gem 'omniauth'
gem 'omniauth-osm'

# providing API
gem 'active_model_serializers', '0.9.3'
gem 'oj'

# consuming other APIs
gem 'faraday'

# development tools
gem 'better_errors', group: :development
gem 'binding_of_caller', group: :development
gem 'byebug', group: [:development, :test]
gem 'pry-byebug', group: [:development, :test]
gem 'pry-rails', group: [:development, :test]

# code coverage and documentation
gem 'rails-erd', group: :development
gem 'annotate', group: :development
gem 'simplecov', :require => false, group: [:development, :test]

# testing
gem 'database_cleaner', group: :test
gem 'factory_girl_rails', group: [:development, :test]
gem 'ffaker', group: [:development, :test]
gem 'rspec-rails', group: [:development, :test]
gem 'vcr', group: :test
gem 'webmock', group: :test
gem 'airborne', group: :test
gem 'mock_redis', group: :test # used by sidekiq-unique-jobs

# deployment and monitoring
gem 'aws-sdk', group: [:staging, :production]
gem 'sentry-raven', group: [:staging, :production]
gem 'bullet', group: :development

# web server
gem 'unicorn', group: [:staging, :production]
