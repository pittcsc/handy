require 'test_helper'

class MembershipTest < ActiveSupport::TestCase

  test 'requires member_id' do
    e = Membership.new(organization: organizations(:csc))

    assert e.invalid?
  end
end
