class Twilio::TextMessagesController < Twilio::BaseController
  def create
    TextMessage.incoming.create!(text_message_attributes)

    head :ok
  end

  private
    def text_message_attributes
      { phone_number: params[:From], body: params[:Body] }
    end
end
