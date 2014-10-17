class Sms::InboundMessagesController < ApplicationController

  # Disable XSRF protection to allow the Twilio API to make POST requests on the server
  skip_before_action :verify_authenticity_token

  def create
    TextMessage.create(text_message_attributes).process
    render nothing: true
  end

  private
    def text_message_attributes
      {
        phone_number: params[:From],
        body: params[:Body]
      }
    end
end
