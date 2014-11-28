require 'test_helper'

class AuthenticationTest < ActionController::TestCase
  tests EventsController

  test 'requires authentication for HTML requests' do
    log_out
    session[:user_id] = nil

    get :index
    assert_redirected_to login_url
  end

  test 'requires authentication for non-HTML requests' do
    log_out
    session[:user_id] = nil

    get :index, format: :xhr
    assert_response :unauthorized
  end

  test 'finds current user' do
    user = users(:jeff)
    session[:user_id] = user.id

    get :index
    assert_response :success
  end
end
