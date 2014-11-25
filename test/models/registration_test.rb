require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  setup do
    @registration = registrations(:rashid)
  end

  test 'completion creates a member' do
    @registration.complete

    assert member = Member.find_by_phone(@registration.phone_number)
    assert_equal @registration.name, member.name
    assert_equal @registration.email_address, member.email
  end

  test 'completion checks the new member in for the event' do
    @registration.complete

    assert_includes @registration.event.attendees, Member.find_by_phone(@registration.phone_number)
  end

  test 'completion destroys' do
    @registration.complete

    assert @registration.destroyed?
  end
end
