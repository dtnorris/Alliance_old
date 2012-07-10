# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Alliance::Application.initialize!

# Configuration for using SendGrid on Heroku
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "app5517757@heroku.com",
  :password => "qcz0510c",
  :domain => "staging.freelanceful.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
