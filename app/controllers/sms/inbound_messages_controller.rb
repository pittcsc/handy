class Sms::InboundMessagesController < ApplicationController

  # Disable XSRF protection to allow the Twilio API to make POST requests on the server
  skip_before_action :verify_authenticity_token

  def create
    InboundMessageProcessor.new(phone_number, body).process
  end

  private
    def phone_number
      params[:From]
    end

    def body
      params[:Body]
    end
end

