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

  test 'requires email to be unique' do
    other_user = users(:annie)
    assert other_user.valid?

    other_user.email = @user.email
    assert other_user.invalid?
  end

  test 'authenticates' do
    assert_equal @user, User.authenticate(@user.email, valid_password)
    assert_not User.authenticate(@user.email, 'wrong password')
    assert_not User.authenticate('wrong email', 'wrong password')
  end
end
