# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load application ENV variables (credentials). Not included in Repo.
app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the Rails application.
Scrumlogs::Application.initialize!
