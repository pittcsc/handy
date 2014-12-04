source 'https://rubygems.org'

gem 'rails', '4.2.0.rc1'
gem 'mysql2'

# Plugins
gem 'turbolinks'
gem 'will_paginate', '~> 3.0.7'

# Assets
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'bootstrap-sass'

# Background Jobs
gem 'redis-rails'
gem 'resque-pool'
gem 'resque-scheduler'

# SMS
gem 'twilio-ruby'

# Encryption
gem 'bcrypt'

group :development do
  gem 'spring'

  # Deployment
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rails', require: false
end

group :test do
  gem 'rake'
  gem 'mocha', require: false
end

group :production do
  gem 'unicorn'
  gem 'sysloglogger', '2.0', github: 'sparklemotion/sysloglogger'
end
