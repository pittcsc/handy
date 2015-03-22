require 'test_helper'

class Twilio::TextMessagesTest < ActionDispatch::IntegrationTest
  test 'receiving a text message from Twilio' do
    assert_difference -> { TextMessage.count } do
      post_with_signature twilio_text_messages_url, From: '+15558675309', Body: 'hello!'
    end
    assert_response :ok
    assert_equal '+15558675309', TextMessage.last.phone_number
    assert_equal 'hello!', TextMessage.last.body
  end

  test 'receiving a text message with a padded body from Twilio' do
    post_with_signature twilio_text_messages_url, From: '+15558675309', Body: '  hello, my friend!   '
    assert_response :ok
    assert_equal 'hello, my friend!', TextMessage.last.body
  end

  test 'receiving a text message requires a valid Twilio signature' do
    assert_no_difference -> { TextMessage.count } do
      post twilio_text_messages_url, From: '+15558675309', Body: 'hello!'
    end
    assert_response :forbidden
  end

  private
    def post_with_signature(path, parameters = nil, headers_or_env = nil)
      post path, parameters, headers_or_env.to_h.merge({ 'X-Twilio-Signature' => build_signature_for(path, parameters) })
    end

    def build_signature_for(path, parameters = nil)
      Twilio::Util::RequestValidator.new.build_signature_for(path, parameters)
    end
end
