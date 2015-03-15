class Sms::InboundMessagesController < ApplicationController
  # Disable XSRF protection and authentication to allow Twilio to make POST requests.
  skip_before_action :verify_authenticity_token
  skip_authentication

  before_action :validate_twilio_request

  def create
    TextMessage.create!(text_message_attributes).process_later

    head :ok
  end

  private
    def validate_twilio_request
      head :forbidden unless valid_twilio_request?
    end

    def valid_twilio_request?
      Twilio::Util::RequestValidator.new.validate(request.original_url, request.POST, request.headers['X-Twilio-Signature'].to_s)
    end

    def text_message_attributes
      { phone_number: params[:From], body: params[:Body].strip }
    end
end
