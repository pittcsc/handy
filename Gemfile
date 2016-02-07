source 'https://rubygems.org'
ruby '2.2.3'

# Ruby on Rails
gem 'rails', github: 'rails/rails'
gem 'rails-controller-testing'

# Data
gem 'pg'

# Plugins
gem 'turbolinks', github: 'turbolinks/turbolinks-rails'
gem 'will_paginate'

# Assets
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'bootstrap-sass'

# Background Jobs
gem 'sucker_punch'

# SMS
gem 'twilio-ruby'

# Encryption
gem 'bcrypt'

# PDF Generation
gem 'wicked_pdf', github: 'mileszs/wicked_pdf'

group :production do
  gem 'thin'
end

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
