require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:jeff)
  end

  test 'requires email' do
    assert @user.valid?

    @user.email = ''
    assert @user.invalid?
  end

  test 'requires unique email' do
    other_user = users(:annie)
    assert other_user.valid?

    other_user.email = @user.email
    assert other_user.invalid?
  end

  test 'authenticates with correct email and password' do
    assert_equal @user, User.authenticate(@user.email, valid_password)
  end

  test 'authenticates with correct email and incorrect password' do
    assert_not User.authenticate(@user.email, 'wrong password')
  end

  test 'authenticates with incorrect email and password' do
    assert_not User.authenticate('wrong email', 'wrong password')
  end

  test 'finds admins' do
    assert_equal [users(:jeff)], User.admin
  end
end
