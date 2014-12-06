class Sms::InboundMessagesController < ApplicationController
  # Disable XSRF protection and authentication to allow Twilio to make POST requests.
  skip_before_action :verify_authenticity_token
  skip_authentication

  def create
    TextMessage.create!(text_message_attributes).process_later

    head :ok
  end

  private
    def text_message_attributes
      { phone_number: params[:From], body: params[:Body].strip }
    end
end
