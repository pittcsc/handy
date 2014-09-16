require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  test "should get dispatch" do
    get :dispatch
    assert_response :success
  end

end
