ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include ActiveJob::TestHelper

  fixtures :all

  def valid_password
    'secret'
  end
end

class ActionController::TestCase
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

require 'mocha/mini_test'
