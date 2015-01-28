require 'test_helper'

class TextMessage::AttendanceProcessorTest < ActiveSupport::TestCase
  test 'processes with a valid token for an active event' do
    member = members(:michael)
    event = events(:meetingCsc)
    text_message = stub(member: member, body: event.token)

    text_message.expects(:respond_later).with("Thanks, Michael. You're checked in for CSC Meeting.").once
    assert_difference -> { event.attendees.count }, 1 do
      TextMessage::AttendanceProcessor.process(text_message)
    end
  end

  test 'processes with a valid token for an inactive event' do
    event = events(:workshop)
    text_message = stub(body: event.token)

    text_message.expects(:respond_later).with("Oops! That doesn't look like a valid event code.").once
    assert_no_difference -> { Attendance.count } do
      TextMessage::AttendanceProcessor.process(text_message)
    end
  end

  test 'processes with an invalid token' do
    text_message = stub(body: 'invalid token')

    text_message.expects(:respond_later).with("Oops! That doesn't look like a valid event code.").once
    assert_no_difference -> { Attendance.count } do
      TextMessage::AttendanceProcessor.process(text_message)
    end
  end
end
