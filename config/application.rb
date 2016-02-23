require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TransitlandDatastore
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.enabled = false

    # https://github.com/carrierwaveuploader/carrierwave/issues/1576
    config.active_record.raise_in_transactional_callbacks = true

    # e-mail
    HOST = 'mapzen.com' # TODO: change to 'transit.land'
    config.action_mailer.default_url_options = { host: HOST }
    if Rails.env.development?
      # Send mail to mailcatcher gem
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = {
        address: "localhost",
        port: 1025
      }
      config.action_mailer.raise_delivery_errors = false
    elsif Rails.env.test?
      # Tell Action Mailer not to deliver emails to the real world.
      # The :test delivery method accumulates sent emails in the
      # ActionMailer::Base.deliveries array.
      config.action_mailer.delivery_method = :test
    elsif Rails.env.staging? || Rails.env.production?
      # Ignore bad email addresses and do not raise email delivery errors.
      # Set this to true and configure the email server for immediate delivery to raise delivery errors.
      # config.action_mailer.raise_delivery_errors = false

      # use Mandrill to send e-mail
      config.action_mailer.smtp_settings = {
          address: "smtp.mandrillapp.com",
          port: 587,
          enable_starttls_auto: true,
          user_name: Figaro.env.mandrill_user_name,
          password: Figaro.env.mandrill_password,
          authentication: :plain,
          domain: HOST
        }
    end
  end
end
