require 'test_helper'

class Sms::InboundMessagesControllerTest < ActionController::TestCase
  test 'create' do
    expects_signature_validation
    expects_text_message_processing

    assert_difference -> { TextMessage.count } do
      post :create, From: '+15558675309', Body: 'hello!'
    end
    assert_response :ok
    assert_equal '+15558675309', TextMessage.last.phone_number
    assert_equal 'hello!', TextMessage.last.body
  end

  test 'create strips leading and trailing whitespace from text message bodies' do
    expects_signature_validation
    expects_text_message_processing

    post :create, From: '+15558675309', Body: '  hello, my friend!   '
    assert_response :ok
    assert_equal 'hello, my friend!', TextMessage.last.body
  end

  test 'create requires a valid Twilio request signature' do
    expects_signature_validation successful: false

    assert_no_difference -> { TextMessage.count } do
      post :create, From: '+15558675309', Body: 'hello!'
    end
    assert_response :forbidden
  end

  private
    def expects_signature_validation(successful: true)
      Twilio::Util::RequestValidator.any_instance.expects(:validate).returns(successful)
    end

    def expects_text_message_processing
      TextMessage.any_instance.expects(:process_later).once
    end
end
