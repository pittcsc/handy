ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def valid_password
    'secret'
  end
end

class ActionController::TestCase
  setup do
    log_in_as users(:jeff)
  end

  def log_in_as(user)
    @controller.stubs(:current_user).returns(user)
  end

  def log_out
    @controller.unstub(:current_user)
  end
end

require 'mocha/mini_test'
