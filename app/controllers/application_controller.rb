class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => "dreamingfurther", :password => "txt@1234"
  protect_from_forgery
end
