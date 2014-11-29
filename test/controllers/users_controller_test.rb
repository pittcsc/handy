require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:jeff)
    log_in_as @user
  end

  test 'edit' do
    get :edit
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  test 'update' do
    post :update, user: { password: 'new password', password_confirmation: 'new password' }
    assert_redirected_to root_url
    assert @user.reload.authenticate('new password')
  end

  test 'update with invalid attributes' do
    post :update, user: { password: 'new password', password_confirmation: '' }
    assert_response :success
    assert_template :edit
    assert_equal @user, assigns(:user)
  end
end
