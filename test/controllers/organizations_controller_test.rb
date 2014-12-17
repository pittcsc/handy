require 'test_helper'

class OrganizationControllerTest < ActionController::TestCase
  setup do
    log_in_as users(:jeff)
    @organization = organizations(:csc)
  end
end
