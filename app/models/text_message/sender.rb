class TextMessage::Sender
  def initialize(text_message)
    @text_message = text_message
  end

  def send
    Twilio::REST::Client.new.messages.create \
      from: Rails.configuration.x.twilio[:phone_number],
      to: @text_message.phone_number,
      body: @text_message.body
  end
end
