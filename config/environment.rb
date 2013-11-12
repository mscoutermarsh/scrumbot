# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load application ENV variables (credentials). Not included in Repo.
app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

Scrumlogs::Application.configure do
  config.action_mailer.smtp_settings = {
    address:   "smtp.mandrillapp.com",
    port:      587, # ports 587 and 2525 are also supported with STARTTLS
    enable_starttls_auto: true, # detects and uses STARTTLS
    user_name: ENV['MANDRILL_USER'],
    password:  ENV['MANDRILL_PASS'], # SMTP password is any valid API key
    authentication: 'login', # Mandrill supports 'plain' or 'login'
    domain: ENV['MANDRILL_DOMAIN'], # your domain to identify your server when connecting
  }
  ActionMailer::Base.delivery_method = :smtp
end

# Initialize the Rails application.
Scrumlogs::Application.initialize!
