source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'mysql2'

# Plugins
gem 'turbolinks'
gem 'will_paginate', '~> 3.0.7'

# Assets
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass'

# Background Jobs
gem 'redis-rails'
gem 'resque-pool'
gem 'resque-scheduler'

# SMS
gem 'twilio-ruby'

# Encryption
gem 'bcrypt'

# PDF Generation
gem 'wicked_pdf'

# Monitoring
gem 'easymon', '~> 1.2.3'

group :development do
  gem 'spring'

  # Debugging
  gem 'byebug'
  gem 'web-console'

  # Testing
  gem 'guard'
  gem 'guard-minitest'
end

group :test do
  gem 'rake'
  gem 'mocha', require: false
end

group :deployment do
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rbenv'
  gem 'capistrano-rails'
end

group :production do
  gem 'unicorn'
end
