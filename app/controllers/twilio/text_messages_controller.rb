class Twilio::TextMessagesController < Twilio::BaseController
  def create
    TextMessage.create!(text_message_attributes).process_later

    head :ok
  end

  private
    def text_message_attributes
      { phone_number: params[:From], body: params[:Body] }
    end
end
