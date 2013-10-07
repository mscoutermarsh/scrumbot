require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Scrumlogs
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    
    config.action_mailer.smtp_settings = {
        address:   "smtp.mandrillapp.com",
        port:      587, # ports 587 and 2525 are also supported with STARTTLS
        enable_starttls_auto: true, # detects and uses STARTTLS
        user_name: ENV['MANDRILL_USER'],
        password:  ENV['MANDRILL_PASS'], # SMTP password is any valid API key
        authentication: 'login', # Mandrill supports 'plain' or 'login'
        domain: ENV['MANDRILL_DOMAIN'], # your domain to identify your server when connecting
    }
  end
end
