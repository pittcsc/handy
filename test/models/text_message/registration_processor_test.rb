require 'test_helper'

class TextMessage::RegistrationProcessorTest < ActiveSupport::TestCase
  test 'processes with a new registrant and a valid token for an active event' do
    event = events(:meeting)
    text_message = stub(phone_number: '+15557826081', registration: nil, body: event.token)

    text_message.expects(:respond).with("It looks like this is your first time checking in. What's your name?").once
    assert_difference -> { event.registrations.count }, 1 do
      TextMessage::RegistrationProcessor.new(text_message).process
    end
  end

  test 'processes with a new registrant and a valid token for an inactive event' do
    event = events(:workshop)
    text_message = stub(phone_number: '+15557826081', registration: nil, body: event.token)

    text_message.expects(:respond).with("Oops! That doesn't look like a valid event code.").once
    assert_no_difference -> { Registration.count } do
      TextMessage::RegistrationProcessor.new(text_message).process
    end
  end

  test 'processes with a new registrant and an invalid token' do
    event = events(:meeting)
    text_message = stub(registration: nil, phone_number: '+15557826081', body: 'invalid token')

    text_message.expects(:respond).with("Oops! That doesn't look like a valid event code.").once
    assert_no_difference -> { Registration.count } do
      TextMessage::RegistrationProcessor.new(text_message).process
    end
  end

  test 'processes with a registrant pending name' do
    registration = registrations(:rashid)
    text_message = stub(registration: registration, body: 'Rashid Thomas')

    text_message.expects(:respond).with("Thanks! One last question: what's your email address?").once
    TextMessage::RegistrationProcessor.new(text_message).process
    assert_equal 'Rashid Thomas', registration.reload.name
  end

  test 'processes with a registrant pending email address' do
    registration = registrations(:michelle)
    text_message = stub(registration: registration, body: 'michelle@example.com')

    text_message.expects(:respond).with("All set! You're checked in for Meeting.").once
    assert_difference -> { Member.count }, 1 do
    assert_difference -> { registration.event.attendees.count }, 1 do
    assert_difference -> { Registration.count }, -1 do
      TextMessage::RegistrationProcessor.new(text_message).process
    end
    end
    end
  end
end
