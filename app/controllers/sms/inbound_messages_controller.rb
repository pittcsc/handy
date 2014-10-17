class Sms::InboundMessagesController < ApplicationController
  # Disable XSRF protection to allow Twilio to make POST requests.
  skip_before_action :verify_authenticity_token

  def create
    TextMessage.create!(text_message_attributes).enqueue_for_processing

    head :ok
  end

  private
    def text_message_attributes
      {
        phone_number: params[:From],
        body: params[:Body].strip
      }
    end
end
