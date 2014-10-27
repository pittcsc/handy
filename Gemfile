source 'https://rubygems.org'

gem 'rails', '4.2.0.beta2'
gem 'mysql2'

# Plugins
gem 'turbolinks'

# Assets
gem 'sprockets-rails', github: 'rails/sprockets-rails'
gem 'sass-rails', github: 'rails/sass-rails'
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

# Logging
gem 'sysloglogger', '2.0', github: 'sparklemotion/sysloglogger'

group :development do
  gem 'spring'

  # Deployment
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano3-unicorn', require: false
end

group :production do
  gem 'unicorn'
end
