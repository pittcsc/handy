require 'test_helper'

class TextMessage::Receivable::AttendanceReceiverTest < ActiveSupport::TestCase
  test 'receives with a valid token for an active event' do
    member = members(:michael)
    event = events(:csc_meeting)
    text_message = stub(member: member, body: event.token)

    text_message.expects(:respond).with("Thanks, Michael. You're checked in for CSC Meeting.").once
    assert_difference -> { event.attendees.count }, 1 do
      TextMessage::Receivable::AttendanceReceiver.new(text_message).receive
    end
  end

  test 'receives with a valid token for an inactive event' do
    event = events(:workshop)
    text_message = stub(body: event.token)

    text_message.expects(:respond).with("Oops! That doesn't look like a valid event code.").once
    assert_no_difference -> { Attendance.count } do
      TextMessage::Receivable::AttendanceReceiver.new(text_message).receive
    end
  end

  test 'receives with an invalid token' do
    text_message = stub(body: 'invalid token')

    text_message.expects(:respond).with("Oops! That doesn't look like a valid event code.").once
    assert_no_difference -> { Attendance.count } do
      TextMessage::Receivable::AttendanceReceiver.new(text_message).receive
    end
  end
end
