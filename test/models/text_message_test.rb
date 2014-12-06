require 'test_helper'

class TextMessageTest < ActiveSupport::TestCase
  test 'finds member' do
    assert_equal members(:michael), text_messages(:michael_checking_in).member
  end

  test 'finds no member for new registrants' do
    assert_equal nil, text_messages(:rashid_checking_in).member
  end

  test 'finds registration' do
    assert_equal registrations(:rashid), text_messages(:rashid_checking_in).registration
  end

  test 'processes later' do
    Sms::ProcessingJob.expects(:perform_later).with(text_messages(:michael_checking_in))

    text_messages(:michael_checking_in).process_later
  end

  test 'processes as check-in with member' do
    TextMessage::AttendanceProcessor.expects(:process).with(text_messages(:michael_checking_in)).once

    text_messages(:michael_checking_in).process
  end

  test 'processes as registration without member' do
    TextMessage::RegistrationProcessor.expects(:process).with(text_messages(:rashid_checking_in)).once

    text_messages(:rashid_checking_in).process
  end

  test 'responds later' do
    Sms::DeliveryJob.expects(:perform_later).with(text_messages(:michael_checking_in).phone_number, 'Message received!')

    text_messages(:michael_checking_in).respond_later('Message received!')
  end
end
