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
    assert_enqueued_jobs 1 do
      TextMessage.create!(phone_number: '+15558675309', body: 'checking in!')
    end
  end
  uses_transaction :test_processes_later

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

  test 'strips body' do
    text_message = TextMessage.create!(phone_number: '+15558675309', body: '  hello, my friend!   ')

    assert_equal 'hello, my friend!', text_message.body
  end
end
