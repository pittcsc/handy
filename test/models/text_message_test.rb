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
      TextMessage.incoming.create!(phone_number: '+15558675309', body: 'checking in!')
    end
  end
  uses_transaction :test_processes_later

  test 'responds' do
    assert_difference -> { TextMessage.outgoing.count } do
      text_messages(:michael_checking_in).respond('Message received!')
    end
  end

  test 'strips body' do
    text_message = TextMessage.incoming.create!(phone_number: '+15558675309', body: '  hello, my friend!   ')

    assert_equal 'hello, my friend!', text_message.body
  end
end
