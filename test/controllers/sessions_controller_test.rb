require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test 'new' do
    log_out
    get :new
    assert_response :success
  end

  test 'new for authenticated user' do
    get :new
    assert_redirected_to root_url
  end

  test 'create with correct email and password' do
    user = users(:jeff)

    post :create, email: user.email, password: valid_password
    assert_redirected_to root_url
    assert_equal user.id, session[:user_id]
  end

  test 'create with correct email and incorrect password' do
    user = users(:jeff)

    post :create, email: user.email, password: 'incorrect'
    assert_response :success
    assert_template :new
    assert_equal 'Invalid email or password.', flash[:error]
  end

  test 'create with incorrect email and password' do
    post :create, email: 'incorrect', password: 'also incorrect'
    assert_response :success
    assert_template :new
    assert_equal 'Invalid email or password.', flash[:error]
  end

  test 'destroy' do
    delete :destroy
    assert_redirected_to login_url
    assert_nil session[:user_id]
  end
end
