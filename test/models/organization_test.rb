require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  setup do
    @organization = organizations(:csc)
  end

  test 'requires name' do
    assert @organization.valid?

    @organzation.name = ''
    assert @organization.invalid?
  end
end
