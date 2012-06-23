source 'https://rubygems.org'

gem 'rails'
gem 'sqlite3'

gem 'sqlite3'
gem 'pg', '0.12.2'
gem 'jquery-rails'
gem 'haml-rails'
gem 'simple_form'
#gem 'twitter-bootstrap-rails'
gem 'bootstrap-sass'
gem 'decent_exposure'

group :assets do
  gem 'execjs'
  gem 'therubyracer', :platforms => :ruby
  #gem 'sass-rails',   '~> 3.2.3'
  #gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  #gem 'linecache19', '0.5.13'
  #gem 'ruby-debug-base19x', '0.11.30.pre10'
  #gem 'ruby-debug-base19', '0.11.25'
  #gem 'ruby-debug19' #, :require => 'ruby-debug'

  gem 'debugger'
  gem "rails_best_practices"
  gem 'factory_girl_rails', '~> 2.0'
  gem 'sqlite3'
  gem 'simplecov', require: false
  gem 'database_cleaner'

  gem "rspec-rails"
  gem 'rspec-instafail'

  gem 'factory_girl_rails', '~> 2.0'
 
  gem "cucumber-rails", require: false

  gem "capybara"
  #gem 'capybara-webkit', '0.11.0'
  gem "selenium-webdriver"
  gem 'launchy' # provides save_and_open_page

  gem 'rantly'
end

group :test do
  gem "cucumber-rails"
  gem 'database_cleaner'
end