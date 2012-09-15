source 'https://rubygems.org'

gem 'rails',   '~> 3.2.3'
gem 'jquery-rails'
gem 'haml-rails'
gem 'simple_form'
gem 'decent_exposure'
gem "devise", :git => "git://github.com/plataformatec/devise.git"
gem 'cancan'
gem 'prawn'
gem 'ransack'
gem 'will_paginate', '> 3.0'
gem 'best_in_place'

group :assets do
  gem 'execjs'
  gem 'therubyracer', :platforms => :ruby
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  #gem 'bootstrap-sass'
  gem 'twitter-bootstrap-rails'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'debugger'
  gem 'rails_best_practices'
  gem 'factory_girl_rails', '~> 2.0'
  gem 'sqlite3'
  gem 'simplecov', require: false
  gem 'rspec-rails'
  gem 'rspec-instafail'
  gem 'rspec-steps'
  gem 'factory_girl_rails', '~> 2.0'
  gem "capybara"
  gem "selenium-webdriver"
  gem 'launchy' # provides save_and_open_page
  gem 'fuubar'

  gem 'database_cleaner'
  gem 'rantly'
  gem 'heroku'
  gem 'rb-fsevent' #, :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  #gem 'spork', '~> 1.0rc'
  #gem 'guard-spork'
end

group :production do
  gem 'thin'
  gem 'pg'
end