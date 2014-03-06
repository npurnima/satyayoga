# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Satyayoga::Application.initialize!

ActionMailer::Base.delivery_method =  :smtp

ActionMailer::Base.smtp_settings = {
    :address        => "smtp.gmail.com",
    :port           => 587,
    :domain         => "gmail.com",
    :user_name      => "piduguralla.yogaschool@gmail.com",
    :password       => "pidgyogaschool",
    :authentication => :plain,
    :enable_starttls_auto => true
}
